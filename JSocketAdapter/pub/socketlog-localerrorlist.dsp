%invoke JSocketAdapter.ADMIN:adminLocalServerErrorLog%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, pageNum, fileName){
				var frm = document.pform;				
				
				if (todo == "search") {
					var logDate = frm.logDate.value;
					var portNumber = frm.portNumber.value;
					var pageSize = frm.pageSize.value;
					
					if (logDate == "") {
						alert("Log Date를 입력하십시요.");
						return;
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
					window.open('/JSocketAdapter/socketlog-localerrordetail.dsp?todo=read&fullFileName=' + fileName, '', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
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
			<input type="hidden" name="pageNum" value="">
			<input type="hidden" name="selectedList" value="">
			<input type="hidden" name="checkMode" value="uncheck">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Socket Log &gt;
						Local Server Error Log
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Search Condition</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Log Date</td>
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
				<td class="evenrow" width="30%">Port Number</td>
				<td class="evenrow-l" width="70%">
					<select name="portNumber" style="width:300">
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
				<td class="evenrow" width="30%">Doc ID</td>
				<td class="evenrow-l" width="70%">
					<select name="docID" style="width:300">
						<option value="">ALL</option>
						%loop DocNameList%
							<option value="%value docNameValue%">%value docNameDisplay%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.docID.value = "%value docID%";
					</script>
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
					<select name="sorting" style="width:300">
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
				<td class="heading" colspan=8>Local Server Error Log (총 조회 건수 : %value searchCount%)</td>
			</tr>
			<tr class="subheading2">
				<td>Select <a href="javascript:allChecked()">All</a></td>
				<td>Port Number</td>
				<td>Start Time</td>
				<td>Interface ID</td>
				<td>Doc ID</td>
				<td>Transaction ID</td>
				<td>Execution Server</td>
				<td>Resubmit YN</td>
			</tr>
			%ifvar -notempty SocketAuditInfoList%			
				%loop SocketAuditInfoList -$index%
					<tr>
						<td class="evenrowdata"><input type="checkbox" name="selectedList%value $index%" value="%value fullFileName%">
						<td>%value portNumber%</td>
						<td>%value auditStartTime%</td>
						<td>%value interfaceID%</td>
						<td>%value docID%</td>
						<td><a href="javascript:doAction('read', '', '%value fullFileName%')">%value transactionID%</a></td>
						<td>%value serverIP%</td>
						<td>%ifvar resubmit equals('Yes')%<font color="red">Yes</font>%else%No%endifvar%</td>
					</tr>
				%endloop%
				<!-- Paging -->
				<tr class="subheading2">
					<td colspan=9>
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
				<tr><td colspan=8>No local server error logs are currently saved.</td></tr>
			%endifvar%
		</table>				
		</form>		
	</body>
</html>

%endinvoke%