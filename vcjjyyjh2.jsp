<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB 연동</title>
</head>

	<%
	
		String RESVNO = request.getParameter("RESVNO");
		
	%>

	<style>
		table{
			margin:Auto;
		}
		h1{
			text-align:center;
		}
		p{
			text-align:center;
		}
	</style>
		<%
		
			String RESV = request.getParameter("RESVNO");
			String PNAME="";
			String JUMIN="";
			String TEL="";
			String RESVDATE="";
			String RESVYIME="";
			String WICH="";
			String HTEL="";
			String HNAME="";
			String VC="";
			
			if("20210001".equals(RESV)){
				PNAME="이주민";
				JUMIN="710101-2000002";
				TEL="010-1234-0002";
				RESVDATE="20210901";
				RESVYIME="1030";
				WICH="나-병원";
				HTEL="1599-0002";
				HNAME="수원";
				VC="D백신";
			}
			else if("20210002".equals(RESV)){
				PNAME="박주민";
				JUMIN="790101-1000009";
				TEL="010-1234-0009";
				RESVDATE="20210901";
				RESVYIME="1730";
				WICH="다-병원";
				HTEL="1599-0002";
				HNAME="대전";
				VC="C백신";
			}
			else{
				%>
				<script>
					alert("예약번호를 확인해주세요");
					location.href="vcjjyyjh3.jsp";
				</script>
				<%
			}
		
		%>
<body>
	<table border="1">
		<h1>예약번호 : <%=RESV %>의 접종예약 조회</h1>
		<tr>
			<td>이름</td>
			<td>주민번호</td>
			<td>전화번호</td>
			<td>예약일자</td>
			<td>예약시간</td>
			<td>병원명</td>
			<td>대표전화</td>
			<td>병원주소</td>
			<td>백신종류</td>
		</tr>
		<tr>
			<td><%=PNAME %></td>
			<td><%=JUMIN %></td>
			<td><%=TEL %></td>
			<td><%=RESVDATE %></td>
			<td><%=RESVYIME %></td>
			<td><%=WICH %></td>
			<td><%=HTEL %></td>
			<td><%=HNAME %></td>
			<td><%=VC %></td>
		</tr>
	<% 
		try{
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe","system","1234");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT M.PNAME,M.JUMIN,M.TEL,V.RESVDATE,V.RESVYIME,H.WICH,H.HTEL,H.HNAME,	DECODE(V.VCODE, 'V001', 'A백신', 'V002', 'B백신', 'V003', 'C백신', 'V100', 'D백신') AS VACCINE_TYPE FROM 	member_tbl M, vaccresv_tbl V, hospital_tbl H WHERE M.JUMIN = V.JUMIN AND V.HOSPCODE = H.HOSPCODE AND V.RESVNO='?' GROUP BY M.PNAME, M.JUMIN, M.TEL, V.RESVDATE, V.RESVYIME, H.WICH, H.HTEL, H.HNAME, DECODE(V.VCODE, 'V001', 'A백신', 'V002', 'B백신', 'V003', 'C백신', 'V100', 'D백신')");
			while(rs.next()){
				out.println("<tr>");
				out.println("<td>" + rs.getString(1) + "</td>");
				out.println("<td>" + rs.getString(2) + "</td>");
				out.println("<td>" + rs.getString(3) + "</td>");
				out.println("<td>" + rs.getString(4) + "</td>");
				out.println("<td>" + rs.getString(5) + "</td>");
				out.println("<td>" + rs.getString(6) + "</td>");
				out.println("<td>" + rs.getString(7) + "</td>");
				out.println("<td>" + rs.getString(8) + "</td>");
				out.println("<td>" + rs.getString(9) + "</td>");
				out.println("</tr>");
			}
			
		stmt.close();
		rs.close();
		con.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	%>

	</table>
	<p><button>돌아가기</button></p>
</body>
</html>