<%@ page import="java.util.Enumeration"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<div class="center1020">

	<c:set var="dbInfo" value="${ctxPluginManager.pluginMap['bgbilling'].dbInfoManager.dbInfoMap['test']}"/>
	
	<%-- в случае, если Slave база не настроена - будет использована обычная --%>
	<sql:query var="result" dataSource="${dbInfo.connectionPool.dataSource}">

	SELECT contract.id AS cid, contract.title, contract.comment, contract.status_date 
	    FROM contract 
		    WHERE date2 IS NULL
			AND scid = -1 
			AND status in (1,2,3,4,5,6,7)
			AND gr <> 2305843009213693952	
			AND gr <> 16
			AND gr <> 16777232
			AND gr <> 128
			AND gr <> 1
			AND status_date < '2018-12-31'
	order by status_date
		
	</sql:query>
		
	<table style="width: 100%;" class="data mt1">
		<tr>
			<td>ID договора:</td>
			<td>№ договора:</td>
			<td>Название договора:</td>
			<td>Неактивен с:</td>
			
		</tr>	

		<c:forEach var="row" items="${result.rowsByIndex}">
			<tr>
			<%--	<td>${row[0]}</td> --%>
				<td><a href="/user/contract_bgbilling${data.getBillingId()}#${row[0]}" target="_blank" > открыть договор</a></td>
				<td>${row[1]}</td>
				<td>${row[2]}</td>
				<td>${row[3]}</td>
			
			</tr>			
		</c:forEach>
	</table>
</div>