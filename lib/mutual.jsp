<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="style.css">
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
</head>
<body>
  <%@ include file="dbconn.jsp" %>
  <form action='./mutual_result.jsp' method='post' id='submit'>
    <p>상호대차</p>
    <select name="library" required>
      <option value="1">1번 도서관</option>
      <option value="2">2번 도서관</option>
      <option value="3">3번 도서관</option>
      <option value="4">4번 도서관</option>
      <option value="5">5번 도서관</option>
    </select>
    <table>
      <%
      request.setCharacterEncoding("utf-8");

      ResultSet rs = null;
      Statement stmt = null;

      String member_id = (String)session.getAttribute("id");
      String input = request.getParameter("input");
      //올바르지 않은 접근 login으로
      if(member_id == null){
        response.sendRedirect("login.html");
      }
      else{
        try{
          //겅색해서 대출가능한 책만 보여주기
          String sql = "select books.book_id as bookid, book_name, author_name, publisher, publish_year from book_information inner join books on books.isbn = book_information.isbn inner join authors on authors.isbn = book_information.isbn"
          +" where (publisher like '%"+input+"%' or book_name like '%"+input+"%' or author_name like '%"+input+"%') and loan_stat = '1' order by books.book_id";
          stmt = conn.createStatement();
          rs = stmt.executeQuery(sql);

          out.println("<tr>");
          out.println("<th>등록번호</th>");
          out.println("<th>서명</th>");
          out.println("<th>저자</th>");
          out.println("<th>출판사</th>");
          out.println("<th>발행년</th>");
          out.println("<th></th>");
          out.println("</tr>");
          String book_id_check = "";
          while(rs.next()){
            String book_id = rs.getString("bookid");
    				String book = rs.getString("book_name");
            String author_name = rs.getString("author_name");
    				String publisher = rs.getString("publisher");
    				String publish_year = rs.getString("publish_year");
            if(!book_id_check.equals(book_id)){
    	%>
    	<tr>
        <td><%=book_id %></td>
    		<td><%=book %></td>
        <td><%=author_name %></td>
    		<td><%=publisher %></td>
    		<td><%=publish_year %></td>
        <td><input type="button" value="상호대차신청하기" class="btn" name="<%=book_id%>"></td>
    	</tr>
    	<%
              book_id_check = book_id;
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
    </table>
    <input type="hidden" id="hidden_val" name="val">
  </form>
  <script src="mutual.js?ver='1'"></script>
</body>
</html>
