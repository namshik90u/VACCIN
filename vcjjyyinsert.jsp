<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ycjjyy.html INSERT</title>
</head>
<body>
	<% /* 자바 DB 연동 프로그램 */
		
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe","system","1234");
			PreparedStatement stmt = con.prepareStatement("INSERT INTO vaccresv_tbl VALUES(?,?,?,?,?,?)");
				stmt.setString(1, request.getParameter("RESVNO"));
				stmt.setString(2, request.getParameter("JUMIN"));
				stmt.setString(3, request.getParameter("VCODE"));
				stmt.setString(4, request.getParameter("HOSPCODE"));
				stmt.setString(5, request.getParameter("RESVDATE"));
				stmt.setString(6, request.getParameter("RESVYIME"));
			stmt.execute();
	%>
	<a href="vcjjyy.html">돌아가기</a>
</body>
</html>