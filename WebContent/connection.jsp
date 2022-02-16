<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, javax.naming.InitialContext, javax.naming.Context"%>    
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<%
	Context initCtx = new InitialContext();
	Context envContext = (Context) initCtx.lookup("java:/comp/env");
	DataSource ds = (DataSource) envContext.lookup("jdbc/myoracle");
	Connection conn = ds.getConnection();
	out.println("DBCP 연동 성공");
	
%>
</body>
</html>