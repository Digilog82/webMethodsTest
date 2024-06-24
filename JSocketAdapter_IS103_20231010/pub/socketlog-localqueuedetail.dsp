%invoke JSocketAdapter.ADMIN:adminQueueSendInfo%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction() {
				var skip = "%value QueueSendInfo/skip%";
				
				if (skip == "true") {
					alert("이미 Skip 처리 하도록 설정되어 있습니다.");
					return;
				} else {
					if (confirm("Skip Status를 Yes로 업데이트 하면 복구가 불가능 하고\nRequest Data가 사라집니다. 업데이트 하시겠습니까?")) {
						document.pform.submit();
					} else {
						return;
					}
				}
			}
			
			function alertMsg() {
				var frm = document.pform;
				var msg = frm.alertMsg.value;
				
				if (msg != "") {
					alert(msg);
					frm.alertMsg.value = ""; // 다른 화면으로 이동 시 영향을 주기 때문에 alertMsg 를 공백처리 한다.
				}
			}
		</script>
	</head>
	<body onload="javascript:alertMsg()">
		%ifvar changed equals('true')%
			<form name="dform" method="post">
				<input type="hidden" name="todo" value="read">
				<input type="hidden" name="alertMsg" value="%value alertMsg%">
				<input type="hidden" name="fullFileName" value="%value fullFileName%">
			</form>
			<script langauge='javascript'>
				document.dform.submit();
			</script>
		%endifvar%
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
				
		<form name="pform" method="post" target="_self">
			<input type="hidden" name="todo" value="skip">
			<input type="hidden" name="alertMsg" value="%value alertMsg%">
			<input type="hidden" name="fullFileName" value="%value fullFileName%">
			<input type="hidden" name="selectedList" value="%value fullFileName%">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Socket Log &gt;
						Local Server Queue Info &gt;
						Details
					</td>
			</tr>
		</table>
		
		%ifvar existFile equals('true')%
		<table class="tableForm" width="100%">
			<tr>
				<td class="action" colspan="2">
					<input type="button" name="SUBMIT" value="Update Skip Status"  onclick="return doAction()"></input>
				</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Transaction Basic Info</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Port Number</td>
				<td class="evenrow-l" width="70%">%value QueueSendInfo/portNumber%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Queue Send Time</td>
				<td class="evenrow-l" width="70%">%value QueueSendInfo/sendStartTime%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Duration</td>
				<td class="evenrow-l" width="70%">%value QueueSendInfo/duration% milliseconds</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Interface ID</td>
				<td class="evenrow-l" width="70%">%value QueueSendInfo/interfaceID%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Doc ID</td>
				<td class="evenrow-l" width="70%">%value QueueSendInfo/docID%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Doc Description</td>
				<td class="evenrow-l" width="70%">%value QueueSendInfo/docDesc%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Execution Server</td>
				<td class="evenrow-l" width="70%">%value QueueSendInfo/serverIP%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Skip Status</td>
				<td class="evenrow-l" width="70%">%ifvar QueueSendInfo/skip equals('true')%<font color="red">Yes</font>%else%No%endifvar%</td>
			</tr>
		</table>
		
		%ifvar QueueSendInfo/DocReqCommonSchema -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="5">전문 공통정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>필드명</td>
				<td>필드설명</td>
				<td>필드길이</td>
				<td>패딩문자</td>
				<td>패딩타입</td>
			</tr>
			%loop QueueSendInfo/DocReqCommonSchema%
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
		
		%ifvar QueueSendInfo/DocReqBodySchema -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="5">전문 업무정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>필드명</td>
				<td>필드설명</td>
				<td>필드길이</td>
				<td>패딩문자</td>
				<td>패딩타입</td>
			</tr>
			%loop QueueSendInfo/DocReqBodySchema%
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
		
		%ifvar QueueSendInfo/DocReqCommonData -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">요청전문 공통정보부 Data</td>
			</tr>
			%loop QueueSendInfo/DocReqCommonData%
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
		
		%ifvar QueueSendInfo/DocReqBodyData -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">요청전문 업무정보부 Data</td>
			</tr>
			%loop QueueSendInfo/DocReqBodyData%				
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
		%endifvar%
		</form>
	</body>
</html>

%endinvoke%