%invoke JSocketAdapter.ADMIN:adminOnlineLocalServerList%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, pnum){
				var frm = document.pform;
				frm.todo.value = todo;
				var devProdType = "%value devProdType%";
				var serverDuplexing = "%value serverDuplexing%";
				var serverType = "";
				
				if (devProdType.indexOf("DEV") >= 0) {
					serverType = "개발";
				} else if (devProdType.indexOf("UAT") >= 0) {
					serverType = "UAT";
				} else if (devProdType.indexOf("PROD") >= 0) {
					serverType = "운영";
				}
				
				if(pnum != '') {
					frm.portNumber.value = pnum;
				}
					
				if(todo == 'search') {
					frm.submit();
				} else if(todo == 'read') {
					frm.action = "asynchonserver-connection.dsp";
					frm.submit();
				} else if (todo == 'runningYes') {
					/*
					// 다른 서버의 Port를 Down 시키지 않을 경우 Online Client 연결 갯수 동기화 등의 문제가 생기므로 아래 기능은 사용하지 않는다.
					if (serverDuplexing == "true") {
						// Clustering을 구성하는 서버가 두 대 이상인 경우 ==> 다른 서버의 Port도 Down 시킬 것인지 확인한다.
						if(confirm("Port Number " + pnum + "이 다른 " + serverType + "서버에서도 Running 중이라면 다른 " + serverType + "서버의 Port도 Down 시키시겠습니까?")) {
						} else {
							// 다른 서버의 Port는 Down 시키지 않는다.
							frm.remoteInvoke.value = 'skip';
						}
					}
					*/
					
					frm.todo.value = 'running';
					frm.runvalue.value = 'Yes';
					frm.submit();
				} else if (todo == 'runningNo') {
					frm.todo.value = 'running';
					frm.runvalue.value = 'No';
					frm.submit();
				} else if (todo == 'notAvailable') {
					alert("한 쪽 서버에서만 Running 하는 Port 입니다.\n다른 운영서버에서 Running 중이므로 현재 서버에서는 Running 할 수 없습니다.");
					return;
				} else if (todo == 'runAll' || todo == 'downAll') {
					var openClose = "";
					
					if (todo == 'runAll') {
						openClose = "open";
					} else {
						openClose = "close";
					}
					
					/*
					// 다른 서버의 Port를 Down 시키지 않을 경우 Online Client 연결 갯수 동기화 등의 문제가 생기므로 아래 기능은 사용하지 않는다.
					if (openClose == "close") {
						if (serverDuplexing == "true") {
							// Clustering을 구성하는 서버가 두 대 이상인 경우 ==> 다른 서버의 Port도 Down 시킬 것인지 확인한다.
							if(confirm("다른 " + serverType + "서버에서도 Running 중인 Port가 있는 경우 다른 " + serverType + "서버의 Port도 Down 시키시겠습니까?")) {
							} else {
								// 다른 서버의 Port는 Down 시키지 않는다.
								frm.remoteInvoke.value = 'skip';
							}
						}
					}
					*/
					
					for (var i=0; i < frm.length; i++) {
						if (frm.elements[i].checked) {
							if (frm.selectedList.value == "") {
								frm.selectedList.value = frm.elements[i].value;
							} else {
								frm.selectedList.value = frm.selectedList.value + "/" + frm.elements[i].value;
							}
						}
					}
					
					if (frm.selectedList.value == "") {
						if(confirm("Do you really want to " + openClose + " below all online local server sockets?")) {
							for (var i=0; i < frm.length; i++) {
								var eleName = frm.elements[i].name;
								var nameIndex = eleName.indexOf("selectedList");
								
								if (nameIndex >= 0) {
									if (frm.selectedList.value == "") {
										frm.selectedList.value = frm.elements[i].value;
									} else {
										frm.selectedList.value = frm.selectedList.value + "/" + frm.elements[i].value;
									}
								}
							}
							
							frm.submit();
						}
					} else {
						frm.submit();
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
			
			function alertMsg() {
				var frm = document.pform;
				var msg = frm.alertMsg.value;
				var alertMsgCount = "%value alertMsgCount%";
				
				if (alertMsgCount.length >= 2) {
					window.open('/JSocketAdapter/socket-alertmsg.dsp?alertMsg=' + msg, '', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
					frm.alertMsg.value = ""; // 다른 화면으로 이동 시 영향을 주기 때문에 alertMsg 를 공백처리 한다.
				} else {
					if (msg != "") {
						alert(msg);
						frm.alertMsg.value = ""; // 다른 화면으로 이동 시 영향을 주기 때문에 alertMsg 를 공백처리 한다.
					}
				}
			}
			
			var seq = 1;
		</script>
	</head>
	<body onload="javascript:alertMsg()">
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					Online Server &gt;
					Online Server List
				</td>
			</tr>
		</table>
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="portNumber" value="">
		<input type="hidden" name="runvalue" value="">
		<input type="hidden" name="checkMode" value="uncheck">
		<input type="hidden" name="selectedList" value="">
		<input type="hidden" name="portStatusCheck" value="false">
		<input type="hidden" name="onlineList" value="true">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Search Properties</td>
			</tr>
			
			<!-- 현대제철 냉연공장 전용 -->
			%ifvar customerCode equals('HCC')%
			<tr>
				<td class="evenrow" width="30%">Plant</td>
				<td class="evenrow-l" width="70%">
					<select name="searchPlantCode" style="width:300">
						<option value="">ALL</option>
						%loop PlantCodeDescList%
							<option value="%value codeValue%">%value codeDisplay%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.searchPlantCode.value = "%value searchPlantCode%";
					</script>
				</td>
			</tr>
			%endifvar%
			<!-- 현대제철 냉연공장 전용 -->
			
			<tr>
				<td class="evenrow" width="30%">Source System Name</td>
				<td class="evenrow-l" width="70%">
					<select name="searchSystemName" style="width:300">
						<option value="">ALL</option>
						%loop SystemNameDescList%
							<option value="%value systemNameValue%">%value systemNameDisplay%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.searchSystemName.value = "%value searchSystemName%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Port Number</td>
				<td class="evenrow-l" width="70%">
					<select name="searchPortNumber" style="width:300">
						<option value="">ALL</option>
						%loop PortNumberList%
							<option value="%value portNumberValue%">%value portNumberDisplay%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.searchPortNumber.value = "%value searchPortNumber%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Port Open Status</td>
				<td class="evenrow-l" width="70%">
					<select name="searchEnabled" style="width:300">
						<option value="">ALL</option>
						<option value="true">Opened</option>
						<option value="false">Closed</option>
					</select>
					<script language="javascript">
						document.pform.searchEnabled.value = "%value searchEnabled%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="action" colspan="2">
					<input type="button" name="SUBMIT" value="Search"  onclick="return doAction('search', '')"></input>
				</td>
			</tr>
		</table>

		<table class="tableForm" width="100%">	
			<tr>
				<td class="action" colspan=10>
					<input type="button" name="SUBMIT" value="Port Enable"  onclick="return doAction('runAll', '')"></input>&nbsp;&nbsp;
					<input type="button" name="SUBMIT" value="Port Disable"  onclick="return doAction('downAll', '')"></input>&nbsp;&nbsp;
				</td>
			</tr>
			<tr>
				<td class="heading" colspan="10">Online Server Socket Information</td>
			</tr>
			<tr class="subheading2">
				<td>Select <a href="javascript:allChecked()">All</a></td>
				<td>Seq</td>
				<td>Enabled</td>
				<td>Listening</td>
				<!-- 현대제철 냉연공장 전용 -->
				%ifvar customerCode equals('HCC')%
				<td>Plant</td>
				%endifvar%
				<!-- 현대제철 냉연공장 전용 -->
				<td>Source System Name</td>
				<td>Port Number</td>
				<td>Description</td>
				<td>Connected Session Count</td>
				<td>Listener Service</td>				
			</tr>
			%ifvar ServerPortConfig/Ports -notempty%
				%loop ServerPortConfig/Ports -$index%
					<tr>
						<td class="evenrowdata"><input type="checkbox" name="selectedList%value $index%" value="%value portNumber%">
						<td class="evenrowdata">
							<script language="javascript">
								document.write(seq);
								seq++;
							</script>
						</td>
						<td class="evenrowdata">
							%ifvar enabled equals('true')%
								<img src="%value ../../designPath%images/enable_icon_16.png" alt="enabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('runningYes', '%value portNumber%')">Yes</a>
							%else%
								%ifvar portDuplexing equals('No')%
									%ifvar updateAvailable equals('true')%
										<img src="%value ../../designPath%images/disable_icon_16.png" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('runningNo', '%value portNumber%')">No</a>
									%else%
										<img src="%value ../../designPath%images/disable_icon_16.png" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('notAvailable', '%value portNumber%')">No</a>
									%endifvar%
								%else%
									<img src="%value ../../designPath%images/disable_icon_16.png" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('runningNo', '%value portNumber%')">No</a>
								%endifvar%
							%endifvar%
						</td>
						<td>%value listening%</td>
						<!-- 현대제철 냉연공장 전용 -->
						%ifvar ../../customerCode equals('HCC')%
						<td class="evenrowdata">%value plantCode%</td>
						%endifvar%
						<!-- 현대제철 냉연공장 전용 -->
						<td class="evenrowdata">%value srcSystemName%</td>
						<td class="evenrowdata"><a href="javascript:doAction('read', '%value portNumber%')">%value portNumber%
							%ifvar outPortNumber -notempty%
								(%value outPortNumber%)
							%endifvar%
							</a>
						</td>
						<td>%value description%</td>
						<td class="evenrowdata">%value connectCount%</td>
						<td>%value servicePath%</td>								
					</tr>
				%endloop%
			%else%
				<tr><td colspan="10">No online local server ports are currently registered.</td></tr>
			%endifvar%
		</table>
		</form>
	</body>
</html>

%endinvoke%