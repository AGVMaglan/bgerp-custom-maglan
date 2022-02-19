<%@ page import="java.util.Enumeration"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<div class="center1020">

	<c:set var="dbInfo" value="${ctxPluginManager.pluginMap['bgbilling'].dbInfoManager.dbInfoMap['test']}"/>
	
	<%-- в случае, если Slave база не настроена - будет использована обычная --%>
	<sql:query var="result" dataSource="${dbInfo.connectionPool.dataSource}">

	SELECT COUNT(comment) AS "Препредпредыдущий",
		(SELECT COUNT(comment)
		    FROM contract 
		    WHERE MONTH(date1) = MONTH(DATE_ADD(NOW(), INTERVAL -2 MONTH)) 
			AND YEAR(date1) = YEAR(NOW()) 
			AND gr & 1081004648040234863 > 0 
			AND del=0) AS "Предпредыдущий",
		(SELECT COUNT(comment)
		    FROM contract 
		    WHERE MONTH(date1) = MONTH(DATE_ADD(NOW(), INTERVAL -1 MONTH)) 
			AND YEAR(date1) = YEAR(NOW()) 
			AND gr & 1081004648040234863 > 0 
			AND del=0) AS "Предыдущий",
		(SELECT COUNT(comment)
		    FROM contract 
		    WHERE MONTH(date1) = MONTH(DATE_ADD(NOW(), INTERVAL -0 MONTH)) 
			AND YEAR(date1) = YEAR(NOW()) 
			AND gr & 1081004648040234863 > 0 
			AND del=0) AS "Текущий"
																																				    
		    FROM contract, (SELECT @row_number:=0) AS t  
		    WHERE MONTH(date1) = MONTH(DATE_ADD(NOW(), INTERVAL -3 MONTH)) AND YEAR(date1) = YEAR(NOW()) AND gr & 1081004648040234863 > 0 AND del=0
																																						    
		
	</sql:query>
		
	<table style="width: 100%;" class="data mt1">
		<tr>
			<td>Предпредпредыдущий</td>
			<td>Предпредыдущий</td>
			<td>Предыдущий</td>
			<td>Текущий</td> 
		</tr>	

		<c:forEach var="row" items="${result.rowsByIndex}">
			<tr>
				<td>${row[0]}</td>
				<td>${row[1]}</td>
				<td>${row[2]}</td>
				<td>${row[3]}</td>
			
			</tr>			
		</c:forEach>
	</table>
</div>