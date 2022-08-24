<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
  <meta charset="utf-8">
</head>
<body>
  <%@ include file="dbconn.jsp"%>
  <%//사용자 선택에 따른 처리 페이지%>

  <p>예약 취소</p>

      <%
      
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
        out.println("선택한 목록이 없습니다.<br>");
        out.println("<a href=\"cancel.jsp\">선택으로 돌아가기</a>");
      }
      else{
        try{
          String sql;
          //반복분을 통해 예약을 지우고 예약 상태 변경
          for(int i = 0; i < values.length; i++){
            sql = "delete from book_reservation where member_id = "+member_id+" and book_id = "+ values[i];
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            //예약이 있는지 체크
            sql = "select * from book_reservation where book_id = "+values[i];
            rs = stmt.executeQuery(sql);
            boolean check = rs.next();
            //현재 대출중인지
            sql = "select * from loan_records where book_id = "+values[i] + " and return_date > sysdate";
            rs = stmt.executeQuery(sql);
            boolean check2 = rs.next();

            if(!check && !check2){
              sql = "update books set loan_stat = '1' where book_id = "+values[i];
              rs = stmt.executeQuery(sql);
            }
          }
          out.println("취소가 완료되었습니다.<br>");
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
  </form>
  <a href="main.jsp">메인으로 돌아가기</a>
</body>
</html>
