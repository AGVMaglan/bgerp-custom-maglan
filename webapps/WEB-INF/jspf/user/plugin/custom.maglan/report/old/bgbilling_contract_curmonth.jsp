<%@ page import="java.util.Enumeration"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<div class="center1020">

	<c:set var="dbInfo" value="${ctxPluginManager.pluginMap['bgbilling'].dbInfoManager.dbInfoMap['test']}"/>

	<%-- в случае, если Slave база не настроена - будет использована обычная --%>
	<sql:query var="result" dataSource="${dbInfo.connectionPool.dataSource}">

	    SELECT (@row_number:=@row_number + 1) as "Кол-во", DATE_FORMAT( date1, '%d.%m.%Y' ) AS date1, title, comment,
	    CASE
		WHEN gr = 2
			THEN 'ШПД - Частное лицо (МагЛАН)'
		WHEN gr = 274877906946
			THEN 'ШПД - Частное лицо (МагЛАН), Дебетовые абонплаты (изменяет статус дебетовых договоров в случае при балансе <=0)'	
		WHEN gr = 4
			THEN 'ШПД - Юридическое лицо (МагЛАН)'
		WHEN gr = 8
			THEN 'ШПД - Коммерческое лицо (ИП)'
		WHEN gr = 2048
			THEN 'КТВ - частные лица'
		WHEN gr = 33554432
			THEN 'Уптар (МАГТЕЛ) - Частное лицо'	
		WHEN gr = 4294967296
			THEN 'Сокол (Магтел - частные лица)'
		WHEN gr = 68719476736
			THEN 'Стекольный (Магтел - частные лица)'
		WHEN gr = 549755813888
			THEN 'Палатка (Магтел - частные лица)'	
		WHEN gr = 1374389534720
			THEN 'Ола (Магтел - частные лица), Дебетовые абонплаты (изменяет статус дебетовых договоров в случае при балансе <=0)'
		WHEN gr = 1099511627776
			THEN 'Ола (Магтел - частные лица)'
		WHEN gr = 72057594037927936
			THEN 'Ягодное (Магтел - юридические лица)'
		WHEN gr = 70368744177664
			THEN 'Дебин - физические лица'	
		WHEN gr = 64
			THEN 'Ягодное (Магтел - частные лица)'
		ELSE 'Другие группы'  
	    END AS "Группа"
	    FROM contract, (SELECT @row_number:=0) AS t  
	    WHERE date1 >= subdate(curdate(), (day(curdate())-1)) AND gr & 792914721735960686 > 0 AND del=0
	    ORDER BY title 
		
	</sql:query>
		
	<table style="width: 100%;" class="data mt1">
		<tr>
			<td>№</td>
			<td>Дата создания</td>
			<td>Номер договора</td>
			<td>Название договора</td>
			<td>Группа</td> 
		</tr>	

		<c:forEach var="row" items="${result.rowsByIndex}">
			<tr>
				<td>${row[0]}</td>
				<td>${row[1]}</td>
				<td>${row[2]}</td>
				<td>${row[3]}</td>
				<td>${row[4]}</td>
			
			</tr>			
		</c:forEach>
	</table>
</div>