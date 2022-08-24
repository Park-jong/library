<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <%@ include file="dbconn.jsp"%>
  <%//대출 기간 연장 페이지%>
  <form action='./extension_result.jsp' method='post'>
    <p>대출 기간 연장</p>
    <table>
      <%
      request.setCharacterEncoding("utf-8");

      ResultSet rs = null;
      Statement stmt = null;
      String member_id = (String)session.getAttribute("id");


      if(member_id == null){
        response.sendRedirect("login.html");
      }
      else{
        try{
          //대출중인 목록 불러오기
          String sql = "select books.book_id as bookid, book_name, publisher, publish_year, extension, to_char(loan_date + ((1 + extension)*10)) as returndate from books inner join book_information on books.isbn = book_information.isbn inner join loan_records on loan_records.book_id = books.book_id where member_id = " + member_id+" and sysdate < return_date";
          stmt = conn.createStatement();
          rs = stmt.executeQuery(sql);
          out.println("<tr>");
          out.println("<th>등록번호</th>");
          out.println("<th>서명</th>");
          out.println("<th>출판사</th>");
          out.println("<th>발행년</th>");
          out.println("<th>연장 횟수</th>");
          out.println("<th>반납예정일</th>");
          out.println("</tr>");
          while(rs.next()){
            String book_id = rs.getString("bookid");
    				String book = rs.getString("book_name");
    				String publisher = rs.getString("publisher");
    				String publish_year = rs.getString("publish_year");
            String extension = rs.getString("extension");
            String returndate = rs.getString("returndate");
    	%>
    	<tr>
        <td><%=book_id %></td>
    		<td><%=book %></td>
    		<td><%=publisher %></td>
    		<td><%=publish_year %></td>
        <td><%=extension %></td>
        <td><%=returndate %></td>
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
    <p><input type="text" name="book_id" pattern="^[0-9]*$" required></p>
    <p><input type="submit" value="연장하기"></p>
  </form>
</body>
</html>
