<%@ page import="java.util.Enumeration"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<div class="center1020">

	<c:set var="dbInfo" value="${ctxPluginManager.pluginMap['bgbilling'].dbInfoManager.dbInfoMap['test']}"/>
	
	<%-- в случае, если Slave база не настроена - будет использована обычная --%>
	<sql:query var="result" dataSource="${dbInfo.connectionPool.dataSource}">

	SELECT serv.title as col1, FORMAT (round(SUM(cont_ac.summa)),2) as col2, 
	(
	    SELECT FORMAT (SUM(ROUND(cont_ac.summa)),2) 
	    FROM contract_account AS cont_ac, contract AS cont, service AS serv 
	    WHERE cont_ac.cid=cont.id AND cont_ac.yy=YEAR(NOW()) AND cont_ac.sid=serv.id AND cont.gr&792914721733863534 > 0 AND cont_ac.mm=MONTH(NOW()) 
	) AS "bnjuj"
	FROM contract_account AS cont_ac,  contract AS cont, service AS serv
	WHERE cont_ac.cid=cont.id
	AND cont_ac.sid=serv.id
	AND cont.gr&792914721733863534 > 0
	AND cont_ac.yy=YEAR(NOW())
	AND cont_ac.mm=MONTH(NOW())			
	GROUP BY cont_ac.sid
		
	</sql:query>
		
	<table style="width: 100%;" class="data mt1">
		<tr>
			<td>Услуга</td>
			<td>Наработка в руб.</td>
			<td>ИТОГО</td> 
		</tr>	

		<c:forEach var="row" items="${result.rowsByIndex}">
			<tr>
				<td>${row[0]}</td>
				<td>${row[1]}</td>
				<td>${row[2]}</td>
			
			</tr>			
		</c:forEach>
	</table>
</div>