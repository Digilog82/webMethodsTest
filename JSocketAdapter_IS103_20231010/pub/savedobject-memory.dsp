%invoke JSocketAdapter.ADMIN:adminSavedISMemory%

<html>
	<head>
  	<meta content="no-cache" http-equiv="Pragma">
  	<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  	<meta content="-1" http-equiv="Expires">
  	<title>Server &gt; Statistics</title>
  	<link href="%value designPath%webMethods.css" type="text/css" rel="stylesheet">
  	<script src="%value designPath%webMethods.js.txt"></script>
  	
  	<script language="javascript">
				function doAction(todo, sname, location){
					var frm = document.pform;
					frm.todo.value = todo;
					frm.savedName.value = sname;
					frm.location.value = location;
						
					if(todo == 'delete'){
						if(confirm("Do you really want to delete data of  " + sname)){
							frm.submit();
						}
					} else {
						frm.submit();
					}
				}
				
				function doDeleteItems(objName) {
					var eleName;
					
					for (var i=0; i < document.pform.length; i++) {
						if (document.pform.elements[i].checked) {
							eleName = document.pform.elements[i].name;
							
							if (eleName.indexOf("checkedListM") >= 0) {
								if (document.pform.deleteSavedNameListM.value == "") {
									document.pform.deleteSavedNameListM.value = document.pform.elements[i].value;
								} else {
									document.pform.deleteSavedNameListM.value = document.pform.deleteSavedNameListM.value + "|" + document.pform.elements[i].value;
								}
							} else if (eleName.indexOf("checkedListF") >= 0) {
								if (document.pform.deleteSavedNameListF.value == "") {
									document.pform.deleteSavedNameListF.value = document.pform.elements[i].value;
								} else {
									document.pform.deleteSavedNameListF.value = document.pform.deleteSavedNameListF.value + "|" + document.pform.elements[i].value;
								}
							}
						}
					}
					
					if (document.pform.deleteSavedNameListM.value == "" && document.pform.deleteSavedNameListF.value == "") {
						alert("삭제할 " + objName + "를(을) 선택하십시요.");
						return;
					} else {
						if(confirm("Do you really want to delete selected items?")) {
							document.pform.todo.value = "deleteItems";
							document.pform.submit();
						} else {
							document.pform.deleteSavedNameListM.value = "";
							document.pform.deleteSavedNameListF.value = "";
							return;
						}
					}
				}
				
				function shutdownListenerService(todo, portNumber, sessionName) {
					if(confirm("Listener Service를 종료하면 해당 세션에 대한 Client 연결도 끊어집니다. 계속 진행하시겠습니까?")){
					} else {
						return;
					}
					
					var frm = document.pform;
					frm.todo.value = todo;
					frm.portNumber.value = portNumber;
					frm.sessionName.value = sessionName;
					frm.submit();
				}
				
				function alertMsg() {
					var frm = document.pform;
					var msg = frm.alertMsg.value;
				
					if (msg != "") {
						alert(msg);
						frm.alertMsg.value = ""; // 다른 화면으로 이동 시 영향을 주기 때문에 alertMsg 를 공백처리 한다.
					}
				}
				
				function allCheckedM() {
					var checkMode = document.pform.checkModeM.value;
					var eleName;
					
					if (checkMode == "uncheck") { // All Checked
						for (var i=0; i < document.pform.length; i++) {
							eleName = document.pform.elements[i].name;
							
							if (eleName.indexOf("checkedListM") >= 0) {
								if (!document.pform.elements[i].checked) {
									document.pform.elements[i].checked = true;
								}
							}
						}
						
						document.pform.checkModeM.value = "check";
					} else { // All Unchecked
						for (var i=0; i < document.pform.length; i++) {
							eleName = document.pform.elements[i].name;
							
							if (eleName.indexOf("checkedListM") >= 0) {
								if (document.pform.elements[i].checked) {
									document.pform.elements[i].checked = false;
								}
							}
						}
						
						document.pform.checkModeM.value = "uncheck";
					}
				}
				
				function allCheckedF() {
					var checkMode = document.pform.checkModeF.value;
					var eleName;
					
					if (checkMode == "uncheck") { // All Checked
						for (var i=0; i < document.pform.length; i++) {
							eleName = document.pform.elements[i].name;
							
							if (eleName.indexOf("checkedListF") >= 0) {
								if (!document.pform.elements[i].checked) {
									document.pform.elements[i].checked = true;
								}
							}
						}
						
						document.pform.checkModeF.value = "check";
					} else { // All Unchecked
						for (var i=0; i < document.pform.length; i++) {
							eleName = document.pform.elements[i].name;
							
							if (eleName.indexOf("checkedListF") >= 0) {
								if (document.pform.elements[i].checked) {
									document.pform.elements[i].checked = false;
								}
							}
						}
						
						document.pform.checkModeF.value = "uncheck";
					}
				}
				
				var seq = 1;
		</script>
	</head>

 	<body onload="javascript:alertMsg()">
 
 	%invoke JSocketAdapter.ADMIN:adminSavedFileSystem%
 
 		%ifvar changed equals('true')%
			<form name="dform" method="post">
				<input type="hidden" name="savedObject" value="%value savedObject%">
				<input type="hidden" name="objectName" value="%value objectName%">
				<input type="hidden" name="alertMsg" value="%value alertMsg%">
			</form>
			<script langauge='javascript'>
				document.dform.submit();
			</script>
 		%endifvar%
 
 		<form name="pform" method="post" target="_self">
 			<input type="hidden" name="todo" value="">
			<input type="hidden" name="savedName" value="">
			<input type="hidden" name="location" value="">
			<input type="hidden" name="portNumber" value="">
			<input type="hidden" name="sessionName" value="">
			<input type="hidden" name="savedObject" value="%value savedObject%">
			<input type="hidden" name="objectName" value="%value objectName%">
			<input type="hidden" name="checkModeM" value="uncheck">
			<input type="hidden" name="checkModeF" value="uncheck">
			<input type="hidden" name="deleteSavedNameListM" value="">
			<input type="hidden" name="deleteSavedNameListF" value="">
			<input type="hidden" name="alertMsg" value="%value alertMsg%">

		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					%switch savedObject%
					%case 'onlineClientListenerList'%
						Online Client &gt;
					%case 'onlineHealthCheckList'%
						Online Client &gt;
					%case 'onlineServerListenerList'%
						Online Server &gt;
					%case%
					IS Memory Object &gt;
					%endswitch%
					%value objectName%
				</td>
			</tr>
		</table>
		
		%ifvar savedObject equals('onlineRequestHeaderList')%
			<table class="tableForm" width="100%">
				<tr>
					<td class="action">
						<input type="button" name="DELETE" value="Delete Items"  onclick="return doDeleteItems('%value objectName%')"></input>
					</td>
				</tr>
			</table>
		%endifvar%
		
		%ifvar savedObject equals('onlineResponseDataList')%
			<table class="tableForm" width="100%">
				<tr>
					<td class="action">
						<input type="button" name="DELETE" value="Delete Items"  onclick="return doDeleteItems('%value objectName%')"></input>
					</td>
				</tr>
			</table>
		%endifvar%
		
		%ifvar savedObject equals('onlineSendStatusList')%
			<table class="tableForm" width="100%">
				<tr>
					<td class="action">
						<input type="button" name="DELETE" value="Delete Items"  onclick="return doDeleteItems('%value objectName%')"></input>
					</td>
				</tr>
			</table>
		%endifvar%
		
		%ifvar savedObject equals('onlineReconnectingServerList')%
			<table class="tableForm" width="100%">
				<tr>
					<td class="action">
						<input type="button" name="DELETE" value="Delete Items"  onclick="return doDeleteItems('%value objectName%')"></input>
					</td>
				</tr>
			</table>
		%endifvar%
		
		%ifvar savedObject equals('onlineReceiveSequenceList')%
			<table class="tableForm" width="100%">
				<tr>
					<td class="action">
						<input type="button" name="DELETE" value="Delete Items"  onclick="return doDeleteItems('%value objectName%')"></input>
					</td>
				</tr>
			</table>
		%endifvar%
		
		%ifvar savedObject equals('onlineSequenceCreationList')%
			<table class="tableForm" width="100%">
				<tr>
					<td class="action">
						<input type="button" name="DELETE" value="Delete Items"  onclick="return doDeleteItems('%value objectName%')"></input>
					</td>
				</tr>
			</table>
		%endifvar%
		
		%ifvar savedObject equals('realtimeRequestHeaderList')%
			<table class="tableForm" width="100%">
				<tr>
					<td class="action">
						<input type="button" name="DELETE" value="Delete Items"  onclick="return doDeleteItems('%value objectName%')"></input>
					</td>
				</tr>
			</table>
		%endifvar%

		%switch savedObject%
			%case 'socketRunningServerList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="4">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
					<tr class="subheading2">
						<td>Seq</td>						
						<td>Port Number</td>
						<td>Service Path</td>
						<td>Server Socket</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td class="evenrowdata">
									<script language="javascript">
										document.write(seq);
										seq++;
									</script>
								</td>
								<td>%value portNumber %</td>
								<td>%value servicePath %</td>
								<td>%value ssocket %</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=4>No running local server sockets are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'socketServerList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="9">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
					<tr class="subheading2">
						<td>Seq</td>
						<td>Opened</td>
						<td>Port</td>
						<td>Description</td>
						<td>Execute Service</td>
						<td>Asynch Online YN</td>
						<td>Read Timeout</td>						
						<td>Thread Pool Usage</td>
						<td>Max Pool Size</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td class="evenrowdata">
									<script language="javascript">
										document.write(seq);
										seq++;
									</script>
								</td>
								<td class="evenrowdata">
									%ifvar enabled equals('true')%
										<img src="%value ../designPath%images/enable_icon_16.png" alt="enabled" border="0">&nbsp;&nbsp;&nbsp;Yes
									%else%
										<img src="%value ../designPath%images/disable_icon_16.png" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;No
									%endifvar%
								</td>
								<td class="evenrowdata">%value portNumber%
									%ifvar outPortNumber -notempty%
										(%value outPortNumber%)
									%endifvar%
								</td>
								<td>%value description%</td>
								<td>%value servicePath%</td>
								<td class="evenrowdata">%value online%</td>
								<td class="evenrowdata">%value readTimeout%</td>
								<td class="evenrowdata">
									%ifvar threadPool equals('true')%
										Yes
									%else%
										No
									%endifvar%
								</td>
								<td class="evenrowdata">%value poolSize%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=9>No local server sockets are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'socketClientList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="10">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
					<tr class="subheading2">
						<td>Seq</td>
						<td>Enabled</td>
						<td>Target System Name</td>
						<td>Socket Name</td>
						<td>Description</td>
						<td>IP</td>
						<td>Port</td>
						<td>Read Timeout</td>
						<td>Asynch Online YN</td>
						<td>Listener Service</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td class="evenrowdata">
									<script language="javascript">
										document.write(seq);
										seq++;
									</script>
								</td>
								<td class="evenrowdata">
									%ifvar enabled equals('enabled')%
										<img src="%value ../designPath%images/enabled.gif" alt="enabled" border="0">&nbsp;&nbsp;&nbsp;Yes
									%else%
										<img src="%value ../designPath%images/close.gif" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;No
									%endifvar%
								</td>
								<td>%value systemName%</td>
								<td>%value name%</td>
								<td>%value description%</td>
								<td>%value ip%</td>
								<td class="evenrowdata">%value port%</td>
								<td class="evenrowdata">%value readTimeout%</td>
								<td class="evenrowdata">%value online%</td>
								<td>%value servicePath%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=10>No remote server sockets are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'customVariableList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="3">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
					<tr class="subheading2">
						<td>Variable Name</td>
						<td>Variable Value</td>
						<td>Description</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td>%value variableName%</td>
								<td>%value variableValue%</td>
								<td>%value description%</td>							
							</tr>
						%endloop%
					%else%
						<tr><td colspan=3>No custom variables are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'businessNameList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="6">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Enabled</td>
						<td>Business Name</td>
						<td>Provider System Code</td>
						<td>Receive DataQ Name</td>
						<td>Receive DataQ KeyLength</td>
						<td>Description</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td class="evenrowdata">
									%ifvar enabled equals('enabled')%
										<img src="%value ../designPath%images/enabled.gif" alt="enabled" border="0">&nbsp;&nbsp;&nbsp;Yes
									%else%
										<img src="%value ../designPath%images/close.gif" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;No
									%endifvar%
								</td>
								<td>%value name%</td>
								<td>%value systemCode%</td>
								<td>%value qName%</td>
								<td>%value keyLength%</td>
								<td>%value description%</td>							
							</tr>
						%endloop%
					%else%
						<tr><td colspan=6>No business names are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'businessInterfaceList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="8">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Seq</td>
						<td>Business Name</td>
						<td>System Name</td>
						<td>Doc Name</td>
						<td>Doc Class Code (전문종별코드)</td>
						<td>Doc Business Code (전문업무구분코드)</td>
						<td>Interface ID</td>																		
						<td>Description</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td class="evenrowdata">
									<script language="javascript">
										document.write(seq);
										seq++;
									</script>
								</td>
								<td>%value businessName%</td>
								<td>%value systemName%</td>
								<td>%value docName%</td>
								<td>%value classCode%</td>
								<td>%value businessCode%</td>
								<td>%value interfaceID%</td>																
								<td>%value description%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=8>No business docs are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'docInterfaceIDList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="6">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Seq</td>
						<td>Doc Name</td>
						<td>Doc Class Code (전문종별코드)</td>
						<td>Doc Business Code (전문업무구분코드)</td>
						<td>Interface ID</td>
						<td>Description</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td class="evenrowdata">
									<script language="javascript">
										document.write(seq);
										seq++;
									</script>
								</td>
								<td>%value docName%</td>
								<td>%value classCode%</td>
								<td>%value businessCode%</td>
								<td>%value interfaceID%</td>
								<td>%value description%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=6>No local server socket docs are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'docSchemaDefList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="6">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Seq</td>
						<td>Doc Name</td>
						<td>Doc Class Code (전문종별코드)</td>
						<td>Doc Business Code (전문업무구분코드)</td>
						<td>Interface ID</td>
						<td>Description</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td class="evenrowdata">
									<script language="javascript">
										document.write(seq);
										seq++;
									</script>
								</td>
								<td>%value docName%</td>
								<td>%value classCode%</td>
								<td>%value businessCode%</td>
								<td>%value interfaceID%</td>
								<td>%value description%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=6>No server doc schema defines are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'businessDocSchemaDefList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="6">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Seq</td>
						<td>Doc Name</td>
						<td>Doc Class Code (전문종별코드)</td>
						<td>Doc Business Code (전문업무구분코드)</td>
						<td>Interface ID</td>
						<td>Description</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td class="evenrowdata">
									<script language="javascript">
										document.write(seq);
										seq++;
									</script>
								</td>
								<td>%value docName%</td>
								<td>%value classCode%</td>
								<td>%value businessCode%</td>
								<td>%value interfaceID%</td>
								<td>%value description%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=6>No client doc schema defines are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'restApiProtocol'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="4">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Name</td>
						<td>API System Name</td>
						<td>API Business Name</td>
						<td>Description</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td>%value restName%</td>
								<td>%value systemName%</td>
								<td>%value businessName%</td>
								<td>%value description%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=4>No rest api protocols are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'onlineSocketClientList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="3">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Online Client Socket Name</td>
						<td>Client Socket</td>
						<td>Connect Time</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td>%value NAME%</td>
								<td>%value socket%</td>
								<td>%value connectTime%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=3>No online socket clients are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'onlineConnectCountList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="2">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Online Connect Name</td>
						<td>Connected Count</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td>%value connectName%</td>
								<td>%value connectCount%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=2>No online connected counts are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'onlineRequestHeaderList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="5">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Select <a href="javascript:allCheckedM()">All</a></td>
						<td>Saved Name</td>
						<td>ESB Transaction ID</td>
						<td>Receive Data Q Key Value</td>
						<td>Delete</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList -$index%
							<tr>
								<td class="evenrowdata"><input type="checkbox" name="checkedListM%value $index%" value="%value savedName%">
								<td>%value savedName%</td>
								<td>%value ESBHeader/transactionID%</td>
								<td>%value keyValue%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value savedName%', 'memory')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=5>No online request headers are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'onlineSendStatusList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="6">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Select <a href="javascript:allCheckedM()">All</a></td>
						<td>Saved Name</td>
						<td>Socket Name</td>
						<td>Result Code</td>
						<td>Result Msg</td>
						<td>Delete</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList -$index%
							<tr>
								<td class="evenrowdata"><input type="checkbox" name="checkedListM%value $index%" value="%value savedName%">
								<td>%value savedName%</td>
								<td>%value NAME%</td>
								<td>%value resultCode%</td>
								<td>%value resultMsg%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value savedName%', 'memory')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=6>No online send statuses are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'onlineResponseDataList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="5">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Select <a href="javascript:allCheckedM()">All</a></td>
						<td>Saved Name</td>
						<td>Receive End</td>
						<td>Record Count</td>
						<td>Delete</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList -$index%
							<tr>
								<td class="evenrowdata"><input type="checkbox" name="checkedListM%value $index%" value="%value savedName%">
								<td>%value savedName%</td>
								<td>%value receiveEnd%</td>
								<td>%value recCount%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value savedName%', 'memory')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=5>No online response datum are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'onlineRunningServerList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="5">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Socket Name</td>
						<td>Description</td>
						<td>Server Type</td>
						<td>Running Server IP</td>
						<td>Connect Time</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td>%value socketName%</td>
								<td>%value description%</td>
								<td>%value serverType%</td>
								<td>%value serverIP%</td>
								<td>%value connectTime%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=5>No running online running servers are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'onlineReconnectingServerList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="5">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Select <a href="javascript:allCheckedM()">All</a></td>
						<td>Saved Name</td>
						<td>송신용 Socket Name</td>
						<td>수신용 Socket Name</td>
						<td>Delete</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList -$index%
							<tr>
								<td class="evenrowdata"><input type="checkbox" name="checkedListM%value $index%" value="%value savedName%">
								<td>%value savedName%</td>
								<td>%value outSocketName%</td>
								<td>%value inSocketName%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value savedName%', 'memory')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=5>No online reconnecting servers are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'onlineReceiveSequenceList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="5">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Select <a href="javascript:allCheckedM()">All</a></td>
						<td>Interface ID</td>
						<td>Saved ESB Header Name</td>
						<td>Receive Sequence</td>
						<td>Delete</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList -$index%
							<tr>
								<td class="evenrowdata"><input type="checkbox" name="checkedListM%value $index%" value="%value headerName%_%value rcvSeq%">
								<td>%value interfaceID%</td>
								<td>%value headerName%</td>
								<td>%value rcvSeq%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value headerName%_%value rcvSeq%', 'memory')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=5>No online receive sequences are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'onlineQueuingList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="4">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
				        <td>Queue Name</td>
						<td>Queuing Socket Name (or Port)</td>
						<td>Clear Service</td>
						<td>Current Offered Queue Size</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td>%value queueName%</td>
								<td>%value socketName%</td>
								<td>%value queuingService%</td>
								<td>%value queueSize%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=4>No online queuing daemons are currently running.</td></tr>
					%endifvar%
				</table>
			%case 'onlineSocketQueueList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="2">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Queue Name</td>
						<td>Current Offered Queue Size</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td>%value qName%</td>
								<td>%value qCount%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=2>No online queues are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'serialSocketQueueList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="3">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Queue Name</td>
						<td>Clear Service</td>
						<td>Current Offered Queue Size</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td>%value qName%</td>
								<td>JSocketAdapter.COMMON.UTIL.FLOW:sendDataFromSerialQueue</td>
								<td>%value qCount%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=3>No serial queues are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'socketLogQueueList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="3">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Queue Name</td>
						<td>Clear Service</td>
						<td>Current Offered Queue Size</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td>%value qName%</td>
								<td>JSocketAdapter.COMMON.UTIL.FLOW:saveDataFromSocketLogQueue</td>
								<td>%value qCount%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=3>No socket log queues are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'realtimeRequestHeaderList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="5">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Select <a href="javascript:allCheckedM()">All</a></td>
						<td>Saved Name(Transaction ID)</td>
						<td>Port Number</td>
						<td>Saved Time</td>
						<td>Delete</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList -$index%
							<tr>
								<td class="evenrowdata"><input type="checkbox" name="checkedListM%value $index%" value="%value savedName%">
								<td>%value savedName%</td>
								<td>%value portNumber%</td>
								<td>%value savedTime%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value savedName%', 'memory')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=5>No request socket objects are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'onlineServerListenerList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="5">%value objectName%
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Seq</td>
						<td>Session Name</td>
						<td>Port Number</td>
						<td>Listener Service</td>
						<td>Shutdown</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td class="evenrowdata">
									<script language="javascript">
										document.write(seq);
										seq++;
									</script>
								</td>
								<td>%value sessionName%</td>
								<td>%value portNumber%</td>
								<td>%value listenerService%</td>
								<td class="evenrowdata">
									<a href="javascript:shutdownListenerService('lsshutdown', '%value portNumber%', '%value sessionName%')"><img src="%value ../../designPath%icons/delete.png" alt="Shutdown" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=5>No online server listeners are currently running.</td></tr>
					%endifvar%
				</table>
			%case 'onlineClientListenerList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="3">%value objectName%
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Session Name</td>
						<td>Socket Name</td>
						<td>Listener Service</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td>%value sessionName%</td>
								<td>%value socketName%</td>
								<td>%value listenerService%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=3>No online client listeners are currently running.</td></tr>
					%endifvar%
				</table>
			%case 'onlineHealthCheckList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="3">%value objectName%
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Socket Name</td>
						<td>Health Check Service</td>
						<td>Service Start Time</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td>%value socketName%</td>
								<td>%value healthCheckService%</td>
								<td>%value serviceStartTime%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=3>No online health check services are currently running.</td></tr>
					%endifvar%
				</table>
			%case 'threadIDInfoList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="3">%value objectName%
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Service Name</td>
						<td>Thread Start Time</td>
						<td>Thread ID</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList%
							<tr>
								<td>%value serviceName%</td>
								<td>%value threadStartTime%</td>
								<td>%value threadID%</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=3>No service thread ids are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'onlineSequenceCreationList'%
				<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="5">Saved Object on IS Memory (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Select <a href="javascript:allCheckedM()">All</a></td>
						<td>Interface ID</td>
						<td>Saved ESB Header Name</td>
						<td>Created Sequence</td>
						<td>Delete</td>
					</tr>					
					%ifvar -notempty SavedList%
						%loop SavedList -$index%
							<tr>
								<td class="evenrowdata"><input type="checkbox" name="checkedListM%value $index%" value="%value headerName%">
								<td>%value interfaceID%</td>
								<td>%value headerName%</td>
								<td>%value rcvSeq%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value headerName%', 'memory')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=5>No online sequence creations are currently registered.</td></tr>
					%endifvar%
				</table>
		%endswitch%
		
    %switch savedObject%
			%case 'realtimeRequestHeaderList'%
				<table><tr><td>&nbsp;</td></tr></table>
      	<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="5">Saved Object on File System (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Select <a href="javascript:allCheckedF()">All</a></td>
						<td>Saved Name(Transaction ID)</td>
						<td>Port Number</td>
						<td>Saved Time</td>
						<td>Delete</td>
					</tr>					
					%ifvar -notempty SavedFileList%
						%loop SavedFileList -$index%
							<tr>
								<td class="evenrowdata"><input type="checkbox" name="checkedListF%value $index%" value="%value savedName%">
								<td>%value savedName%</td>
								<td>%value portNumber%</td>
								<td>%value savedTime%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value savedName%', 'file')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=5>No request socket objects are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'onlineRequestHeaderList'%
				<table><tr><td>&nbsp;</td></tr></table>
      	<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="5">Saved Object on File System (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Select <a href="javascript:allCheckedF()">All</a></td>
						<td>Saved Name</td>
						<td>ESB Transaction ID</td>
						<td>Receive Data Q Key Value</td>
						<td>Delete</td>
					</tr>					
					%ifvar -notempty SavedFileList%
						%loop SavedFileList -$index%
							<tr>
								<td class="evenrowdata"><input type="checkbox" name="checkedListF%value $index%" value="%value savedName%">
								<td>%value savedName%</td>
								<td>%value ESBHeader/transactionID%</td>
								<td>%value keyValue%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value savedName%', 'file')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=5>No online request headers are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'onlineResponseDataList'%
    		<table><tr><td>&nbsp;</td></tr></table>
      	<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="5">Saved Object on File System (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Select <a href="javascript:allCheckedF()">All</a></td>
						<td>Saved Name</td>
						<td>Receive End</td>
						<td>Record Count</td>
						<td>Delete</td>
					</tr>					
					%ifvar -notempty SavedFileList%
						%loop SavedFileList -$index%
							<tr>
								<td class="evenrowdata"><input type="checkbox" name="checkedListF%value $index%" value="%value savedName%">
								<td>%value savedName%</td>
								<td>%value receiveEnd%</td>
								<td>%value recCount%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value savedName%', 'file')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=5>No online response datum are currently registered.</td></tr>
					%endifvar%
				</table>
			%case 'onlineSendStatusList'%
     		<table><tr><td>&nbsp;</td></tr></table>
      	<table width="100%" class="tableForm">
  	 			<tr>
  	 				<td class="heading" colspan="6">Saved Object on File System (%value objectName%)
  	 				</td>
  	 			</tr>
  	 			<tr class="subheading2">
						<td>Select <a href="javascript:allCheckedF()">All</a></td>
						<td>Saved Name</td>
						<td>Socket Name</td>
						<td>Result Code</td>
						<td>Result Msg</td>
						<td>Delete</td>
					</tr>					
					%ifvar -notempty SavedFileList%
						%loop SavedFileList -$index%
							<tr>
								<td class="evenrowdata"><input type="checkbox" name="checkedListF%value $index%" value="%value savedName%">
								<td>%value savedName%</td>
								<td>%value NAME%</td>
								<td>%value resultCode%</td>
								<td>%value resultMsg%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value savedName%', 'file')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=6>No online send statuses are currently registered.</td></tr>
					%endifvar%
				</table>
    %endswitch%
    
		</form>
	</body>
</html>

%endinvoke%