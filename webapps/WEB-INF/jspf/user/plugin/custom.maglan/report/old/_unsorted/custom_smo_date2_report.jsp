<%@ page import="java.util.Enumeration"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<div class="center1020">
	<h2>Отчет по выездам СМО</h2>
	
	<%--
	    Переменная form - объект класса ru.bgcrm.struts.form.DynActionForm, содержащий параметры запроса.
	--%>
	<c:set var="fromdate" value="${u:parseDate( form.param.fromdate, 'ymd' ) }"/>
	<c:set var="todate" value="${u:parseDate( form.param.todate, 'ymd' ) }"/>
	                
	
	<html:form action="/user/empty">
		<input type="hidden" name="forwardFile" value="/WEB-INF/custom/plugin/report/custom_smo_date2_report.jsp"/>
		
		Начало периода:
		<ui:date-time paramName="fromdate" value="first"/>
		
		Окончание периода:
		<ui:date-time paramName="todate" value="last"/>
		
		<br/>
		<br/>
		
		В указанный промежуток времени было либо начало выезда, либо его окончание . 
<%-- 		<p>**${fromdate}</p><p>${form.param.fromdate}</p> --%>
		
		<br/>
		
		<button type="button"  class="btn-grey ml1 mt05" onclick="openUrlToParent( formUrl( this.form ), $(this.form) )">Сформировать</button>
	</html:form>
	<%--
	Генерация отчёта, если в запросе пришёл параметр date.<>
	--%>
	<c:if test="${not empty fromdate}">
		<%-- в случае, если Slave база не настроена - будет использована обычная --%> 
		
		<sql:query var="result" dataSource="${ctxSlaveDataSource}">
	SELECT DATE_FORMAT(vstart.value, '%Y-%m-%d'),
	param_address.value,
	DATE_FORMAT(vstart.value, '%H.%i'),
	DATE_FORMAT(vend.value, '%H.%i'),
	zadmes.text,
	rezmes.text,
	GROUP_CONCAT(user.title SEPARATOR ', '),
	process.id,
	prlink.process_id,
	<%-- prlink2.object_id,--%>
	customer.title
	FROM process
	LEFT JOIN param_date AS prdate ON process.id = prdate.id AND prdate.param_id = 70
	LEFT JOIN param_address ON process.id = param_address.id AND param_address.param_id = 42
	LEFT JOIN param_datetime AS vstart ON process.id = vstart.id AND vstart.param_id = 66
	LEFT JOIN param_datetime AS vend ON process.id = vend.id AND vend.param_id = 67
	LEFT JOIN n_message AS zadmes ON process.id = zadmes.process_id AND zadmes.type_id = 7
	LEFT JOIN n_message AS rezmes ON process.id = rezmes.process_id AND rezmes.type_id = 8
	LEFT JOIN process_executor ON process.id = process_executor.process_id AND process_executor.role_id = 0
	LEFT JOIN user ON process_executor.user_id = user.id
	LEFT JOIN process_link AS prlink ON process.id = prlink.object_id AND prlink.object_type = "processDepend"
	LEFT JOIN process_link AS prlink2 ON prlink.process_id = prlink2.process_id AND prlink2.object_type = "customer"
	LEFT JOIN customer ON prlink2.object_id = customer.id 
	WHERE (vstart.value BETWEEN ? AND addtime(?, '23:59:59') OR vend.value BETWEEN ? AND addtime(?, '23:59:59'))
	AND process.type_id = 30
	AND process_executor.group_id IN(13,14)
	
	GROUP BY process.id
	
	<sql:param value="${fromdate}"/>
	<sql:param value="${todate}"/>
	<sql:param value="${fromdate}"/>
	<sql:param value="${todate}"/>
	
	</sql:query>
		
		<table style="width: 100%;" class="data mt1">
	<tr>
	<td>Дата</td>
	<td>Адрес</td>
	<td>Время начала выезда</td>
	<td>Время окончания выезда</td>
	<td>Задача на выезд</td>
	<td>Результат выезда</td>
	<td>Исполнители</td>
	<td>Номер процесса выезда</td>
	<td>Номер процесса основного</td>
	<td>Контрагент</td>
	<td>Сотрудники, работавшие в смену</td>
	<td>Кол-во выездов за день</td>
	<td>Кол-во сотрудников, вышедших на работу</td>
	<%-- <td>Кол-во выездов за день</td>
	<td>Кол-во людей, вышедших на работу</td>--%>
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
				<td><a href="UNDEF" onclick="openProcess( ${row[7]} ); return false;">${row[7]}</a></td>
				<td><a href="UNDEF" onclick="openProcess( ${row[8]} ); return false;">${row[8]}</a></td>
				<td>${row[9]}</td>
				<td>${row[10]}</td>
				<td>${row[11]}</td>
				<td>${row[12]}</td>
			</tr>
				</c:forEach>
		</table>	
	</c:if>
	
	<%--<button type="button"  class="btn-grey ml1 mt05" >Выгрузить в xls</button> --%>
	    
</div>