<%@ page import="java.util.Enumeration"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<div class="center1020">

	<c:set var="dbInfo" value="${ctxPluginManager.pluginMap['bgbilling'].dbInfoManager.dbInfoMap['test']}"/>
	
	<%-- в случае, если Slave база не настроена - будет использована обычная --%>
	<sql:query var="result" dataSource="${dbInfo.connectionPool.dataSource}">
		SELECT t2.title AS list, count(*) AS free_key
		FROM oem_key AS t1 LEFT JOIN oem_key_list AS t2 ON t1.lid=t2.id
		WHERE cid = -1 GROUP BY lid
	</sql:query>
		
	<table style="width: 100%;" class="data mt1">
		<tr>
			<td>Название продукта</td>
			<td>Остаток</td>
		</tr>	

		<c:forEach var="row" items="${result.rowsByIndex}">
			<tr>
				<td>${row[0]}</td>
				<td>${row[1]}</td>
			</tr>			
		</c:forEach>
	</table>
</div>