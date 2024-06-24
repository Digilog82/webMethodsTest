%invoke JSocketAdapter.ADMIN:adminLocalServerAuditLog%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, pageNum, fileName) {
				var frm = document.pform;
				var serverRole = "%value serverRole%";				
				
				if (serverRole == "GW" && todo != "search") {
					alert("Gateway Server에서는 Audit Log 목록 조회만 가능합니다.");
					return;
				}
				
				if (todo == "search") {
					var sAuditLogFolder = "%value sAuditLogFolder%";
					var logDate = frm.logDate.value;
					var fromTime = frm.fromTime.value;
					var toTime = frm.toTime.value;
					var portNumber = frm.portNumber.value;
					var targetSystemName = frm.targetSystemName.value;
					var docID = frm.docID.value;
					var resultCode = frm.resultCode.value;
					var transactionID = frm.transactionID.value;
					var pageSize = frm.pageSize.value;
					
					if (logDate == "") {
						alert("Log Date를 입력하십시요.");
						return;
					}
					
					if (sAuditLogFolder == "CUR_DATE") {
						// 날짜별 폴더에 Audit Log를 저장하는 경우
						// 조회조건을 입력하지 않은 경우에는 Status를 Fail을 선택한 경우에만 조회 가능하도록 한다. ==> 조회 건수가 너무 많은 경우에는 서버 성능에 영향을 주기 때문
						if (fromTime == "" && toTime == "" && portNumber == "" && targetSystemName == "" && docID == "" && transactionID == "") {
							if (resultCode != "F") {
								alert("조회조건을 입력하지 않은 경우에는 Status를 Fail을 선택해야만 조회 가능합니다.");
								return;
							}
						}
					} else if (sAuditLogFolder == "PORT_NUMBER") {
						// 날짜별/Port Number별 폴더에 Audit Log를 저장하는 경우
						if (portNumber == "") {
							alert("Port Number를 선택하십시요.");
							return;
						}
					} else if (sAuditLogFolder == "DOC_ID") {
						// 날짜별/Port Number별/전문ID별 폴더에 Audit Log를 저장하는 경우
						if (portNumber == "") {
							alert("Port Number를 선택하십시요.");
							return;
						}
						
						if (docID == "") {
							alert("Doc ID를 선택하십시요.");
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
				} else if (todo == "multiresubmit") {
					for (var i=0; i < frm.length; i++) {
						if (frm.elements[i].checked) {
							if (frm.selectedList.value == "") {
								frm.selectedList.value = frm.elements[i].value;
							} else {
								frm.selectedList.value = frm.selectedList.value + "|" + frm.elements[i].value;
							}
						}
					}
					
					if (frm.selectedList.value == "") {
						alert("Resubmit 할 Transaction을 선택하십시요.");
						return;
					}
					
					if (confirm("선택한 Transaction에 대해서 Resubmit 하시겠습니까?")) {
						alert("Resubmit 처리 후 Socket Log > Local Server Resubmit Log 화면으로 이동하여 처리결과를 조회합니다.");
					} else {
						return;
					}
					
					parent.menu.menuSelect("isocketlog-localreauditlist.dsp", "socketlog-localreauditlist.dsp");
					frm.todo.value = todo;
					frm.submit();
				} else {
					var dspName = "";
					
					if (todo == "read") {
						dspName = "socketlog-localauditdetail.dsp";
					} else if (todo == "resubmitread") {
						dspName = "socketlog-localauditresubmitdetail.dsp";
					}
					
					window.open('/JSocketAdapter/' + dspName + '?todo=' + todo + '&fullFileName=' + fileName, '', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
				}
			}
			
			function setStatus(searchItem, searchValue) {
				// 조회조건을 입력하지 않은 경우에는 Status를 Fail을 선택한 경우에만 조회 가능하도록 한다.
				var sAuditLogFolder = "%value sAuditLogFolder%";
				var sValue1 = "";
				var sValue2 = "";
				var sValue3 = document.pform.resultCode.value;
				var sValue4 = document.pform.transactionID.value;
				var sValue5 = document.pform.fromTime.value;
				var sValue6 = document.pform.toTime.value;
				
				if (searchItem == "portNumber") {
					sValue1 = document.pform.targetSystemName.value;
					sValue2 = document.pform.docID.value;
				} else if (searchItem == "targetSystemName") {
					sValue1 = document.pform.portNumber.value;
					sValue2 = document.pform.docID.value;
				} else {
					sValue1 = document.pform.portNumber.value;
					sValue2 = document.pform.targetSystemName.value;
				}
				
				if (sAuditLogFolder == "CUR_DATE") {
					// 날짜별 폴더에 Audit Log를 저장하는 경우에만 수행
					if (searchValue == "" && sValue1 == "" && sValue2 == "" && sValue3 != "F" && sValue4 == "" && sValue5 == "" && sValue6 == "") {
						document.pform.resultCode.value = "F";
						alert("조회조건을 입력하지 않은 경우에는 Status를 Fail을 선택해야만 조회 가능합니다.");
					}
				}
			}
			
			function allChecked() {
				var checkMode = document.pform.checkMode.value;
				var eleName;
				
				if (checkMode == "uncheck") { // All Checked
					for (var i=0; i < document.pform.length; i++) {
						eleName = document.pform.elements[i].name;
						
						if (eleName.indexOf("selectedList") >= 0) {
							if (!document.pform.elements[i].checked) {
								document.pform.elements[i].checked = true;
							}
						}
					}
					
					document.pform.checkMode.value = "check";
				} else { // All Unchecked
					for (var i=0; i < document.pform.length; i++) {
						eleName = document.pform.elements[i].name;
						
						if (eleName.indexOf("selectedList") >= 0) {
							if (document.pform.elements[i].checked) {
								document.pform.elements[i].checked = false;
							}
						}
					}
					
					document.pform.checkMode.value = "uncheck";
				}
			}
		</script>
	</head>
	<body>
		
		%ifvar todo equals('multiresubmit')%
			<form name="dform" action="socketlog-localreauditlist.dsp" method="post">
				<input type="hidden" name="todo" value="search">
				<input type="hidden" name="execType" value="R">
				<input type="hidden" name="sorting" value="descending">
				<input type="hidden" name="logDate" value="%value logDate%">
				<input type="hidden" name="portNumber" value="%value portNumber%">
				<input type="hidden" name="targetSystemName" value="%value targetSystemName%">
				<input type="hidden" name="docID" value="%value docID%">
				<input type="hidden" name="pageNum" value="1">
				<input type="hidden" name="pageSize" value="%value pageSize%">
			</form>
			<script langauge='javascript'>
				document.dform.submit();
			</script>
		%endifvar%
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">
			<input type="hidden" name="todo" value="">
			<input type="hidden" name="execType" value="S">
			<input type="hidden" name="pageNum" value="">
			<input type="hidden" name="selectedList" value="">
			<input type="hidden" name="checkMode" value="uncheck">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Socket Log &gt;
						Local Server Audit Log
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
				<td class="evenrow" width="30%">Port Number%ifvar sAuditLogFolder equals('PORT_NUMBER')%&nbsp;<font color="red">*</font>%else%%ifvar sAuditLogFolder equals('DOC_ID')%&nbsp;<font color="red">*</font>%endifvar%%endifvar%</td>
				<td class="evenrow-l" width="70%">
					<select name="portNumber" style="width:350" onchange="setStatus('portNumber', this.value)">
						<option value="">ALL</option>
						%loop PortNumberList%
							<option value="%value portNumberValue%">%value portNumberDisplay%</option>
						%endloop%							
					</select>
					<script language="javascript">
						document.pform.portNumber.value = "%value portNumber%";
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
						<option value="UNKNOWNTSNM">UNKNOWNTSNM</option>
					</select>
					<script language="javascript">
						document.pform.targetSystemName.value = "%value targetSystemName%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Doc ID%ifvar sAuditLogFolder equals('DOC_ID')%&nbsp;<font color="red">*</font>%endifvar%</td>
				<td class="evenrow-l" width="70%">
					<select name="docID" style="width:350" onchange="setStatus('docID', this.value)">
						<option value="">ALL</option>
						%loop DocNameList%
							<option value="%value docNameValue%">%value docNameDisplay%</option>
						%endloop%
						<option value="UNKNOWNDOCID">UNKNOWNDOCID</option>
					</select>
					<script language="javascript">
						document.pform.docID.value = "%value docID%";
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
					<input type="button" name="SUBMIT" value="Search Logs"  onclick="return doAction('search', '1', '')"></input>&nbsp;&nbsp;
					<input type="button" name="SUBMIT" value="Resubmit"  onclick="return doAction('multiresubmit', '1', '')"></input>
				</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan=11>Local Server Audit Log (총 조회 건수 %value searchCount% ::: %value filePath% 디렉토리 총 건수 %value dirTotalFileCount%)</td>
			</tr>
			<tr class="subheading2">
				<td>Select <a href="javascript:allChecked()">All</a></td>
				<td>Port Number</td>
				<td>Start Time</td>
				<td>End Time</td>
				<td>Duration(Millis)</td>
				<td>Target System</td>
				<!--<td>Interface ID</td>-->
				<td>Doc ID</td>
				<td>Transaction ID</td>
				<td>Execution Server</td>
				<td>Status</td>
				<td>Resubmitted</td>
			</tr>
			%ifvar -notempty SocketAuditInfoList%			
				%loop SocketAuditInfoList -$index%
					<tr>
						<td class="evenrowdata"><input type="checkbox" name="selectedList%value $index%" value="%value fullFileName%">
						<td>%value portNumber%</td>
						<td>%value auditStartTime%</td>
						<td>%value auditEndTime%</td>
						<td>%value duration%</td>
						<td>%value targetSystemName%</td>
						<!--<td>%value interfaceID%</td>-->
						<td>%value docID%</td>
						<td><a href="javascript:doAction('read', '', '%value fullFileName%')">%value transactionID%</a></td>
						<td>%value serverIP%</td>
						<td>%ifvar resultCode equals('F')%<font color="red">Fail</font>%else%Success%endifvar%</td>
						<td><a href="javascript:doAction('resubmitread', '', '%value fullFileName%')">%ifvar resubmit equals('Yes')%<font color="red">Yes</font>%else%No%endifvar%</a></td>
					</tr>
				%endloop%
				<!-- Paging -->
				<tr class="subheading2">
					<td colspan=11>
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
				<tr><td colspan=11>No local server audit logs are currently saved.</td></tr>
			%endifvar%
		</table>				
		</form>		
	</body>
</html>

%endinvoke%