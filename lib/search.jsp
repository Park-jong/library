<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<html>
  <head>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <%@ include file="dbconn.jsp" %>
    <table>
    	<%
      //도서검색 페이지
    		request.setCharacterEncoding("utf-8");

    		ResultSet rs = null;
    		Statement stmt = null;

        //검색 조건 (저자, 서명, 출판사)
    		String type1 = request.getParameter("type1");
        String type2 = request.getParameter("type2");
        String type3 = request.getParameter("type3");

        //입력값
        String search1 = request.getParameter("input1");
        String search2 = request.getParameter("input2");
        String search3 = request.getParameter("input3");

        //추가조건 (and, or, not)
        String option1 = request.getParameter("option1");
        String option2 = request.getParameter("option2");

        String library = request.getParameter("library");
        String start_year = request.getParameter("start");
        String end_year = request.getParameter("end");
    		try{
          //기본 검색
          String sql = "select book_id, book_name, author_name, publisher, publish_year, lib_name ,"
          +" case when loan_stat = '1' then '대출가능' else '대출 중' end as stat"
          +" from book_information inner join authors on book_information.isbn = authors.isbn"
          +" inner join books on books.isbn = book_information.isbn"
          +" inner join librarys on librarys.lib_id = books.lib_id";
          //저자는 여러명일 수 있음
          if("author_name".equals(type1)){
            sql = sql + " where authors.isbn in (select isbn from authors where author_name like '%"+search1+"%')";
          }else{
            sql = sql + " where "+type1+" like '%"+search1+"%'";
          }

          //검색2
          if(!search2.trim().isEmpty()){
            sql = sql + addSQL(type2, search2, option1);
          }
          //검색3
          if(!search3.trim().isEmpty()){
            sql = sql + addSQL(type3, search3, option2);
          }
          //소장처
          if(!library.equals("0")){
            sql = sql + " and books.lib_id = "+library;
          }
          //발행년
          if(!start_year.trim().isEmpty()){
            sql = sql + " and publish_year >= "+start_year;
          }
          if(!end_year.trim().isEmpty()){
            sql = sql + " and publish_year <= "+end_year;
          }
          sql = sql + " order by book_id";

          stmt = conn.createStatement();
	  			rs = stmt.executeQuery(sql);
          out.println("<tr>");
          out.println("<th>등록번호</th>");
          out.println("<th>서명</th>");
          out.println("<th>대표저자</th>");
          out.println("<th>출판사</th>");
          out.println("<th>발행년</th>");
          out.println("<th>도서관</th>");
          out.println("<th>대출상태</th>");
          out.println("</tr>");
          String book_id_check = "";
          while(rs.next()){
            String book_id = rs.getString("book_id");
    				String book = rs.getString("book_name");
    				String author = rs.getString("author_name");
    				String publisher = rs.getString("publisher");
    				String publish_year = rs.getString("publish_year");
    				String lib = rs.getString("lib_name");
            String stat = rs.getString("stat");
            if(!book_id.equals(book_id_check)){
    	%>
    	<tr>
        <td><%=book_id %></td>
    		<td><%=book %></td>
    		<td><%=author %></td>
    		<td><%=publisher %></td>
    		<td><%=publish_year %></td>
    		<td><%=lib %></td>
        <td><%=stat %></td>
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
    	%>
    </table>
    <a href="search.html">검색으로 돌아가기</a>
    <a href="main.jsp">메인으로 돌아가기</a>
  </body>
</html>
<%!
/** 옵션에 따른 검색 sql*/
public String addSQL(String type, String inputValue, String option){
  String sql = "";
  if(option.equals("NOT")){
    if("author_name".equals(type)){
      sql = " and authors.isbn in (select isbn from authors where author_name not like '%"+inputValue+"%')";
    }else{
      sql = " and "+type+" not like '%"+inputValue+"%'";
    }
  }
  else{
    if("author_name".equals(type)){
      sql = " " +option +" authors.isbn in (select isbn from authors where author_name like '%"+inputValue+"%')";
    }else{
      sql = " " +option +" " + type + " like '%"+inputValue+"%'";
    }
  }
  return sql;
}
%>
