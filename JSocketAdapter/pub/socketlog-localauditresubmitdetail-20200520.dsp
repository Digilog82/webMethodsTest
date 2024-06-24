%invoke JSocketAdapter.ADMIN:adminLocalServerAuditLog%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction() {
				var commonDataChange = document.pform.commonDataChange.value;
				var bodyDataChange = document.pform.bodyDataChange.value;
				
				if (commonDataChange == "" && bodyDataChange == "") {
					if (confirm("수정된 데이터가 없습니다. 데이터 수정 없이 Resubmit 하시겠습니까?")) {
					} else {
						return;
					}
				}
				
				alert("Resubmit 처리 후 Socket Log > Local Server Resubmit Log > Details 화면으로 이동하여 처리결과를 조회합니다.");
				document.pform.submit();
			}
			
			function makeChangeList(chgName, chgValue, orgValue) {
				if (chgValue == orgValue) {
					alert("데이터가 수정되지 않았습니다.");
					return;
				}
				
				var comBody = chgName.substring(0, 1);
				
				if (comBody == "C") {
					// 공통정보부 데이터 수정인 경우
					if (document.pform.commonDataChange.value == "") {
						document.pform.commonDataChange.value = chgName + "$$" + chgValue;
					} else {
						document.pform.commonDataChange.value = document.pform.commonDataChange.value + "||" + chgName + "$$" + chgValue;
					}
				} else if (comBody == "B") {
					// 업무정보부 데이터 수정인 경우
					if (document.pform.bodyDataChange.value == "") {
						document.pform.bodyDataChange.value = chgName + "$$" + chgValue;
					} else {
						document.pform.bodyDataChange.value = document.pform.bodyDataChange.value + "||" + chgName + "$$" + chgValue;
					}
				}
			}
		</script>
	</head>
	<body>
	
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" action="socketlog-localreauditdetail.dsp">
			<input type="hidden" name="todo" value="resubmit">
			<input type="hidden" name="orgTransactionID" value="%value SocketAuditInfo/transactionID%">
			<input type="hidden" name="orgAuditLogFileName" value="%value fullFileName%">
			<input type="hidden" name="commonDataChange" value="">
			<input type="hidden" name="bodyDataChange" value="">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Socket Log &gt;
						Local Server Audit Log &gt;
						Details
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Transaction Basic Info</td>
			</tr>
			<tr>
				<tr>
					<td class="evenrow" width="30%">Port Number</td>
					<td class="evenrow-l" width="70%">%value SocketAuditInfo/portNumber%</td>
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
				%ifvar SocketAuditInfo/orgTransactionID -notempty%
				<tr>
					<td class="evenrow" width="30%">Original Transaction ID</td>
					<td class="evenrow-l" width="70%">%value SocketAuditInfo/orgTransactionID%</td>
				</tr>
				%endifvar%
				<tr>
					<td class="evenrow" width="30%">Execution Server</td>
					<td class="evenrow-l" width="70%">%value SocketAuditInfo/serverIP%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Status</td>
					<td class="evenrow-l" width="70%">
						%ifvar SocketAuditInfo/resultCode equals('F')%<font color="red">Fail</font>%else%Success%endifvar%
						%ifvar SocketAuditInfo/orgTransactionID -notempty%<font color="red">(Resubmitted)</font>%endifvar%
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Error Message</td>
					<td class="evenrow-l" width="70%">%value SocketAuditInfo/resultMsg%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Socket Log</td>
					<td class="evenrow-l" width="70%"><textarea cols="200" rows="20">%value SocketAuditInfo/socketLog%</textarea></td>
				</tr>
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
		
		%ifvar SocketAuditInfo/DocReqCommonSchema -notempty%
		<table class="tableForm" width="100%">
			%ifvar reqSchemaDefType equals('EN')%
			<!-- Endian 변환이 필요 없는 일반적인 경우 -->
			<tr>
				<td class="heading" colspan="5">요청전문 공통정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Field Length</td>
				<td>Padding Char</td>
				<td>Padding Type</td>
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
			%else%
			%ifvar reqSchemaDefType equals('ER')%
			<!-- 전문 수신 시 Endian 변환이 필요한 경우 -->
			<tr>
				<td class="heading" colspan="5">요청전문 공통정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Data Type</td>
				<td>Field Length</td>
				<td>Array Count</td>
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
			%else%
			%ifvar reqSchemaDefType equals('ES')%
			<!-- 전문 송신 시 Endian 변환이 필요한 경우 -->
			<tr>
				<td class="heading" colspan="8">요청전문 공통정보부 Schema 정의</td>
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
					<td class="subheading2" colspan="8">
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
			%endifvar%
			%endifvar%
			%endifvar%
		</table>
		%endifvar%
		
		%ifvar SocketAuditInfo/DocReqBodySchema -notempty%
		<table class="tableForm" width="100%">
			%ifvar reqSchemaDefType equals('EN')%
			<!-- Endian 변환이 필요 없는 일반적인 경우 -->
			<tr>
				<td class="heading" colspan="5">요청전문 업무정보부 Schema 정의</td>
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
			%else%
			%ifvar reqSchemaDefType equals('ER')%
			<!-- 전문 수신 시 Endian 변환이 필요한 경우 -->
			<tr>
				<td class="heading" colspan="5">요청전문 업무정보부 Schema 정의</td>
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
			%else%
			%ifvar reqSchemaDefType equals('ES')%
			<!-- 전문 송신 시 Endian 변환이 필요한 경우 -->
			<tr>
				<td class="heading" colspan="8">요청전문 업무정보부 Schema 정의</td>
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
			%endifvar%
			%endifvar%
			%endifvar%
		</table>
		%endifvar%
		
		%ifvar SocketAuditInfo/DocReqCommonData -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">요청전문 공통정보부 Data</td>
			</tr>
			%loop SocketAuditInfo/DocReqCommonData%
				%ifvar idataType equals('field')% <!-- Single Record인 경우 -->
					<!-- 상위에서 List 끝난 후에 Single Record가 나오는 경우. Table을 닫아 준다. -->
					%ifvar beforeListExist equals('true')%
						</table>
						<table class="tableForm" width="100%">
					%endifvar%
					<tr>
						<td class="evenrow" width="30%">%value fieldName%</td>
						<td class="evenrow-l" width="70%"><input type="text" name="C_S_%value fieldNameOnly%" value="%value fieldValue%" style="font-size:10pt;width:400" onblur="makeChangeList(this.name, this.value, '%value fieldValue%')"></td>
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
								%ifvar titleValue equals('value')%
									<input type="text" name="C_A_%value listDepth%_%value listNameOnly%_%value listIndex%_%value $index%" value="%value valueList%" style="font-size:10pt;width:200" onblur="makeChangeList(this.name, this.value, '%value valueList%')">
								%else%
									%value valueList%
								%endifvar%
								</td>
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
					<!-- 상위에서 List 끝난 후에 Single Record가 나오는 경우. Table을 닫아 준다. -->
					%ifvar beforeListExist equals('true')%
						</table>
						<table class="tableForm" width="100%">
					%endifvar%
					<tr>
						<td class="evenrow" width="30%">%value fieldName%</td>
						<td class="evenrow-l" width="70%"><input type="text" name="B_S_%value fieldNameOnly%" value="%value fieldValue%" style="font-size:10pt;width:400" onblur="makeChangeList(this.name, this.value, '%value fieldValue%')"></td>
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
								%ifvar titleValue equals('value')%
									<input type="text" name="B_A_%value listDepth%_%value listNameOnly%_%value listIndex%_%value $index%" value="%value valueList%" style="font-size:10pt;width:200" onblur="makeChangeList(this.name, this.value, '%value valueList%')">
								%else%
									%value valueList%
								%endifvar%
								</td>
							%endloop%
							</tr>
					%endifvar%
				%endifvar%
			%endloop%
		</table>
		%endifvar%
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="action">
					<input type="button" name="SUBMIT" value="Resubmit"  onclick="return doAction()"></input>
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>

%endinvoke%