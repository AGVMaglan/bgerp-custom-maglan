<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<%--
Пример документа HTML, генерируемого из карточки процесса, вкладка "Документы". 

Как настроить:

1) В конфигурации сервера:
# пример документа HTML в карточке процесса
document:pattern.101.title=Пример процесс HTML
document:pattern.101.scope=process
document:pattern.101.script=ru.bgcrm.plugin.document.docgen.CommonDocumentGenerator
document:pattern.101.type=jspHtml
document:pattern.101.jsp=/WEB-INF/jspf/user/plugin/document/template/example/process_html.jsp
document:pattern.101.documentTitle=document.html
document:pattern.101.result=stream,save

2) В конфигурации типа процесса:
document:processShowDocuments=1
document:processCreateDocumentsAllowedTemplates+=,101

В карточке процессы во вкладке "Документы" должен появиться "Пример процесс HTML" 
с возможностью как сгенерировать "на лету", так и сохранить сгенерированный документ. 
--%>

<%-- установите ваши значения параметров --%>
<c:set var="PROCESS_PARAM_ADDRESS" value="38"/>
<c:set var="PROCESS_PARAM_LIST" value="32"/>

<%-- <c:forEach var="link" items="${linkDao.getObjectLinksWithType(processId, 'customer')}"> --%>

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="/css/style.css.jsp"/>
		<meta content="text/html; charset=UTF-8" http-equiv="content-type">
	</head>
	<body>
<!--		<div style="text-align: center; font-weight: bold;" class="mb1">
			Пример документа процесс HTML
-->
		</div>		
		<div>
<!--			Событие: ${event}  ${event.objectType}<br/><br/> -->
			
			<u:newInstance var="processDao" clazz="ru.bgcrm.dao.process.ProcessDAO">
				<u:param value="${conSlave}"/>
			</u:newInstance>				
			
			<u:newInstance var="paramDao" clazz="ru.bgcrm.dao.ParamValueDAO">
				<u:param value="${conSlave}"/>
			</u:newInstance>
			
			<u:newInstance var="linkDao" clazz="ru.bgcrm.dao.process.ProcessLinkDAO">
				<u:param value="${conSlave}"/>
			</u:newInstance>
			
			<u:newInstance var="inetDao" clazz="ru.bgcrm.plugin.bgbilling.proto.dao.InetDAO">
			        <u:param value="${ctxUser}"/>
			        <u:param value="bgbilling"/>
			        <u:param value="18"/>
			</u:newInstance>
			
			
			<c:set var="processId" value="${event.objectId}"/>
			<c:set var="process" value="${processDao.getProcess(processId)}"/>
			<c:set var="contractLink" value="${linkDao.getObjectLinksWithType(processId, 'contract%')[0]}"/>
			
			<c:set var="contractId" value="${contractLink.linkedObjectId}"/>
			<c:set var="contractTitle" value="${contractLink.linkedObjectTitle}"/>
			
<%--			<c:set var="serviceList" value="${inetDao.getServiceList(contractId)}"/>
			<c:set var="service" value="${serviceList[0]}"/>
			<c:set var="typeTitle" value="${service.typeTitle}"/>
			<c:set var="deviceTitle" value="${service.deviceTitle}"/>
			<c:set var="deviceStateTitle" value="${service.deviceStateTitle}"/>
			<c:set var="comment" value="${service.comment}"/>
			                                                                                                                                                
			<c:set var="serviceTypeList" value="${inetDao.getServiceTypeList()}"/>
--%>			
			
<!--			
			Исполнители: ${u:objectTitleList(ctxUserList, process.getExecutorIds())}<br/>			
			Адрес: 
				<c:forEach var="addr" items="${paramDao.getParamAddress(processId, PROCESS_PARAM_ADDRESS).values()}" varStatus="status">
					${addr.value}
				</c:forEach>
			<br/>	
			Услуги: ${u:toString(paramDao.getParamListWithTitles(processId, PROCESS_PARAM_LIST))}			
-->
		</div>
<!--	</body> -->

<small>
    <h1 align="center"><b><font face="Arial, Helvetica, sans-serif">НАРЯД ЗАКАЗ № ${event.objectId}</font> - ${contractLink.linkedObjectTitle}</b></h1>
	<big><p align="center">ЭКЗЕМПЛЯР ЗАКАЗЧИКА</p></big>
	    <p><b>Заказчик</b>: ${paramDao.getParamText(processId, 43)}  ${paramDao.getParamText(processId, 42)}</p>
	    <p><b>Организация:&nbsp;</b>${paramDao.getParamText(processId, 41)}</p>
	    <p><b>Контакты</b>: ${paramDao.getParamText(processId, 39)}</p>
	    <p><b>Адрес подключения</b>: <c:forEach var="addr" items="${paramDao.getParamAddress(processId, PROCESS_PARAM_ADDRESS).values()}" varStatus="status">
		${addr.value} </c:forEach></p>
	    <p><b>Технические работы</b>: ${u:toString(paramDao.getParamListWithTitles(processId, 37))}  ${u:toString(paramDao.getParamListWithTitles(processId, 54))}</p>
			        
	    <p><b>Вышеперечисленные работы выполнены полностью и в срок. Заказчик претензий по объёму, качеству и срокам оказания услуг не имеет.</b></p>
	    <p><b>Стоимость услуг ___________________________________</b> (поставить прочерк если без оплаты)</p>
	    <p><b>Дата: </b>число__________/месяц________________/202___/час________/минуты________</p>
	    <p><b>Подпись заказчика:_____________________________</b> ${paramDao.getParamText(processId, 42)}</p>
	    <p><b>Подпись исполнителя:___________________________</b> ${u:objectTitleList(ctxUserList, process.getExecutorIds())}</p>
	    <p>ГК МАГЛАН / Телефон технического отдела: 200-200 (доб. 110) / Адрес: 685000, г.Магадан, ул.Гагарина, д.12</p>
	    <p>Сайт: https://www.maglan.ru, E-mail: office@maglan.ru</p>
	    <p>Личный кабинет: https://pay.maglan.ru&nbsp;</p>
			        
	    <table>
		<table border="0" frame="hsides" cellpadding="1" cellspacing="1" width=100% align="center">
		    <tbody>
			<tr>
			    <td>
			        <p> </p>
			    	    <p align="center">Линия отрыва</p>
			        	    		    
			        <p> </p>
			    </td>
			</tr>
		    </tbody>
	    </table>
</small>
					        	    					    
<small>
    <h1 align="center"><b><font face="Arial, Helvetica, sans-serif">НАРЯД ЗАКАЗ № ${event.objectId}</font> - ${contractLink.linkedObjectTitle}</b></h1>
	    <p><b>Заказчик</b>: ${paramDao.getParamText(processId, 43)}  ${paramDao.getParamText(processId, 42)}</p>
	    <p><b>Организация:&nbsp;</b>${paramDao.getParamText(processId, 41)}</p>
	    <p><b>Контакты</b>: ${paramDao.getParamText(processId, 39)}</p>
	    <p><b>Адрес подключения</b>: <c:forEach var="addr" items="${paramDao.getParamAddress(processId, PROCESS_PARAM_ADDRESS).values()}" varStatus="status">
		${addr.value} </c:forEach></p>
<!--	    <c:forEach var="service" items="${serviceList}">
		<c:if test="${empty service.dateTo and (service.typeId eq 2 or service.typeId eq 6 or service.typeId eq 12)}">
		d ${service} d ${typeTitle} d ${deviceTitle} d ${deviceStateTitle} d ${comment}
		</c:if>
	    </c:forEach>
-->
	    <p><b>Технические работы</b>: ${u:toString(paramDao.getParamListWithTitles(processId, 37))} ${paramDao.getParamListWithComments(processId, 37)}  ${u:toString(paramDao.getParamListWithTitles(processId, 54))} ${paramDao.getParamListWithComments(processId, 54)} /  ${processDao.getProcess(processId)}</p>
	    <p><b>Вышеперечисленные работы выполнены полностью и в срок. Заказчик претензий по объёму, качеству и срокам оказания услуг не имеет.</b></p>
	    <p><b>Стоимость услуг ___________________________________</b> (поставить прочерк если без оплаты)</p>
	    <p><b>Дата: </b>число__________/месяц________________/202___/час________/минуты________</p>
	    <p><b>Подпись заказчика:_____________________________</b> ${paramDao.getParamText(processId, 42)}</p>
	    <p><b>Подпись исполнителя:___________________________</b> ${u:objectTitleList(ctxUserList, process.getExecutorIds())}</p>
</small>
			        	    									    

<!--
<p>&nbsp;</p>
<p><img alt="test" src="/opt/BGCRM/webapps/images/mlogo.png"></p>
<p>&nbsp;</p>
<p><img src="example/mlogo.png" 
        alt="Адрес размещения изображения относительно корня сайта"></p>
-->
	</body>
</html>