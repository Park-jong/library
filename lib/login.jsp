<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>

<html>
<head>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<%
      //로그인 처리 페이지
    		request.setCharacterEncoding("utf-8");

    		ResultSet rs = null;
    		Statement stmt = null;

        	String member_id = request.getParameter("member_id");
    		String pw = request.getParameter("pw");
    		try{
          		//sql
          		String sql = "select member_id, password from members where member_id = "+member_id;
          		stmt = conn.createStatement();
	  			rs = stmt.executeQuery(sql);
				//id가 존재하지 않음
          		if(!rs.next()){
            	%><script>
					alert("아이디와 비밀번호를 다시 확인해 주세요.");
					location.href = "login.html";
				</script><%
    			}

          		//id가 존재
          		else{
            		String pwcheck = rs.getString("password");
            		//로그인 성공
            		if(pw.equals(pwcheck)){
              			session.setAttribute("id", member_id);
              			response.sendRedirect("main.jsp");
            		}
            		//패스워드 틀림
            		else{
              			%><script>
						alert("아이디와 비밀번호를 다시 확인해 주세요.");
						location.href = "login.html";
						</script><%
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
	<br>
</body>
</html>
