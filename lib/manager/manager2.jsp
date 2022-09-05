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
          response.sendRedirect("main.jsp");
        }
        else{
          try{
            for(int i = 0; i < values.length; i++){
              //도착일 설정
              String sql = "update mutual_loan set arrival_date = sysdate where book_id = "+ values[i];
              stmt = conn.createStatement();
              rs = stmt.executeQuery(sql);
              out.println("도서 도착 완료<br>");
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
