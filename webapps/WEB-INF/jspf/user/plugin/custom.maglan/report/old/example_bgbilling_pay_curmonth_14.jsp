<%@ page import="java.util.Enumeration"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<div class="center1020">

	<c:set var="dbInfo" value="${ctxPluginManager.pluginMap['bgbilling'].dbInfoManager.dbInfoMap['test']}"/>
	
	<%-- в случае, если Slave база не настроена - будет использована обычная --%>
	<sql:query var="result" dataSource="${dbInfo.connectionPool.dataSource}">

	SELECT t1.dt AS "Дата:", FORMAT ((t1.summa),2) AS "Платеж:",
	    CASE
		WHEN pt = 2
		    THEN 'КАССА МагЛАН (НДС) - оплата по договору'
		WHEN pt = 24
	    	    THEN 'КАССА Маглан-Сервис (без НДС) - оплата по договору'
	        WHEN pt = 14
	            THEN 'КАССА Маглан-Сервис (без НДС) - оплата по договору'
	        ELSE 'Другие кассы' END AS "КАССА:",
	        t1.comment AS "Комментарий:", t2.title AS "Номер договора:", t2.comment AS "Название договора:", t1.lm AS "Время транзакции:",
	        (SELECT FORMAT ((sum(t1.summa)),2) 
	    	    FROM contract_payment AS t1, contract AS t2 
	    	    WHERE t1.cid=t2.id AND dt >= subdate(curdate(), (day(curdate())-1)) and t1.pt in (14)) AS "ИТОГО:"
	        FROM contract_payment AS t1, contract AS t2
	        WHERE t1.cid=t2.id AND dt >= subdate(curdate(), (day(curdate())-1)) AND t1.pt in (14) order by t1.lm asc
	                    
	                    
		
	</sql:query>
		
	<table style="width: 100%;" class="data mt1">
		<tr>
			<td>Дата</td>
			<td>Приход</td>
			<td>Касса</td> 
			<td>Комментарий</td>
			<td>Номер договора</td>
			<td>Название договора</td>
			<td>Дата транзакции</td>
			<td>ИТОГО</td>
		</tr>	

		<c:forEach var="row" items="${result.rowsByIndex}">
			<tr>
				<td>${row[0]}</td>
				<td>${row[1]}</td>
				<td>${row[2]}</td>
				<td>${row[3]}</td>
				<td>${row[4]}</td>
				<td>${row[5]}</td>
				<td>${row[6]}</td>
				<td>${row[7]}</td>
			
			</tr>			
		</c:forEach>
	</table>
</div>