<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>

<html>
<head>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<%
      //대출 페이지
    		request.setCharacterEncoding("utf-8");

    		ResultSet rs = null;
    		Statement stmt = null;

        String member_id = (String)session.getAttribute("id");
        //올바르지 않은 접근 login으로
        if(member_id == null){
          response.sendRedirect("login.html");
        }
        else{
      		String book_id = request.getParameter("book_id");

      		try{
            //입력한 도서 상태 확인
            String sql = "select loan_stat from books where book_id = "+book_id;

            stmt = conn.createStatement();
  	  			rs = stmt.executeQuery(sql);

            if(!rs.next()){
              out.println("해당하는 책이 존재하지 않습니다. 다시 입력해주세요.");
              out.println("<br><a href=\"loan.html\">입력으로 돌아가기</a>");
      			}
            else{
              String stat = rs.getString("loan_stat");
              if(!stat.equals("1")){
                out.println("해당하는 책이 이미 대여 중 입니다. 다시 입력해주세요.");
                out.println("<br><a href=\"loan.html\">입력으로 돌아가기</a>");
              }
              else{
                //현재 대출 수
                sql = "select count(*) as count from loan_records where member_id = "+member_id+" and return_date > sysdate";
      	  			rs = stmt.executeQuery(sql);
                int count = 0;
                if(rs.next()){
                  count = Integer.parseInt(rs.getString("count"));
                }
                //대출 정지면 대출 못함
                sql = "select case when stop_date > sysdate then '1' else '0' end as stop from members where member_id = "+member_id;
                rs = stmt.executeQuery(sql);
                String stop = "";

                if(rs.next()){
                  stop = rs.getString("stop");
                }

                if(count >= 3){
                  out.println("이미 대여할 수 있는 최대치를 대여하였습니다.");
                }
                else if(stop.equals("1")){
                  out.println("연체되어 대여할 수 없습니다.");
                }
                else{
                  sql = "update books set loan_stat = '0' where book_id = "+book_id;
          	  		rs = stmt.executeQuery(sql);
                  sql = "INSERT INTO LOAN_RECORDS(MEMBER_ID,BOOK_ID, LOAN_DATE,EXTENSION) VALUES ("+member_id+", "+book_id+", SYSDATE, 0)";
          	  		rs = stmt.executeQuery(sql);
                  out.println("대출이 완료되었습니다.");
                  out.println("<br><a href=\"loan.html\">입력으로 돌아가기</a>");
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
