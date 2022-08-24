<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<html>
  <head>
  </head>
  <body>
    <%@ include file="../dbconn.jsp" %>
    	<%
    		request.setCharacterEncoding("utf-8");

    		ResultSet rs = null;
    		Statement stmt = null;

        String values[] = request.getParameterValues("check");
        if(values == null){
          out.println("선택된 책이 없습니다.<br>");
        }
        else{
      		try{
            //상호대차 대출상채로 변경
            for(int i = 0; i < values.length; i++){
              String sql = "select member_id, books.book_id as bookid from mutual_loan inner join books on mutual_loan.book_id = books.book_id inner join book_information on books.isbn = book_information.isbn where arrival_date < sysdate and arrival_date + 4 > sysdate and books.book_id ="+ values[i];
              stmt = conn.createStatement();
              rs = stmt.executeQuery(sql);
              rs.next();
              String member_id = rs.getString("member_id");
              String book_id = rs.getString("bookid");
              sql = "update books set loan_stat = '0' where book_id = "+book_id;
              rs = stmt.executeQuery(sql);
              sql = "INSERT INTO LOAN_RECORDS(MEMBER_ID,BOOK_ID, LOAN_DATE,EXTENSION) VALUES ("+member_id+", "+book_id+", SYSDATE, 0)";
              rs = stmt.executeQuery(sql);
              sql = "delete from mutual_loan where book_id = "+book_id+" and member_id = "+member_id;
              rs = stmt.executeQuery(sql);
              out.println("대출이 완료되었습니다.");
            }
      		}catch (SQLException ex){
      			out.println("테이블 호출이 실패했습니다.<br>");
      			out.println("SQLException:"+ex.getMessage());
      		}finally{
      			if(rs!=null)
      				rs.close();
      			if(stmt!=null)
      				stmt.close();
      			if(conn!=null)
      				conn.close();
      		}
        }
    	%>
    <br>
    <a href="../main.jsp">메인으로 돌아가기</a>
  </body>
</html>
