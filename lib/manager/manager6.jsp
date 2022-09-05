<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="../style.css">
</head>
<body>
  <%@ include file="../dbconn.jsp" %>
  <form action='./manager7.jsp' method='post'>
    <p>상호대차 수령</p>
    <table>
      <%
      request.setCharacterEncoding("utf-8");

      ResultSet rs = null;
      Statement stmt = null;

      try{
        //상호대차 수령
        String sql = "select member_id, books.book_id as bookid, book_name, publisher, publish_year from mutual_loan inner join books on mutual_loan.book_id = books.book_id inner join book_information on books.isbn = book_information.isbn where arrival_date < sysdate and arrival_date + 4 > sysdate";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);
        out.println("<tr>");
        out.println("<th></th>");
        out.println("<th>신청자</th>");
        out.println("<th>등록번호</th>");
        out.println("<th>서명</th>");
        out.println("<th>출판사</th>");
        out.println("<th>발행년</th>");
        out.println("</tr>");
        while(rs.next()){
          String member_id = rs.getString("member_id");
          String book_id = rs.getString("bookid");
          String book = rs.getString("book_name");
          String publisher = rs.getString("publisher");
          String publish_year = rs.getString("publish_year");
    %>
    <tr>
      <td><input type="checkbox" value="<%=book_id%>" name="check"/></td>
      <td><%=member_id %></td>
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
    %>
    </table>
    <p><input type="submit" value="대출하기"></p>
  </form>
</body>
</html>
