<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>index334</h1>
	${test }
	<br/>
	<c:forEach items="${list }" var="board">
		${board.board_no} 
	</c:forEach>
</body>
</html>