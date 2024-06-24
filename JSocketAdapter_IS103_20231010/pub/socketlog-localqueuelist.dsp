%invoke JSocketAdapter.ADMIN:adminQueueSendInfo%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, fileName){
				var frm = document.pform;
				
				if (todo == "search") {
					frm.todo.value = todo;
					frm.submit();
				} else if (todo == "skip") {
					if (confirm("Skip Status를 Yes로 업데이트 하면 복구가 불가능 하고\nRequest Data가 사라집니다. 업데이트 하시겠습니까?")) {
					} else {
						return;
					}
					
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
						alert("Skip 처리할 전문을 선택 하십시요.");
						return;
					} else {
						frm.todo.value = todo;
						frm.submit();
					}
				} else {
					window.open('/JSocketAdapter/socketlog-localqueuedetail.dsp?todo=read&fullFileName=' + fileName, '', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
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
				<input type="hidden" name="todo" value="search">
				<input type="hidden" name="alertMsg" value="%value alertMsg%">
				<input type="hidden" name="portNumber" value="%value portNumber%">
				<input type="hidden" name="docID" value="%value docID%">
				<input type="hidden" name="sorting" value="%value sorting%">
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
			<input type="hidden" name="alertMsg" value="%value alertMsg%">
			<input type="hidden" name="checkMode" value="uncheck">
			<input type="hidden" name="selectedList" value="">
			<input type="hidden" name="sorting" value="queueTopic">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Socket Log &gt;
						Local Server Queue Info
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Search Condition</td>
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
			<!--
			<tr>
				<td class="evenrow" width="30%">Queue Send Time Sorting</td>
				<td class="evenrow-l" width="70%">
					<select name="sorting" style="width:300">
						<option value="ascending">Ascending</option>
						<option value="descending">Descending</option>							
					</select>
					<script language="javascript">
						document.pform.sorting.value = "%value sorting%";
					</script>
				</td>
			</tr>
			-->
			<tr>
				<td class="action" colspan="2">
					<input type="button" name="SUBMIT" value="Search"  onclick="return doAction('search', '')"></input>&nbsp;&nbsp;
					<input type="button" name="SUBMIT" value="Update Skip Status"  onclick="return doAction('skip', '')"></input>
				</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan=8>Local Server Queue/Topic Message Info (총 조회 건수 : %value searchCount%)</td>
			</tr>
			<tr class="subheading2">
				<td>Port Number</td>
				<td>Queue/Topic Name</td>
				<td>Queue Send Time</td>
				<td>Duration(Millis)</td>						
				<td>Interface ID</td>
				<td>Doc ID <a href="javascript:allChecked()">All</a></td>
				<td>Execution Server</td>
				<td>Skip Status</td>
			</tr>
			%ifvar -notempty QueueSendInfoList%			
				%loop QueueSendInfoList%
					<tr>
						<td rowspan="%value portCount%">%value portNumber% (%value portCount%)</td>
						%loop QueueTopicList -$index%
							%ifvar $index equals('0')%
							%else%
								<tr>
							%endifvar%
								<td  rowspan="%value queueTopicCount%">%value queueTopicName% (%value queueTopicCount%)</td>
								%loop FileList -$index%
									%ifvar $index equals('0')%
									%else%
										<tr>
									%endifvar%
										<td>%value sendStartTime%</td>
										<td>%value duration%</td>
										<td>%value interfaceID%</td>
										<td><input type="checkbox" name="selectedList%value fileIndex%" value="%value fullFileName%"> <a href="javascript:doAction('read', '%value fullFileName%')">%value docID%</a></td>
										<td>%value serverIP%</td>
										<td>%ifvar skip equals('true')%<font color="red">Yes</font>%else%No%endifvar%</td>
									</tr>
								%endloop%
							</tr>
						%endloop%
					</tr>
				%endloop%
			%else%
				<tr><td colspan=8>No local server queue infos are currently saved.</td></tr>
			%endifvar%
		</table>
		</form>		
	</body>
</html>

%endinvoke%