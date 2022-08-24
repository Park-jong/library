<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
  <meta charset="utf-8">
</head>
<body>
  <%@ include file="dbconn.jsp" %>

  <p>상호대차</p>
  <table>
      <%
      request.setCharacterEncoding("utf-8");

      ResultSet rs = null;
      Statement stmt = null;

      String member_id = (String)session.getAttribute("id");
      String book_id = request.getParameter("val");
      String lib_id = request.getParameter("library");
      //올바르지 않은 접근 login으로
      if(member_id == null){
        response.sendRedirect("login.html");
      }
      else{
        try{
          //싱호대차 있는지 확인
          String sql = "select * from mutual_loan where member_id = "+member_id;
          stmt = conn.createStatement();
          rs = stmt.executeQuery(sql);

          boolean mutual_check = rs.next();

          if(mutual_check){
            out.println("이미 상호대차를 신청하였습니다.<br>");
            out.println("<a href=\"mutual.html\">검색으로 돌아가기</a>");
          }
          //신청 완료 테이블에 추가, 대출 불가능 상태로 변경
          else{
            sql = "INSERT INTO MUTUAL_LOAN(MEMBER_ID,BOOK_ID,ARRIVAL_DATE, lib_id) VALUES ("+member_id+","+book_id+",'29991231', "+lib_id+")";
            rs = stmt.executeQuery(sql);

            sql = "update books set loan_stat = '0' where book_id = "+book_id;
            rs = stmt.executeQuery(sql);
            out.println("상호대차를 신청이 완료되었습니다.<br>");
            out.println("<a href=\"mutual.html\">검색으로 돌아가기</a>");
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
  </table>
  <input type="hidden" id="hidden_val">
  <a href="main.jsp">메인으로 돌아가기</a>
</body>
</html>
