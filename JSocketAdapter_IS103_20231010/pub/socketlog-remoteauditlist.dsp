%invoke JSocketAdapter.ADMIN:adminRemoteServerAuditLog%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, pageNum, fileName){
				var frm = document.pform;
				var serverRole = "%value serverRole%";
				
				if (serverRole == "GW" && todo != "search") {
					alert("Gateway Server에서는 Audit Log 목록 조회만 가능합니다.");
					return;
				}
				
				if (todo == "search") {
					var cAuditLogFolder = "%value cAuditLogFolder%";
					var logDate = frm.logDate.value;
					var socketName = frm.socketName.value;
					var targetSystemName = frm.targetSystemName.value;
					var interfaceID = frm.interfaceID.value;
					var resultCode = frm.resultCode.value;
					var transactionID = frm.transactionID.value;
					var pageSize = frm.pageSize.value;
					
					if (logDate == "") {
						alert("Log Date를 입력하십시요.");
						return;
					}
					
					if (cAuditLogFolder == "CUR_DATE") {
						// 날짜별 폴더에 Audit Log를 저장하는 경우
						// Socket Name, Target System, Interface ID를 ALL을 선택한 경우에는 Status를 Fail을 선택한 경우에만 조회 가능하도록 한다. ==> 조회 건수가 너무 많은 경우에는 서버 성능에 영향을 주기 때문
						/*
						if (socketName == "" && targetSystemName == "" && interfaceID == "" && transactionID == "") {
							if (resultCode != "F") {
								alert("Socket Name, Target System, Interface ID를 ALL을 선택한 경우에는 Status를 Fail을 선택해야만 조회 가능합니다.");
								return;
							}
						}
						*/
					} else if (cAuditLogFolder == "SOCKET_NAME") {
						// 날짜별/SocketName별 폴더에 Audit Log를 저장하는 경우
						if (socketName == "") {
							alert("Socket Name을 선택하십시요.");
							return;
						}
					} else if (cAuditLogFolder == "DOC_ID") {
						// 날짜별/SocketName별/인터페이스ID별 폴더에 Audit Log를 저장하는 경우
						if (socketName == "") {
							alert("Socket Name을 선택하십시요.");
							return;
						}
						
						if (interfaceID == "") {
							alert("Interface ID를 선택하십시요.");
							return;
						}
					}
					
					if (pageSize == "") {
						alert("Page Size를 입력하십시요.");
						return;
					}
					
					frm.todo.value = todo;
					frm.pageNum.value = pageNum;
					frm.submit();
				} else {
					window.open('/JSocketAdapter/socketlog-remoteauditdetail.dsp?todo=read&fullFileName=' + fileName, '', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
				}
			}
			
			function setStatus(searchItem, searchValue) {
				// Socket Name, Target System, Interface ID를 ALL을 선택한 경우에는 Status를 Fail을 선택한 경우에만 조회 가능하도록 한다.
				/*
				var cAuditLogFolder = "%value cAuditLogFolder%";
				var sValue1 = "";
				var sValue2 = "";
				var sValue3 = document.pform.resultCode.value;
				var sValue4 = document.pform.transactionID.value;
				
				if (searchItem == "socketName") {
					sValue1 = document.pform.targetSystemName.value;
					sValue2 = document.pform.interfaceID.value;
				} else if (searchItem == "targetSystemName") {
					sValue1 = document.pform.socketName.value;
					sValue2 = document.pform.interfaceID.value;
				} else {
					sValue1 = document.pform.socketName.value;
					sValue2 = document.pform.targetSystemName.value;
				}
				
				if (cAuditLogFolder == "CUR_DATE") {
					// 날짜별 폴더에 Audit Log를 저장하는 경우에만 수행
					if (searchValue == "" && sValue1 == "" && sValue2 == "" && sValue3 != "F" && sValue4 == "") {
						document.pform.resultCode.value = "F";
						alert("Socket Name, Target System, Interface ID를 ALL을 선택한 경우에는 Status를 Fail을 선택해야만 조회 가능합니다.");
					}
				}
				*/
			}
		</script>
	</head>
	<body>
	
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">
			<input type="hidden" name="todo" value="">
			<input type="hidden" name="pageNum" value="">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Socket Log &gt;
						Remote Server Audit Log
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Search Condition</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Log Date <font color="red">*</font></td>
				<td class="evenrow-l" width="70%">
					<input type="text" name="logDate" value="%value logDate%" style="font-size:10pt;width:100"> (Date Format : yyyyMMdd)
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Log Time</td>
				<td class="evenrow-l" width="70%">
					<input type="text" name="fromTime" value="%value fromTime%" style="font-size:10pt;width:100"> ~ <input type="text" name="toTime" value="%value toTime%" style="font-size:10pt;width:100"> (Time Format : HHmmss)
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Socket Name%ifvar cAuditLogFolder equals('SOCKET_NAME')%&nbsp;<font color="red">*</font>%else%%ifvar cAuditLogFolder equals('DOC_ID')%&nbsp;<font color="red">*</font>%endifvar%%endifvar%</td>
				<td class="evenrow-l" width="70%">
					<select name="socketName" style="width:350" onchange="setStatus('socketName', this.value)">
						<option value="">ALL</option>
						%loop SocketNameList%
							<option value="%value socketNameValue%">%value socketNameDisplay%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.socketName.value = "%value socketName%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Target System</td>
				<td class="evenrow-l" width="70%">
					<select name="targetSystemName" style="width:350" onchange="setStatus('targetSystemName', this.value)">
						<option value="">ALL</option>
						%loop SystemNameDescList%
							<option value="%value systemNameValue%">%value systemNameDisplay%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.targetSystemName.value = "%value targetSystemName%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Interface ID%ifvar cAuditLogFolder equals('DOC_ID')%&nbsp;<font color="red">*</font>%endifvar%</td>
				<td class="evenrow-l" width="70%">
					<select name="interfaceID" style="width:350" onchange="setStatus('interfaceID', this.value)">
						<option value="">ALL</option>
						%loop InterfaceIDList%
							<option value="%value interfaceIDValue%">%value interfaceIDDisplay%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.interfaceID.value = "%value interfaceID%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Status</td>
				<td class="evenrow-l" width="70%">
					<select name="resultCode" style="width:350">
						<option value="">ALL</option>
						<option value="S">Success</option>
						<option value="F">Fail</option>
					</select>
					<script language="javascript">
						document.pform.resultCode.value = "%value resultCode%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Transaction ID</td>
				<td class="evenrow-l" width="70%">
					<input type="text" name="transactionID" value="%value transactionID%" style="font-size:10pt;width:350">
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Page Size</td>
				<td class="evenrow-l" width="70%">
					<input type="text" name="pageSize" value="%value pageSize%" style="font-size:10pt;width:100">
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Start Time Sorting</td>
				<td class="evenrow-l" width="70%">
					<select name="sorting" style="width:350">
						<option value="descending">Descending</option>
						<option value="ascending">Ascending</option>
					</select>
					<script language="javascript">
						document.pform.sorting.value = "%value sorting%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="action" colspan="2">
					<input type="button" name="SUBMIT" value="Search Logs"  onclick="return doAction('search', '1', '')"></input>
				</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan=10>Remote Server Audit Log (총 조회 건수 %value searchCount% ::: %value filePath% 디렉토리 총 건수 %value dirTotalFileCount%)</td>
			</tr>
			<tr class="subheading2">
				<td>Socket Name</td>
				<td>Start Time</td>
				<td>End Time</td>
				<td>Duration(Millis)</td>
				<td>Target System</td>
				<td>Interface ID</td>
				<td>Doc ID</td>
				<td>Transaction ID</td>
				<td>Execution Server</td>
				<td>Status</td>
			</tr>
			%ifvar -notempty SocketAuditInfoList%			
				%loop SocketAuditInfoList%
					<tr>
						<td>%value socketName%</td>
						<td>%value auditStartTime%</td>
						<td>%value auditEndTime%</td>
						<td>%value duration%</td>
						<td>%value targetSystemName%</td>
						<td>%value interfaceID%</td>
						<td>%value docID%</td>
						<td><a href="javascript:doAction('read', '', '%value fullFileName%')">%value transactionID%</a></td>
						<td>%value serverIP%</td>
						<td>%ifvar resultCode equals('F')%<font color="red">Fail</font>%else%Success%endifvar%</td>
					</tr>
				%endloop%
				<!-- Paging -->
				<tr class="subheading2">
					<td colspan=10>
						<script language="javascript">
							var totalPages = %value totalPages%;
							var curPageNum = %value pageNum%;
							
							if (totalPages > 0) {
								for (var i = 1; i <= totalPages; i++) {
									if ( i == 1) {
										if (i == curPageNum) {
											document.write(i);
										} else {
											document.write("<a href=\"javascript:doAction('search', '" + i + "', '')\">" + i + "</a>");
										}
									} else if (i == 51) {
										document.write("&nbsp;&nbsp;...");
										break;
									} else {
										if (i == curPageNum) {
											document.write("&nbsp;&nbsp;" + i);
										} else {
											document.write("&nbsp;&nbsp;<a href=\"javascript:doAction('search', '" + i + "', '')\">" + i + "</a>");
										}
									}
								}
							} else {
								document.write("1");
							}
						</script>
					</td>
				</tr>
			%else%
				<tr><td colspan=10>No remote server audit logs are currently saved.</td></tr>
			%endifvar%
		</table>				
		</form>		
	</body>
</html>

%endinvoke%