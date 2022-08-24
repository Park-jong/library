<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../dbconn.jsp" %>
<%
request.setCharacterEncoding("utf-8");

ResultSet rs = null;
Statement stmt = null;
try{
  //예약 관리
  String sql = "select book_id, member_id from book_reservation where reservation_end < sysdate order by book_id, reservation_date";
  stmt = conn.createStatement();
  rs = stmt.executeQuery(sql);
  List<String> book_list = new ArrayList<String>();
  List<String> member_list = new ArrayList<String>();

  while(rs.next()){
    String book_id = rs.getString("book_id");
    String member_id = rs.getString("member_id");
    book_list.add(book_id);
    member_list.add(member_id);
  }
  for(int i =0; i < book_list.size(); i++){
    sql = "delete from book_reservation where book_id = "+book_list.get(i)+" and member_id = "+member_list.get(i);
    rs = stmt.executeQuery(sql);

    sql = "select * from book_reservation where book_id = "+book_list.get(i);
    rs = stmt.executeQuery(sql);

    if(rs.next()){
      sql = "update book_reservation set  reservation_end = sysdate + 1 where member_id = (select member_id from (select * from book_reservation where book_id = "+book_list.get(i)+" order by reservation_date) where rownum = 1) and book_id = "+book_list.get(i);
      rs = stmt.executeQuery(sql);
    }
    else{
      sql = "update books set loan_stat = '1' where book_id = "+book_list.get(i);
      rs = stmt.executeQuery(sql);
    }
  }
  //상호대차 관리
  sql = "select book_id , member_id from mutual_loan where arrival_date + 4 < sysdate";
  rs = stmt.executeQuery(sql);
  List<String> del_list = new ArrayList<String>();
  List<String> del_list_member = new ArrayList<String>();

  while(rs.next()){
    String book_id = rs.getString("book_id");
    String member_id = rs.getString("member_id");
    del_list.add(book_id);
    del_list_member.add(member_id);
  }
  for(int i = 0; i < del_list.size(); i++){
    //기간지나면 상호대차 삭제
    sql = "delete from mutual_loan where book_id = "+del_list.get(i);
    rs = stmt.executeQuery(sql);
    //상호대차 정지
    sql = "update members set mutual_stop_date = sysdate + 10 where member_id = "+del_list_member.get(i);
    rs = stmt.executeQuery(sql);
    //예약상태 업데이트
    if(rs.next()){
      sql = "update book_reservation set  reservation_end = sysdate + 1 where member_id = (select member_id from (select * from book_reservation where book_id = "+del_list.get(i)+" order by reservation_date) where rownum = 1) and book_id = "+del_list.get(i);
      rs = stmt.executeQuery(sql);
    }
    //예약없으면 대출가능 상태
    else{
      sql = "update books set loan_stat = '1' where book_id = "+del_list.get(i);
      rs = stmt.executeQuery(sql);
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
response.sendRedirect("../main.jsp");
%>
