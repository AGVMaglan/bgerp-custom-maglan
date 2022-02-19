<%@ page import="java.util.Enumeration"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<div class="center1020">

	<c:set var="dbInfo" value="${ctxPluginManager.pluginMap['bgbilling'].dbInfoManager.dbInfoMap['test']}"/>
	
	<%-- в случае, если Slave база не настроена - будет использована обычная --%>
	<sql:query var="result" dataSource="${dbInfo.connectionPool.dataSource}">

	SELECT FORMAT (SUM((t1.summa)),2) AS "Предпредыдущий:",
	    
	    (SELECT FORMAT ((sum(t1.summa)),2) 
		        FROM contract_payment AS t1, contract AS t2 
		    	WHERE t1.cid=t2.id 
		    	    AND MONTH(t1.dt)= MONTH(DATE_ADD(NOW(), INTERVAL -2 MONTH)) AND YEAR(t1.dt) = YEAR(NOW()) 
		    	    AND t1.pt in (2,24,33,36,22,9,35,17,21,30,23,37,6,7,19,25,4,31,8,11,12,26,38,39,5,32,28,16)) AS "Предыдущий:",
	    
	    (SELECT FORMAT ((sum(t1.summa)),2) 
		    FROM contract_payment AS t1, contract AS t2 
		    WHERE t1.cid=t2.id 
			AND MONTH(t1.dt)= MONTH(DATE_ADD(NOW(), INTERVAL -1 MONTH)) AND YEAR(t1.dt) = YEAR(NOW()) 
			AND t1.pt in (2,24,33,36,22,9,35,17,21,30,23,37,6,7,19,25,4,31,8,11,12,26,38,39,5,32,28,16)) AS "Предыдущий:",
						    
	    (SELECT FORMAT ((sum(t1.summa)),2) 
		    FROM contract_payment AS t1, contract AS t2 
		    WHERE t1.cid=t2.id 
			AND dt >= subdate(curdate(), (day(curdate())-1)) 
			AND t1.pt in (2,24,33,36,22,9,35,17,21,30,23,37,6,7,19,25,4,31,8,11,12,26,38,39,5,32,28,16)) AS "Текущий:"
												        
	FROM contract_payment AS t1, contract AS t2
	WHERE t1.cid=t2.id 
	    AND MONTH(t1.dt)= MONTH(DATE_ADD(NOW(), INTERVAL -3 MONTH)) AND YEAR(t1.dt) = YEAR(NOW())
	    AND t1.pt in (2,24,33,36,22,9,35,17,21,30,23,37,6,7,19,25,4,31,8,11,12,26,38,39,5,32,28,16)
		
	</sql:query>
		
	<table style="width: 100%;" class="data mt1">
		<tr>
			<td>Предпредпредыдущий, руб.</td>
			<td>Предпредыдущий, рубю</td>
			<td>Предыдущий, руб.</td>
			<td>Текущий, руб.</td> 
	
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