<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<html>
  <head>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <%@ include file="dbconn.jsp" %>
    	<%
      //반납 처리 페이지
    		request.setCharacterEncoding("utf-8");

    		ResultSet rs = null;
    		Statement stmt = null;

        String member_id = (String)session.getAttribute("id");
        String values[] = request.getParameterValues("check");
        //올바르지 않은 접근 login으로
        if(member_id == null){
          response.sendRedirect("login.html");
        }
        else if(values == null){
          out.println("선택된 책이 없습니다.<br>");
          out.println("<a href=\"return.jsp\">선택으로 돌아가기</a>");
        }
        else{
      		try{
            for(int i = 0; i < values.length; i++){
              //연체 여부 확인후 가져옴
              String sql = "select case when loan_date + (10* (extension+1)) < sysdate then trunc(sysdate - (loan_date + (10* (extension+1)))) else 0 end as stop from loan_records where book_id = "+values[i]+" and member_id = "+ member_id + " and return_date > sysdate";
              stmt = conn.createStatement();
    	  			rs = stmt.executeQuery(sql);

              if(rs.next()){
                int stopday = Integer.parseInt(rs.getString("stop"));

                //연체됐으면 기한만큼 대출 불가
                if(stopday > 0){
                  sql = "update members set stop_date = case when stop_date > sysdate then stop_date + "+stopday+" else sysdate + "+stopday+" end where member_id = "+member_id;
        	  			rs = stmt.executeQuery(sql);
                }

                //대출기록
                sql = "update loan_records set return_date = sysdate where book_id = "+values[i]+" and member_id = "+ member_id + " and return_date > sysdate";
      	  			rs = stmt.executeQuery(sql);


                //예약한 사람이 없으면 대출가능 상태로 업데이트
                sql = "select * from book_reservation where book_id = "+values[i];
      	  			rs = stmt.executeQuery(sql);
                if(!rs.next()){
                  sql = "update books set loan_stat = '1' where book_id = "+values[i];
        	  			rs = stmt.executeQuery(sql);
                }
                else{
                  sql = "update book_reservation set  reservation_end = sysdate + 1 where member_id = (select member_id from (select * from book_reservation where book_id = "+values[i]+" order by reservation_date) where rownum = 1) and book_id = "+values[i];
                  rs = stmt.executeQuery(sql);
                }
              }
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
    <a href="main.jsp">메인으로 돌아가기</a>
  </body>
</html>
