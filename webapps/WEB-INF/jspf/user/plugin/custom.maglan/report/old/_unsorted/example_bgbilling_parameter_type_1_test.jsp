<%@ page import="java.util.Enumeration"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<div class="center1020">

	<c:set var="dbInfo" value="${ctxPluginManager.pluginMap['bgbilling'].dbInfoManager.dbInfoMap['test']}"/>
	
	<%-- в случае, если Slave база не настроена - будет использована обычная --%>
	<sql:query var="result" dataSource="${dbInfo.connectionPool.dataSource}">

	SELECT SQL_CALC_FOUND_ROWS contract.id, contract.comment, contract.id, COUNT(distinct contract.id)
	FROM contract
	LEFT JOIN contract_parameter_type_1 ON contract.id = contract_parameter_type_1.cid AND contract_parameter_type_1.pid=44 
	WHERE contract_parameter_type_1.val IS NULL AND contract.status = 0 AND contract.date2 IS NULL AND
	
	(gr <> 1) AND
		(gr <> 3) AND
			(gr <> 16) AND
				(gr <> 128) AND
					(gr <> 512) AND
						(gr <> 1024) AND
							(gr <> 2048) AND
	(gr <> 4096) AND
		(gr <> 8192) AND
			(gr <> 262144) AND
				(gr <> 524288) AND
					(gr <> 2097152) AND
						(gr <> 16777216) AND
							(gr <> 34359738368) AND
								(gr <> 17592186044416) AND
									(gr <> 35184372088832) AND
										(gr <> 1152921504606846976) AND
											(gr <> 2305843009213693952)
	group by contract.id
		
	</sql:query>
		
	<table style="width: 100%;" class="data mt1">
		<tr>
		<%--	<td>№</td> --%>
			<td>ID договора</td>
			<td>Комментарий</td>
			<td>ID</td>
			<td>№</td>
		</tr>	

		<c:forEach var="row" items="${result.rowsByIndex}">
			<tr>
			<%-->${row[0]}</td>--%>
				<td><a href="/user/contract_bgbilling${data.getBillingId()}#${row[0]}" target="_blank" > открыть договор</a></td>
				<td>${row[1]}</td>
				<td><button type="button" class="btn-white btn-small" onclick="sendAJAXCommand('/user/plugin/bgbilling/proto/contract.do?action=bgbillingOpenContract&amp;billingId=bgbilling&amp;contractId=${row[2]}')"> Открыть в биллинге</button></td>
				<td>${row[3]}</td>
			</tr>			
		</c:forEach>
	</table>
</div>