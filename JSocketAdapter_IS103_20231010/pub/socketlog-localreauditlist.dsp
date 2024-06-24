%invoke JSocketAdapter.ADMIN:adminLocalServerAuditLog%

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
				} else {
					window.open('/JSocketAdapter/socketlog-localreauditdetail.dsp?todo=read&fullFileName=' + fileName, '', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
				}
			}
		</script>
	</head>
	<body>
	
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">
			<input type="hidden" name="todo" value="">
			<input type="hidden" name="execType" value="R">
			<input type="hidden" name="pageNum" value="">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Socket Log &gt;
						Local Server Resubmit Log
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
					<select name="portNumber" style="width:350">
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
					<select name="targetSystemName" style="width:350">
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
				<td class="evenrow" width="30%">Doc ID</td>
				<td class="evenrow-l" width="70%">
					<select name="docID" style="width:350">
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
				<td class="heading" colspan=9>Local Server Resubmit Log (총 조회 건수 : %value searchCount%)</td>
			</tr>
			<tr class="subheading2">
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
			</tr>
			%ifvar -notempty SocketAuditInfoList%
				%loop SocketAuditInfoList%
					<tr>
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
				<tr><td colspan=9>No local server resubmit logs are currently saved.</td></tr>
			%endifvar%
		</table>				
		</form>		
	</body>
</html>

%endinvoke%