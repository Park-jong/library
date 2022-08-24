<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%
session.invalidate();
response.sendRedirect("main.jsp");
%>
