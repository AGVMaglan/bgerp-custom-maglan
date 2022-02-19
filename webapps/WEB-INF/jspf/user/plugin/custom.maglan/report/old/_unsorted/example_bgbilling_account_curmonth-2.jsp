<%@ page import="java.util.Enumeration"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<div class="center1020">

	<c:set var="dbInfo" value="${ctxPluginManager.pluginMap['bgbilling'].dbInfoManager.dbInfoMap['test']}"/>
	
	<%-- в случае, если Slave база не настроена - будет использована обычная --%>
	<sql:query var="result" dataSource="${dbInfo.connectionPool.dataSource}">

	SELECT FORMAT (SUM(cont_ac.summa),2) AS "Препредыдущий месяц", 
	    (
		SELECT FORMAT (SUM(cont_ac.summa),2) 
		    FROM contract_account AS cont_ac, contract AS cont, service AS serv 
		    WHERE cont_ac.cid=cont.id AND cont_ac.sid=serv.id AND cont.gr&1081004648040234863 > 0 AND cont_ac.yy=YEAR(NOW()) AND cont_ac.mm = MONTH(DATE_ADD(NOW(), INTERVAL -1 MONTH))
	    ) AS "Предыдущий месяц",
					
	    (
		SELECT FORMAT (SUM(cont_ac.summa),2) 
		    FROM contract_account AS cont_ac, contract AS cont, service AS serv 
		    WHERE cont_ac.cid=cont.id AND cont_ac.sid=serv.id AND cont.gr&1081004648040234863 > 0 AND cont_ac.yy=YEAR(NOW()) AND cont_ac.mm=MONTH(NOW()) 
	    ) AS "Текущий месяц"
	    FROM contract_account AS cont_ac,  contract AS cont, service AS serv
	    WHERE cont_ac.cid=cont.id
	    AND cont_ac.sid=serv.id
	    AND cont.gr&1081004648040234863 > 0
	    AND cont_ac.yy = YEAR(NOW())
	    AND cont_ac.mm = MONTH(DATE_ADD(NOW(), INTERVAL -2 MONTH))
		
	</sql:query>
		
	<table style="width: 100%;" class="data mt1">
		<tr>
			<td>Предпредыдущий мес.</td>
			<td>Предыдущий мес.</td>
			<td>Текущий мес.</td> 
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