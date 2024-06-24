%invoke JSocketAdapter.ADMIN:adminRemoteServerAuditLog%

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
	
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Socket Log &gt;
						Remote Server Audit Log &gt;
						Details
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Transaction Basic Info</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Socket Name</td>
				<td class="evenrow-l" width="70%">%value SocketAuditInfo/socketName%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Start Time</td>
				<td class="evenrow-l" width="70%">%value SocketAuditInfo/auditStartTime%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">End Time</td>
				<td class="evenrow-l" width="70%">%value SocketAuditInfo/auditEndTime%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Duration</td>
				<td class="evenrow-l" width="70%">%value SocketAuditInfo/duration% milliseconds</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Target System</td>
				<td class="evenrow-l" width="70%">%value SocketAuditInfo/targetSystemName%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Interface ID</td>
				<td class="evenrow-l" width="70%">%value SocketAuditInfo/interfaceID%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Doc ID</td>
				<td class="evenrow-l" width="70%">%value SocketAuditInfo/docID%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Doc Description</td>
				<td class="evenrow-l" width="70%">%value SocketAuditInfo/docDesc%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Transaction ID</td>
				<td class="evenrow-l" width="70%">%value SocketAuditInfo/transactionID%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Execution Server</td>
				<td class="evenrow-l" width="70%">%value SocketAuditInfo/serverIP%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Status</td>
				<td class="evenrow-l" width="70%">%ifvar SocketAuditInfo/resultCode equals('F')%<font color="red">Fail</font>%else%Success%endifvar%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Error Message</td>
				<td class="evenrow-l" width="70%">
					<textarea cols="200" rows="10">%value SocketAuditInfo/resultMsg%</textarea>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Socket Log</td>
				<td class="evenrow-l" width="70%"><textarea cols="200" rows="20">%value SocketAuditInfo/socketLog%</textarea></td>
			</tr>
		</table>
		
		<!-- 전문처리 상세 Flow -->
		%ifvar SocketAuditInfo/processStepList -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading">Process Details</td>
			</tr>
			%loop SocketAuditInfo/processStepList%
				<tr>
					<td>%value SocketAuditInfo/processStepList%</td>
				</tr>
			%endloop%
		</table>
		%endifvar%
		
		<form name="pform" method="post" action="/invoke/JSocketAdapter.ADMIN/adminRemoteServerAuditLog">
		<table class="tableForm" width="100%">
			<tr>
				<td class="action" colspan="2">
					<input type="hidden" name="todo" value="">
					<input type="hidden" name="fullFileName" value="%value fullFileName%">
					<input type="hidden" name="moveAction" value="/JSocketAdapter/socketlog-remoteauditdetail.dsp">
					<input type="button" name="SUBMIT" value="Download Schema Def"  onclick="return doAction('downSchemadef')"></input>&nbsp;&nbsp;
					<input type="button" name="SUBMIT" value="Download Audit Data"  onclick="return doAction('downAuditdata')"></input>&nbsp;&nbsp;
					<input type="button" name="SUBMIT" value="Download Schema Def & Audit Data"  onclick="return doAction('downAll')"></input>
				</td>
			</tr>
		</table>
		</form>
		
		%ifvar SocketAuditInfo/DocReqCommonSchema -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="5">%value reqCommonSchemaTitle%전문 공통정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>필드명</td>
				<td>필드설명</td>
				<td>필드길이</td>
				<td>패딩문자</td>
				<td>패딩타입</td>
			</tr>
			%loop SocketAuditInfo/DocReqCommonSchema%
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
							var listDepth = %value listDepth%;
							
							for (i = 0; i < (listDepth * 2); i += 1) {
								document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
							}
						</script>
						%value listName% Array Schema
					</td>
				%endifvar%
				</tr>
			%endloop%
		</table>
		%endifvar%
		
		%ifvar SocketAuditInfo/DocReqBodySchema -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="5">%value reqBodySchemaTitle%전문 업무정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>필드명</td>
				<td>필드설명</td>
				<td>필드길이</td>
				<td>패딩문자</td>
				<td>패딩타입</td>
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
							var listDepth = %value listDepth%;
							
							for (i = 0; i < (listDepth * 2); i += 1) {
								document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
							}
						</script>
						%value listName% Array Schema
					</td>
				%endifvar%
				</tr>
			%endloop%
		</table>
		%endifvar%
		
		%ifvar SocketAuditInfo/DocReqCommonData -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">요청전문 공통정보부 Data</td>
			</tr>
			%loop SocketAuditInfo/DocReqCommonData%
				%ifvar idataType equals('field')% <!-- Single Record인 경우 -->
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
		
		%ifvar SocketAuditInfo/DocReqBodyData -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">요청전문 업무정보부 Data</td>
			</tr>
			%loop SocketAuditInfo/DocReqBodyData%				
				%ifvar idataType equals('field')% <!-- Single Record인 경우 -->
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
		
		%ifvar SocketAuditInfo/DocResCommonSchema -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="5">응답전문 공통정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>필드명</td>
				<td>필드설명</td>
				<td>필드길이</td>
				<td>패딩문자</td>
				<td>패딩타입</td>
			</tr>
			%loop SocketAuditInfo/DocResCommonSchema%
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
							var listDepth = %value listDepth%;
							
							for (i = 0; i < (listDepth * 2); i += 1) {
								document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
							}
						</script>
						%value listName% Array Schema
					</td>
				%endifvar%
				</tr>
			%endloop%
		</table>
		%endifvar%
		
		%ifvar SocketAuditInfo/DocResBodySchema -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="5">응답전문 업무정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>필드명</td>
				<td>필드설명</td>
				<td>필드길이</td>
				<td>패딩문자</td>
				<td>패딩타입</td>
			</tr>
			%loop SocketAuditInfo/DocResBodySchema%
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
							var listDepth = %value listDepth%;
							
							for (i = 0; i < (listDepth * 2); i += 1) {
								document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
							}
						</script>
						%value listName% Array Schema
					</td>
				%endifvar%
				</tr>
			%endloop%
		</table>
		%endifvar%
		
		%ifvar SocketAuditInfo/DocResCommonData -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">응답전문 공통정보부 Data</td>
			</tr>
			%loop SocketAuditInfo/DocResCommonData%
				%ifvar idataType equals('field')% <!-- Single Record인 경우 -->
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
		
		%ifvar SocketAuditInfo/DocResBodyData -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">응답전문 업무정보부 Data</td>
			</tr>
			%loop SocketAuditInfo/DocResBodyData%				
				%ifvar idataType equals('field')% <!-- Single Record인 경우 -->
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