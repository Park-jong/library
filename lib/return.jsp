<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <%@ include file="dbconn.jsp" %>
  <form action='./return_result.jsp' method='post'>
    <p>반납</p>
    <table>
      <%
      //반납 페이지
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
          //현재 대출중인 책 출력
          String sql = "select books.book_id as bookid, book_name, publisher, publish_year from book_information inner join books on books.isbn = book_information.isbn inner join loan_records on books.book_id = loan_records.book_id where return_date > sysdate and member_id = "+member_id;
          stmt = conn.createStatement();
          rs = stmt.executeQuery(sql);

          out.println("<tr>");
          out.println("<th></th>");
          out.println("<th>등록번호</th>");
          out.println("<th>서명</th>");
          out.println("<th>출판사</th>");
          out.println("<th>발행년</th>");
          out.println("</tr>");
          while(rs.next()){
            String book_id = rs.getString("bookid");
            String book = rs.getString("book_name");
            String publisher = rs.getString("publisher");
            String publish_year = rs.getString("publish_year");
      %>
      <tr>
        <td><input type="checkbox" value=<%=book_id%> name="check"/></td>
        <td><%=book_id %></td>
        <td><%=book %></td>
        <td><%=publisher %></td>
        <td><%=publish_year %></td>
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
    <p><input type="submit" value="반납하기"></p>
  </form>
</body>
</html>
