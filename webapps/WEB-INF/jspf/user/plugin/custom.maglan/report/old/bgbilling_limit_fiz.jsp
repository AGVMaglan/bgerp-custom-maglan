<%@ page import="java.util.Enumeration"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<div class="center1020">

	<h2>Статусы: 0:Активен;1:Приостановлен менеджером;3:Закрыт - расторжении договора;4:Приостановлен сервером;5:В подключении;6:Пополните счет. Через 12 часов действие договора будет приостановлено;7:Приостановлен абонентом</h2>

	<c:set var="dbInfo" value="${ctxPluginManager.pluginMap['bgbilling'].dbInfoManager.dbInfoMap['test']}"/>
	
	<%-- в случае, если Slave база не настроена - будет использована обычная --%>
	<sql:query var="result" dataSource="${dbInfo.connectionPool.dataSource}">

	SELECT contract.id AS cid, contract.closesumma, contract.comment, contract.id, contract.status
	    from bgbilling.contract 
	    where closesumma <> 0 
		AND gr <> 128
		AND gr <> 1
		AND gr <> 16777216
		AND gr <> 16
		AND fc = 0
	    ORDER by contract.closesumma
		
	</sql:query>
		
	<table style="width: 100%;" class="data mt1">
		<tr>
			<td>Открыть договор в ERP</td>
			<td>Лимит</td>
			<td>Название</td>
			<td>Открыть договор в BGBilling</td>
			<td>Статус договора</td>
		</tr>	

		<c:forEach var="row" items="${result.rowsByIndex}">
			<tr>
			<%--	<td>${row[0]}</td> --%>
				<td><a href="/user/contract_bgbilling${data.getBillingId()}#${row[0]}" target="_blank" > открыть договор</a></td>
				<td>${row[1]}</td>
				<td>${row[2]}</td>
				<td><button type="button" class="btn-white btn-small" onclick="sendAJAXCommand('/user/plugin/bgbilling/proto/contract.do?action=bgbillingOpenContract&amp;billingId=bgbilling&amp;contractId=${row[3]}')"> Открыть в биллинге</button></td>
				<td>${row[4]}</td>
			
			</tr>			
		</c:forEach>
	</table>
</div>