<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<html>
  <head>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <%@ include file="dbconn.jsp" %>
    	<%
      //도서 대출 예약 페이지
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
            //예약이 불가능 한 상황들 정리
            String sql = "select loan_stat from books where book_id = "+book_id;
            stmt = conn.createStatement();
  	  			rs = stmt.executeQuery(sql);
            //대출 불가능 상태
            String stat;
            rs.next();
            stat = rs.getString("loan_stat");
            //예약이 많을 경우
            sql = "select count(*) as count from book_reservation where member_id = "+member_id;
            rs = stmt.executeQuery(sql);
            rs.next();
            int count = Integer.parseInt(rs.getString("count"));
            //같은 책을 여러번 예약
            sql = "select count(*) as count from book_reservation where member_id = "+member_id+" and book_id = "+book_id;
            rs = stmt.executeQuery(sql);
            rs.next();
            int count2 = Integer.parseInt(rs.getString("count"));
            //연체되어 대출 불가능
            sql = "select case when stop_date > sysdate then '1' else '0' end as stop from members where member_id = "+member_id;
            rs = stmt.executeQuery(sql);
            rs.next();
            String stop = rs.getString("stop");
            //자신이 대출중인 책
            sql = "select book_id from loan_records where book_id = "+book_id +"and member_id = "+member_id +" and return_date > sysdate";
            rs = stmt.executeQuery(sql);
            boolean hasbook = rs.next();
            //상호대차를 신청한 책
            sql = "select book_id from mutual_loan where book_id = "+book_id +"and member_id = "+member_id;
            rs = stmt.executeQuery(sql);
            boolean mutual = rs.next();
            //조건에 따라 예약이 가능한 지 체크
            if(stat.equals("1")){
              out.println("해당 책은 대출 가능한 상태입니다.<br>");
              out.println("<a href=\"loan.html\">바로 대출하기</a>");
            }
            else if(count >= 3){
              out.println("예약 횟수를 초과하였습니다.<br>");
              out.println("<a href=\"reservation.html\">돌아가기</a>");
            }
            else if(count2 > 0){
              out.println("이미 예약된 책입니다.<br>");
              out.println("<a href=\"reservation.html\">돌아가기</a>");
            }
            else if("1".equals(stop)){
              out.println("연체되어 예약할 수 없습니다.<br>");
              out.println("<a href=\"reservation.html\">돌아가기</a>");
            }
            else if(hasbook){
              out.println("대출 중인 책입니다.<br>");
              out.println("<a href=\"reservation.html\">돌아가기</a>");
            }
            else if(mutual){
              out.println("상호대차 신청 중인 책입니다.<br>");
              out.println("<a href=\"reservation.html\">돌아가기</a>");
            }
            else{
              sql = "insert into book_reservation(member_id, book_id, reservation_date, reservation_end) values ("+member_id+", "+book_id+", sysdate, '29991231')";
              rs = stmt.executeQuery(sql);
              out.println("예약되었습니다.<br>");
              out.println("<br><a href=\"reservation.html\">입력으로 돌아가기</a>");
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
