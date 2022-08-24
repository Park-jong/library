<%@ page import="java.sql.*" %>

<%
//데이터베이스 접속
	Connection conn = null;
	String url ="";			//DB url
	String user = "";		//DB id
	String password = "";	//DB pw
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, password);
%>
