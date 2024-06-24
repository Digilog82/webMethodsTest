%invoke JSocketAdapter.RESTAPI.TEST:testAuditLog%

<html>
	<head>	
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo) {
				var frm = document.pform;
				frm.todo.value = todo;
				frm.submit();
			}
		</script>
	</head>
	<body>
		%ifvar SocketAuditInfo/DocReqBodySchema -notempty%
		<table class="tableForm" width="100%">
			%ifvar reqSchemaDefType equals('EN')%
			<!-- Endian 변환이 필요 없는 일반적인 경우 -->
			<tr>
				<td class="heading" colspan="5">%value reqBodySchemaTitle%전문 업무정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Field Length</td>
				<td>Padding Char</td>
				<td>Padding Type</td>
			</tr>
			%loop SocketAuditInfo/DocReqBodySchema%
				<tr>				
				%ifvar idataType equals('field')%
					%loop schemaList -$index%
						<td>
							%ifvar $index equals('0')%
								<script language="javascript">
									var listDepth = %value listDepth%;
									
									if (listDepth > 0) {
										for (i = 0; i < (listDepth * 2); i += 1) {
											document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
										}
									}
								</script>
							%endifvar%
							%value schemaList%
						</td>
					%endloop%
				%else%
					<td class="subheading2" colspan="5">
						<script language="javascript">
							var listDepth = %value listDepth% - 1;
							
							if (listDepth > 0) {
								for (i = 0; i < (listDepth * 2); i += 1) {
									document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
								}
							}
						</script>
						%value listName% Array Schema (%value listCountDesc%)
					</td>
				%endifvar%
				</tr>
			%endloop%
			%else%
			%ifvar reqSchemaDefType equals('ER')%
			<!-- 전문 수신 시 Endian 변환이 필요한 경우 -->
			<tr>
				<td class="heading" colspan="5">%value reqBodySchemaTitle%전문 업무정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Data Type</td>
				<td>Field Length</td>
				<td>Array Count</td>
			</tr>
			%loop SocketAuditInfo/DocReqBodySchema%
				<tr>				
				%ifvar idataType equals('field')%
					%loop schemaList -$index%
						<td>
							%ifvar $index equals('0')%
								<script language="javascript">
									var listDepth = %value listDepth%;
									
									if (listDepth > 0) {
										for (i = 0; i < (listDepth * 2); i += 1) {
											document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
										}
									}
								</script>
							%endifvar%
							%value schemaList%
						</td>
					%endloop%
				%else%
					<td class="subheading2" colspan="5">
						<script language="javascript">
							var listDepth = %value listDepth% - 1;
							
							if (listDepth > 0) {
								for (i = 0; i < (listDepth * 2); i += 1) {
									document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
								}
							}
						</script>
						%value listName% Array Schema (%value listCountDesc%)
					</td>
				%endifvar%
				</tr>
			%endloop%
			%else%
			%ifvar reqSchemaDefType equals('ES')%
			<!-- 전문 송신 시 Endian 변환이 필요한 경우 -->
			<tr>
				<td class="heading" colspan="8">%value reqBodySchemaTitle%전문 업무정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Field Length</td>
				<td>Padding Char</td>
				<td>Padding Type</td>
				<td>Data Type</td>
				<td>Field Length</td>
				<td>Array Count</td>
			</tr>
			%loop SocketAuditInfo/DocReqBodySchema%
				<tr>				
				%ifvar idataType equals('field')%
					%loop schemaList -$index%
						<td>
							%ifvar $index equals('0')%
								<script language="javascript">
									var listDepth = %value listDepth%;
									
									if (listDepth > 0) {
										for (i = 0; i < (listDepth * 2); i += 1) {
											document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
										}
									}
								</script>
							%endifvar%
							%value schemaList%
						</td>
					%endloop%
				%else%
					<td class="subheading2" colspan="8">
						<script language="javascript">
							var listDepth = %value listDepth% - 1;
							
							if (listDepth > 0) {
								for (i = 0; i < (listDepth * 2); i += 1) {
									document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
								}
							}
						</script>
						%value listName% Array Schema (%value listCountDesc%)
					</td>
				%endifvar%
				</tr>
			%endloop%
			%else%
			%ifvar reqSchemaDefType equals('EJ')%
			<!-- Endian 변환이 필요없으면서 Socket To REST API 방식, REST API To Socket 방식, Socket To Socket 방식이면서 Source, Target 포맷이 서로 다른 경우 -->
			<tr>
				<td class="heading" colspan="8">%value reqBodySchemaTitle%전문 업무정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Field Length</td>
				<td>Padding Char</td>
				<td>Padding Type</td>
				<td>Data Type</td>
				<td>Length Calculation Start</td>
				<td>Field Type</td>
			</tr>
			%loop SocketAuditInfo/DocReqBodySchema%
				<tr>				
				%ifvar idataType equals('field')%
					%loop schemaList -$index%
						<td>
							%ifvar $index equals('0')%
								<script language="javascript">
									var listDepth = %value listDepth%;
									
									if (listDepth > 0) {
										for (i = 0; i < (listDepth * 2); i += 1) {
											document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
										}
									}
								</script>
							%endifvar%
							%value schemaList%
						</td>
					%endloop%
				%else%
				%ifvar idataType equals('group')%
					<td class="subheading2" colspan="8">
						<script language="javascript">
							var listDepth = %value listDepth% - 1;
							
							if (listDepth > 0) {
								for (i = 0; i < (listDepth * 2); i += 1) {
									document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
								}
							}
						</script>
						%value groupName% Group Schema
					</td>
				%else%
					<td class="subheading2" colspan="8">
						<script language="javascript">
							var listDepth = %value listDepth% - 1;
							
							if (listDepth > 0) {
								for (i = 0; i < (listDepth * 2); i += 1) {
									document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
								}
							}
						</script>
						%value listName% Array Schema (%value listCountDesc%)
					</td>
				%endifvar%
				%endifvar%
				</tr>
			%endloop%
			%endifvar%
			%endifvar%
			%endifvar%
			%endifvar%
		</table>
		%endifvar%			
		
		%ifvar SocketAuditInfo/DocReqBodyData -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">요청전문 업무정보부 Data</td>
			</tr>
			%loop SocketAuditInfo/DocReqBodyData%				
				%ifvar idataType equals('field')% <!-- Single Record인 경우 -->
					<!-- 상위에서 List 끝난 후에 Single Record가 나오는 경우. Table을 닫아 준다. -->
					%ifvar beforeListExist equals('true')%
						</table>
						<table class="tableForm" width="100%">
					%endifvar%
					<tr>
						<td class="evenrow" width="30%">%value fieldName%</td>
						<td class="evenrow-l" width="70%">%value fieldValue%</td>
					</tr>
				%else% <!-- Multi Record인 경우 -->					
					%ifvar titleValue equals('listEnd')% <!-- List 끝나는 부분을 표시한 데이터 -->
						%ifvar listDepth equals('1')% <!-- 첫번째 List인 경우에는 Skip -->
						%else%
							</table>
							<table class="tableForm" width="100%">
						%endifvar%
					%else%					
						%ifvar titleValue equals('title')% <!-- 필드명 목록인 경우 -->
							</table>
							<table class="tableForm" width="100%">
								<tr class="subheading2">
						%else% <!-- 필드의 데이터 목록인 경우 -->
							<tr>							
						%endifvar%
							%loop valueList -$index%								
								<td>
								%ifvar $index equals('0')%
									<script language="javascript">
										var listDepth = %value listDepth%;
										
										if (listDepth > 1) {
											for (i = 0; i < ((listDepth - 1) * 2); i += 1) {
												document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
											}
										}
									</script>
								%endifvar%
								%value valueList%</td>
							%endloop%
							</tr>
					%endifvar%
				%endifvar%
			%endloop%
		</table>
		%endifvar%
	</body>
</html>

%endinvoke%