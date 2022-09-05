<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="main.css">
</head>
<body>
    <%@ include file="dbconn.jsp"%>
    <%
    request.setCharacterEncoding("utf-8");
    String member_id = (String)session.getAttribute("id");
    if(member_id != null){
      out.println("<p>회원 번호 : "+member_id+"</p>");
      ResultSet rs = null;
      Statement stmt = null;
      try{
        //예약된 도서 차례오면 출력
        String sql = "select book_name from book_reservation inner join books on books.book_id = book_reservation.book_id inner join book_information on books.isbn = book_information.isbn where member_id = "+member_id+" and reservation_end > sysdate and reservation_end < sysdate + 1";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);

        while(rs.next()){
          String book_name = rs.getString("book_name");
          out.println("<p>현재 \""+book_name+"\" 대출이 가능합니다.</p>");
        }
        //상호대차 도착하면 출력
        sql = "select book_name from mutual_loan inner join books on books.book_id = mutual_loan.book_id inner join book_information on books.isbn = book_information.isbn where member_id = "+member_id+" and arrival_date < sysdate and arrival_date + 4 > sysdate";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);
        if(rs.next()){
          String book_name = rs.getString("book_name");
          out.println("<p>현재 상호대차 신청한 \""+book_name+"\" 도착했습니다.</p>");
        }
      }
      catch (SQLException ex){
        out.println("SQLException:"+ex.getMessage());
      }finally{
        if(rs!=null)
          rs.close();
        if(stmt!=null)
          stmt.close();
        if(conn!=null)
          conn.close();
      }
      out.println("<p></p>");
    }

    if(member_id == null){
      out.println("<button onclick=\"location.href='login.html'\">로그인</button>");
    }else{
      out.println("<button onclick=\"location.href='logout.jsp'\">로그아웃</button>");
    }
  %>
    <button onclick="location.href='search.html'">도서 검색</button>
    <button onclick="location.href='loan.html'">도서 대출</button>
    <button onclick="location.href='extension.jsp'">대출 연장</button>
    <button onclick="location.href='reservation.html'">도서 예약</button>
    <button onclick="location.href='cancel.jsp'">예약 취소</button>
    <button onclick="location.href='return.jsp'">도서 반납</button>
    <button onclick="location.href='record.html'">대출기록</button>
    <button onclick="location.href='mutual.html'">상호대차신청</button>
    <button onclick="location.href='mutual_cancel.jsp'">상호대차취소</button>
    <p></p>
    <div id="manageroption">
        <p>관리자메뉴</p>
        <p>
            <button onclick="location.href='./manager/signup.html'">회원 등록</button>
            <button onclick="location.href='./manager/manager1.jsp'">상호대차도착</button>
            <button onclick="location.href='./manager/manager3.jsp'">새로고침</button>
            <button onclick="location.href='./manager/manager4.jsp'">예약수령</button>
            <button onclick="location.href='./manager/manager6.jsp'">상호대차수령</button>
        </p>
    </div>
</body>
</html>
