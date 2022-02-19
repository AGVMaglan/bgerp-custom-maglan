<%@ page import="java.util.Enumeration"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<div class="center1020">

	<c:set var="dbInfo" value="${ctxPluginManager.pluginMap['bgbilling'].dbInfoManager.dbInfoMap['test']}"/>
	
	<%-- в случае, если Slave база не настроена - будет использована обычная --%>
	<sql:query var="result" dataSource="${dbInfo.connectionPool.dataSource}">

	SELECT contract.id, contract.title, contract.comment, user_card.date1 AS uc_date1, user_card.date2 AS uc_date2, card_packet.id AS cpid, card_packet.date1 AS cp_date1, card_packet.date2 AS cp_date2, packet.id AS pid, packet.title AS packet_title
	FROM `contract`
	JOIN `user_card_19` AS `user_card` ON `user_card`.`cid` = `contract`.`id` AND (`user_card`.date1 IS NULL OR `user_card`.date1<=NOW()) AND (`user_card`.date2 IS NULL OR NOW()<=`user_card`.date2)
	 
	LEFT JOIN `card_packet_19` AS card_packet ON card_packet.ucid = user_card.id AND (card_packet.date1 IS NULL OR card_packet.date1<=NOW()) AND (card_packet.date2 IS NULL OR NOW()<=card_packet.date2)
	LEFT JOIN `packet_19` AS packet ON packet.id = card_packet.pid
		
	</sql:query>
		
	<table style="width: 100%;" class="data mt1">
		<tr>
			<td>Открыть договор в ERP</td>
			<td>№ договора</td>
			<td>Название</td>
			<td>Начало периода действия</td>
			<td>Окончание периода действия</td>
			<td>Управлять договором в биллинге</td>
		</tr>	

		<c:forEach var="row" items="${result.rowsByIndex}">
			<tr>
			<%--	<td>${row[0]}</td> --%>
				<td><a href="/user/contract_bgbilling${data.getBillingId()}#${row[0]}" target="_blank" > открыть договор</a></td>
				<td>${row[1]}</td>
				<td>${row[2]}</td>
				<td><button type="button" class="btn-white btn-small" onclick="sendAJAXCommand('/user/plugin/bgbilling/proto/contract.do?action=bgbillingOpenContract&amp;billingId=bgbilling&amp;contractId=${row[3]}')"> Открыть в биллинге</button></td>
			
			</tr>			
		</c:forEach>
	</table>
</div>