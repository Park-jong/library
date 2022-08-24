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
      //대출기록 확인 페이지
    		request.setCharacterEncoding("utf-8");

    		ResultSet rs = null;
    		Statement stmt = null;
        //유저id
        String member_id = (String)session.getAttribute("id");
        //검색 조건 (저자, 서명) 1,2
    		String type1 = request.getParameter("type1");
        String type2 = request.getParameter("type2");
        //검색 조건의 입력 값
        String search1 = request.getParameter("input1");
        String search2 = request.getParameter("input2");

        String library = request.getParameter("library");
        String start = request.getParameter("start");
        String end = request.getParameter("end");
        if(member_id == null){
          response.sendRedirect("login.html");
        }
        else{
      		try{
            //기본 sql
            String sql = "select books.book_id as book_id, book_name, author_name, publisher, publish_year, lib_name , to_char(loan_date) as loan_date, case when return_date > sysdate then '대출 중' else to_char(return_date) end as return_date"
            +" from book_information inner join authors on book_information.isbn = authors.isbn"
            +" inner join books on books.isbn = book_information.isbn"
            +" inner join librarys on librarys.lib_id = books.lib_id"
            +" inner join loan_records on loan_records.book_id = books.book_id where member_id = "+member_id;
            
            //검색 조건1
            if(!search1.trim().isEmpty()){
              if("author_name".equals(type1)){
                sql = sql + " and authors.isbn in (select isbn from authors where author_name like '%"+search1+"%')";
              }else{
                sql = sql + " and "+type1+" like '%"+search1+"%'";
              }
            }

            //검색 조건2
            if(!search2.trim().isEmpty()){
              if("author_name".equals(type2)){
                sql = sql + " and authors.isbn in (select isbn from authors where author_name like '%"+search2+"%')";
              }else{
                sql = sql + " and " + type2 + " like '%"+search2+"%'";
              }
            }
            //소장처
            if(!library.equals("0")){
              sql = sql + " and books.lib_id = "+library;
            }
            //시작 기간
            if(!start.trim().isEmpty()){
              sql = sql + " and loan_date >= to_date('"+start+"')";
            }
            //끝 기간
            if(!end.trim().isEmpty()){
              sql = sql + " and loan_date <= to_date('"+end+"')";
            }
            sql = sql + " order by book_id, loan_date, author_name";
            //위 조건에 해당하는 책들 출력
            stmt = conn.createStatement();
  	  			rs = stmt.executeQuery(sql);
            out.println("<tr>");
            out.println("<th>등록번호</th>");
            out.println("<th>서명</th>");
            out.println("<th>대표저자</th>");
            out.println("<th>출판사</th>");
            out.println("<th>발행년</th>");
            out.println("<th>도서관</th>");
            out.println("<th>대출일자</th>");
            out.println("<th>반납일자</th>");
            out.println("</tr>");
            String book_id_check = "";
            String date_check = "";
            while(rs.next()){
              String book_id = rs.getString("book_id");
      				String book = rs.getString("book_name");
      				String author = rs.getString("author_name");
      				String publisher = rs.getString("publisher");
      				String publish_year = rs.getString("publish_year");
      				String lib = rs.getString("lib_name");
              String loan_date = rs.getString("loan_date");
              String return_date = rs.getString("return_date");
              if(!book_id.equals(book_id_check) || !loan_date.equals(date_check)){
      	%>
      	<tr>
          <td><%=book_id %></td>
      		<td><%=book %></td>
      		<td><%=author %></td>
      		<td><%=publisher %></td>
      		<td><%=publish_year %></td>
      		<td><%=lib %></td>
          <td><%=loan_date %></td>
          <td><%=return_date %></td>
      	</tr>
      	<%
                book_id_check = book_id;
                date_check = loan_date;
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
    <a href="record.html">검색으로 돌아가기</a>
    <a href="main.jsp">메인으로 돌아가기</a>
  </body>
</html>
