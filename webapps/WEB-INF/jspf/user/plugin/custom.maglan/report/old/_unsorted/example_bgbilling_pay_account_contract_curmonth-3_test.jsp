<%@ page import="java.util.Enumeration"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jspf/taglibs.jsp"%>

<div class="center1020">
	<%-- 
	    Используется БД, настороенная для биллинга с ID test.
	    Пример настройки в конфигурации:
	    bgbilling:server.2.id=test
		..
		bgbilling:server.2.db.driver=com.mysql.jdbc.Driver
		bgbilling:server.2.db.url=jdbc:mysql://X.X.X.X/bgbilling_test?useUnicode=true&characterEncoding=UTF-8&connectionCollation=utf8_unicode_ci&allowUrlInLocalInfile=true&zeroDateTimeBehavior=convertToNull&jdbcCompliantTruncation=false&elideSetAutoCommits=true&cachePrepStmts=true&useCursorFetch=true&queryTimeoutKillsConnection=true
		bgbilling:server.2.db.user=root
		bgbilling:server.2.db.pswd=
	--%>
	<c:set var="dbInfo" value="${ctxPluginManager.pluginMap['bgbilling'].dbInfoManager.dbInfoMap['test']}"/>
	
	<%-- в случае, если Slave база не настроена - будет использована обычная --%>
	<sql:query var="result" dataSource="${dbInfo.connectionPool.dataSource}">
		SELECT CONCAT (
		
		    (SELECT FORMAT (SUM(cont_ac.summa),2)
			    FROM contract_account AS cont_ac,  contract AS cont, service AS serv
				    WHERE cont_ac.cid=cont.id
					AND cont_ac.sid=serv.id
					AND cont.gr&1081004648040234863 > 0
					AND cont_ac.yy = YEAR(NOW())
					AND cont_ac.mm = MONTH(DATE_ADD(NOW(), INTERVAL -3 MONTH))
											), ' / ',
											    
		    (SELECT FORMAT (SUM((t1.summa)),2)
			    FROM contract_payment AS t1, contract AS t2
				    WHERE t1.cid=t2.id 
					AND MONTH(t1.dt)= MONTH(DATE_ADD(NOW(), INTERVAL -3 MONTH)) AND YEAR(t1.dt) = YEAR(NOW())
					AND t1.pt in (2,24,33,36,22,9,35,17,21,30,23,37,6,7,19,25,4,31,8,11,12,26,38,39,5,32,28,16)
																	    
																		 
		    ), ' / ',
																			
		    (SELECT COUNT(comment)
			    FROM contract, (SELECT @row_number:=0) AS t
				    WHERE MONTH(date1) = MONTH(DATE_ADD(NOW(), INTERVAL -3 MONTH)) 
					AND YEAR(date1) = YEAR(NOW()) 
					AND gr & 1081004648040234863 > 0 
					AND del=0	
		    ) ) AS "Предпредпредыдущий, мес.",
																									    
		    CONCAT ((SELECT FORMAT (SUM(cont_ac.summa),2)
				FROM contract_account AS cont_ac,  contract AS cont, service AS serv
				WHERE cont_ac.cid=cont.id
				    AND cont_ac.sid=serv.id
				    AND cont.gr&1081004648040234863 > 0
				    AND cont_ac.yy = YEAR(NOW())
				    AND cont_ac.mm = MONTH(DATE_ADD(NOW(), INTERVAL -2 MONTH))
			    ), ' / ',
			    
																																				    
		    (SELECT FORMAT (SUM((t1.summa)),2)
																																						FROM contract_payment AS t1, contract AS t2
																																							WHERE t1.cid=t2.id 
																																								    AND MONTH(t1.dt)= MONTH(DATE_ADD(NOW(), INTERVAL -2 MONTH)) AND YEAR(t1.dt) = YEAR(NOW())
																																										AND t1.pt in (2,24,33,36,22,9,35,17,21,30,23,37,6,7,19,25,4,31,8,11,12,26,38,39,5,32,28,16)
																																										    
																																											 
																																											    ), ' / ',
																																												
																																												    (SELECT COUNT(comment)
																																													    FROM contract, (SELECT @row_number:=0) AS t
																																														    WHERE MONTH(date1) = MONTH(DATE_ADD(NOW(), INTERVAL -2 MONTH)) 
																																																AND YEAR(date1) = YEAR(NOW()) 
																																																	    AND gr & 1081004648040234863 > 0 
																																																			AND del=0	
																																																			    ) ) AS "Предпредпредыдущий, мес.",
																																																			    
																																																				CONCAT ( 
																																																				
																																																				    (SELECT FORMAT (SUM(cont_ac.summa),2)
																																																					    FROM contract_account AS cont_ac,  contract AS cont, service AS serv
																																																						    WHERE cont_ac.cid=cont.id
																																																								AND cont_ac.sid=serv.id
																																																									    AND cont.gr&1081004648040234863 > 0
																																																											AND cont_ac.yy = YEAR(NOW())
																																																												    AND cont_ac.mm = MONTH(DATE_ADD(NOW(), INTERVAL -1 MONTH))
																																																													), ' / ',
																																																													    
																																																														(SELECT FORMAT (SUM((t1.summa)),2)
																																																															FROM contract_payment AS t1, contract AS t2
																																																																WHERE t1.cid=t2.id 
																																																																	    AND MONTH(t1.dt)= MONTH(DATE_ADD(NOW(), INTERVAL -1 MONTH)) AND YEAR(t1.dt) = YEAR(NOW())
																																																																			AND t1.pt in (2,24,33,36,22,9,35,17,21,30,23,37,6,7,19,25,4,31,8,11,12,26,38,39,5,32,28,16)
																																																																			    
																																																																				 
																																																																				    ), ' / ',
																																																																					
																																																																					    (SELECT COUNT(comment)
																																																																						    FROM contract, (SELECT @row_number:=0) AS t
																																																																							    WHERE MONTH(date1) = MONTH(DATE_ADD(NOW(), INTERVAL -1 MONTH)) 
																																																																									AND YEAR(date1) = YEAR(NOW()) 
																																																																										    AND gr & 1081004648040234863 > 0 
																																																																												AND del=0	
																																																																												    ) ) AS "Предыдущий, мес.",
																																																																												    
																																																																													CONCAT ( 
																																																																													
																																																																													    (SELECT FORMAT (SUM(cont_ac.summa),2)
																																																																														    FROM contract_account AS cont_ac,  contract AS cont, service AS serv
																																																																															    WHERE cont_ac.cid=cont.id
																																																																																	AND cont_ac.sid=serv.id
																																																																																		    AND cont.gr&1081004648040234863 > 0
																																																																																				AND cont_ac.yy = YEAR(NOW())
																																																																																					    AND cont_ac.mm = MONTH(DATE_ADD(NOW(), INTERVAL -0 MONTH))
																																																																																						), ' / ',
																																																																																						    
																																																																																							(SELECT FORMAT (SUM((t1.summa)),2)
																																																																																								FROM contract_payment AS t1, contract AS t2
																																																																																									WHERE t1.cid=t2.id 
																																																																																										    AND dt >= subdate(curdate(), (day(curdate())-1)) 
																																																																																												AND t1.pt in (2,24,33,36,22,9,35,17,21,30,23,37,6,7,19,25,4,31,8,11,12,26,38,39,5,32,28,16)
																																																																																												    
																																																																																													 
																																																																																													    ), ' / ',
																																																																																														
																																																																																														    (SELECT COUNT(comment)
																																																																																															    FROM contract, (SELECT @row_number:=0) AS t
																																																																																																    WHERE MONTH(date1) = MONTH(DATE_ADD(NOW(), INTERVAL -0 MONTH)) 
																																																																																																		AND YEAR(date1) = YEAR(NOW()) 
																																																																																																			    AND gr & 1081004648040234863 > 0 
																																																																																																					AND del=0	
																																																																																																					    ) ) AS "Текущий, мес."
																																																																																																					    
																																																																																																						
																																																																																																						
	</sql:query>
		
	<table style="width: avto;" class="data mt1">
		<tr>
			<td>ID</td>
			<td>Номер</td>
			<td>Комментарий</td>
			<td>Комментарий</td>
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