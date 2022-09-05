<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <%@ include file="dbconn.jsp" %>

  <p>상호대차취소</p>
  <form action='./mutual_cancel_result.jsp' method='post'>
  <table>
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
        try{
          //상호대차 목록
          String sql = "select books.book_id, book_name from mutual_loan inner join books on mutual_loan.book_id = books.book_id inner join book_information on books.isbn = book_information.isbn where member_id = "+ member_id;
          stmt = conn.createStatement();
          rs = stmt.executeQuery(sql);

          out.println("<tr>");
          out.println("<th></th>");
          out.println("<th>등록번호</th>");
          out.println("<th>서명</th>");
          out.println("</tr>");
          while(rs.next()){
            String book_id = rs.getString("book_id");
            String book = rs.getString("book_name");
      %>
      <tr>
        <td><input type="checkbox" name="check" value="<%=book_id %>"></td>
        <td><%=book_id %></td>
        <td><%=book %></td>
      </tr>
      <%
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
  <input type="submit" value="상호대차취소">
  </form>
  <a href="main.jsp">메인으로 돌아가기</a>
</body>
</html>
