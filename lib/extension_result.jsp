<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>

<html>
<head>
</head>
<body>
  <%@ include file="dbconn.jsp"%>
  <%//연장 신청 결과%>
  <%
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
            //체크한 목록 조건에 맞으면 연장
            String sql = "select extension from loan_records where book_id = "+book_id +" and member_id = "+member_id;
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            if(rs.next()){
              int extension = Integer.parseInt(rs.getString("extension"));
              sql = "select count(*) as count from book_reservation where book_id = "+book_id;
              rs = stmt.executeQuery(sql);

              int count = 0;
              if(rs.next()){
                count = Integer.parseInt(rs.getString("count"));
              }

              if(extension >= 2){
                out.println("연장 횟수를 초과하였습니다.<br>");
                out.println("<a href=\"extension.jsp\">입력으로 돌아가기</a>");
              }
              else if(count > 0){
                out.println("예약된 순서가 존재하여 연장할 수 없습니다.<br>");
                out.println("<a href=\"extension.jsp\">입력으로 돌아가기</a>");
              }
              else{
                sql = "update loan_records set extension = extension + 1 where member_id = "+member_id+" and book_id = "+book_id;
                rs = stmt.executeQuery(sql);
                out.println("연장되었습니다.<br>");
                out.println("<a href=\"extension.jsp\">입력으로 돌아가기</a>");
              }
            }
            else{
              out.println("해당하는 책이 없습니다.<br>");
              out.println("<a href=\"extension.jsp\">입력으로 돌아가기</a>");
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
