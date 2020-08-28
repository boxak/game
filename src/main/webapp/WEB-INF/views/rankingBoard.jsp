<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${gameKind} 랭킹</title>
</head>
<body>
<h2>${gameKind} 순위입니다.</h2>
<table>
<tr>
	<th>이름</th>
	<th>점수</th>
	<th>순위</th>
</tr>
<c:if test="${!empty list}">
	<c:forEach var="vo" items="${list}" varStatus="status">
		<tr>
			<td>${vo.name}</td>
			<td>${vo.score}</td>
			<td><c:out value="${status.count}"></c:out></td>
		</tr>
	</c:forEach>
</c:if>
</table>
<button onclick="location.href='${header.referer}'">뒤로 가기</button>
</body>
</html>