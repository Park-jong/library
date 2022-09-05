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

    String name = request.getParameter("user_name");
    String pw = request.getParameter("pw");
    String email = request.getParameter("email");
    String library = request.getParameter("library");

    //입력값으로 DB에 회원 추가
    try{
        String sql = "insert into members (member_id, password, member_name, email, lib_id) values ((select count(*) from members) + 1, '"+pw+"', '"+name+"', '"+email+"', "+library+")";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);
        out.println("회원이 등록되었습니다.");
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
    %>
    <br>
    <a href="../main.jsp">메인으로 돌아가기</a>
  </body>
</html>