<%@ page import="java.util.Enumeration"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<div class="center1020">

	<c:set var="dbInfo" value="${ctxPluginManager.pluginMap['bgbilling'].dbInfoManager.dbInfoMap['test']}"/>

	<%-- в случае, если Slave база не настроена - будет использована обычная --%>
	<sql:query var="result" dataSource="${dbInfo.connectionPool.dataSource}">
	
	SELECT serv.title as Service, round(SUM(cont_ac2.summa),2) as col0, round(SUM(cont_ac2.summa),2) as col1, round(SUM(cont_ac2.summa),2) as col2, round(SUM(cont_ac1.summa),2) as col3, round(SUM(cont_ac0.summa),2) as Current_Month 
	    FROM 	
			contract_account AS cont_ac4, 
			contract_account AS cont_ac3, 
			contract_account AS cont_ac2, 
			contract_account AS cont_ac1, 
			contract_account AS cont_ac0, 
			contract AS cont, service AS serv 	
	    WHERE 
		    cont_ac4.cid=cont.id
		    AND cont_ac3.cid=cont.id
		    AND cont_ac2.cid=cont.id
		    AND cont_ac1.cid=cont.id
		    AND cont_ac0.cid=cont.id
		    AND cont_ac4.sid=serv.id
		    AND cont_ac3.sid=serv.id
		    AND cont_ac2.sid=serv.id
		    AND cont_ac1.sid=serv.id
		    AND cont_ac0.sid=serv.id
		    AND cont.gr&5692831403956239727 > 0 
		    AND cont_ac4.yy=2021
		    AND cont_ac3.yy=2021
		    AND cont_ac2.yy=2021
		    AND cont_ac1.yy=2021
		    AND cont_ac0.yy=YEAR(NOW())
		    AND cont_ac4.mm=MONTH(DATE_ADD(NOW(), INTERVAL -5 MONTH))
		    AND cont_ac3.mm=MONTH(DATE_ADD(NOW(), INTERVAL -4 MONTH))
		    AND cont_ac2.mm=MONTH(DATE_ADD(NOW(), INTERVAL -3 MONTH))
		    AND cont_ac1.mm=MONTH(DATE_ADD(NOW(), INTERVAL -2 MONTH))
		    AND cont_ac0.mm=MONTH(DATE_ADD(NOW(), INTERVAL -1 MONTH))
		    AND cont_ac4.sid IN (13, 21, 34, 38, 268, 15, 247, 66, 54, 129, 273, 19, 50, 282, 281, 226, 16, 65, 17, 267, 228, 20, 280, 14, 55, 249, 94, 95, 96, 97, 233, 53, 69, 70, 259, 257, 258, 285, 286, 283, 284, 261, 266, 37, 35, 93, 47, 71, 72, 33, 256, 255, 209, 289, 251, 252, 110, 227, 288, 39, 244, 111, 120, 137, 28, 59, 48, 57, 210, 29, 31, 45, 106, 32, 184, 24, 25, 26, 144, 84, 122, 143, 113, 132, 133, 218, 219, 291, 290, 276, 107, 46, 43, 44, 225, 220, 221, 236, 231, 115, 248, 30, 103, 12, 138, 104, 134, 135, 88, 159, 100, 99, 98, 92, 101, 148, 222, 86, 130, 87, 117, 91, 85, 149, 223, 119, 131, 229, 230, 114, 224, 196, 197, 198, 195, 207, 193, 194, 199, 200, 206, 189, 211, 127, 102, 188, 187, 105, 190, 128, 192, 191, 204, 121, 118, 123, 124, 125, 126, 142, 140, 181, 153, 175, 141, 182, 154, 176, 150, 152, 180, 155, 156, 179, 232, 271, 287)
		    AND cont_ac3.sid IN (13, 21, 34, 38, 268, 15, 247, 66, 54, 129, 273, 19, 50, 282, 281, 226, 16, 65, 17, 267, 228, 20, 280, 14, 55, 249, 94, 95, 96, 97, 233, 53, 69, 70, 259, 257, 258, 285, 286, 283, 284, 261, 266, 37, 35, 93, 47, 71, 72, 33, 256, 255, 209, 289, 251, 252, 110, 227, 288, 39, 244, 111, 120, 137, 28, 59, 48, 57, 210, 29, 31, 45, 106, 32, 184, 24, 25, 26, 144, 84, 122, 143, 113, 132, 133, 218, 219, 291, 290, 276, 107, 46, 43, 44, 225, 220, 221, 236, 231, 115, 248, 30, 103, 12, 138, 104, 134, 135, 88, 159, 100, 99, 98, 92, 101, 148, 222, 86, 130, 87, 117, 91, 85, 149, 223, 119, 131, 229, 230, 114, 224, 196, 197, 198, 195, 207, 193, 194, 199, 200, 206, 189, 211, 127, 102, 188, 187, 105, 190, 128, 192, 191, 204, 121, 118, 123, 124, 125, 126, 142, 140, 181, 153, 175, 141, 182, 154, 176, 150, 152, 180, 155, 156, 179, 232, 271, 287)
		    AND cont_ac1.sid IN (13, 21, 34, 38, 268, 15, 247, 66, 54, 129, 273, 19, 50, 282, 281, 226, 16, 65, 17, 267, 228, 20, 280, 14, 55, 249, 94, 95, 96, 97, 233, 53, 69, 70, 259, 257, 258, 285, 286, 283, 284, 261, 266, 37, 35, 93, 47, 71, 72, 33, 256, 255, 209, 289, 251, 252, 110, 227, 288, 39, 244, 111, 120, 137, 28, 59, 48, 57, 210, 29, 31, 45, 106, 32, 184, 24, 25, 26, 144, 84, 122, 143, 113, 132, 133, 218, 219, 291, 290, 276, 107, 46, 43, 44, 225, 220, 221, 236, 231, 115, 248, 30, 103, 12, 138, 104, 134, 135, 88, 159, 100, 99, 98, 92, 101, 148, 222, 86, 130, 87, 117, 91, 85, 149, 223, 119, 131, 229, 230, 114, 224, 196, 197, 198, 195, 207, 193, 194, 199, 200, 206, 189, 211, 127, 102, 188, 187, 105, 190, 128, 192, 191, 204, 121, 118, 123, 124, 125, 126, 142, 140, 181, 153, 175, 141, 182, 154, 176, 150, 152, 180, 155, 156, 179, 232, 271, 287)
		    AND cont_ac0.sid IN (13, 21, 34, 38, 268, 15, 247, 66, 54, 129, 273, 19, 50, 282, 281, 226, 16, 65, 17, 267, 228, 20, 280, 14, 55, 249, 94, 95, 96, 97, 233, 53, 69, 70, 259, 257, 258, 285, 286, 283, 284, 261, 266, 37, 35, 93, 47, 71, 72, 33, 256, 255, 209, 289, 251, 252, 110, 227, 288, 39, 244, 111, 120, 137, 28, 59, 48, 57, 210, 29, 31, 45, 106, 32, 184, 24, 25, 26, 144, 84, 122, 143, 113, 132, 133, 218, 219, 291, 290, 276, 107, 46, 43, 44, 225, 220, 221, 236, 231, 115, 248, 30, 103, 12, 138, 104, 134, 135, 88, 159, 100, 99, 98, 92, 101, 148, 222, 86, 130, 87, 117, 91, 85, 149, 223, 119, 131, 229, 230, 114, 224, 196, 197, 198, 195, 207, 193, 194, 199, 200, 206, 189, 211, 127, 102, 188, 187, 105, 190, 128, 192, 191, 204, 121, 118, 123, 124, 125, 126, 142, 140, 181, 153, 175, 141, 182, 154, 176, 150, 152, 180, 155, 156, 179, 232, 271, 287)
		    		
		    
	GROUP BY cont_ac2.sid ORDER BY serv.mid, serv.title
	
	</sql:query>

	<table style="width: 100%;" class="data mt1">
	    <tr>
			<td>Название услуги</td>
			<td>Четыре месяца назад</td>
			<td>Три месяца назад</td>
			<td>Два месяца назад</td>
			<td>Месяца назад</td>
			<td>Отчетный месяц</td>
	    </tr>

	    <c:forEach var="row" items="${result.rowsByIndex}">
			<tr>
				<td>${row[0]}</td>
				<td>${row[1]}</td>
				<td>${row[2]}</td>
				<td>${row[3]}</td>
				<td>${row[4]}</td>
				<td>${row[5]}</td>
			</tr>
	    </c:forEach>
	</table>
</div>