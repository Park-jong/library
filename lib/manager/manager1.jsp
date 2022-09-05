<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<html>
  <head>
  </head>
  <body>
    <%@ include file="../dbconn.jsp" %>
    <form action='./manager2.jsp' method='post'>
    <table>
      <%
        request.setCharacterEncoding("utf-8");

        ResultSet rs = null;
        Statement stmt = null;


        try{
          //기본 sql
          String sql = "select * from mutual_loan where arrival_date > sysdate";
          stmt = conn.createStatement();
          rs = stmt.executeQuery(sql);
            //상호대차 신청 목록
          out.println("<tr><th></th><th>등록번호</th></tr>");
          while(rs.next()){
            String book = rs.getString("book_id");
            out.println("<tr><td><input type='checkbox' value='"+book+"' name='check'></td><td>"+book+"</td></tr>");
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
      %>
    </table>
    <input type="submit" value="제출">
    </form>
    <a href="../main.jsp">메인으로 돌아가기</a>
  </body>
</html>
