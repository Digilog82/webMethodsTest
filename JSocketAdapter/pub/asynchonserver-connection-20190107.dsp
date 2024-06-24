%invoke JSocketAdapter.ADMIN:adminOnlineLocalServer%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo){
				var frm = document.pform;
				
				if (todo == 'runningYes') {
					frm.todo.value = 'running';
					frm.runvalue.value = 'Yes';
				} else if (todo == 'runningNo') {
					frm.todo.value = 'running';
					frm.runvalue.value = 'No';
				}
				
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
		</script>
	</head>
	<body onload="javascript:alertMsg()">
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">
			<input type="hidden" name="todo" value="">
			<input type="hidden" name="runvalue" value="">
			<input type="hidden" name="portNumber" value="%value portNumber%">
			<input type="hidden" name="remoteInvoke" value="true">
			<input type="hidden" name="alertMsg" value="%value alertMsg%">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Online Server &gt;
						Port %value portNumber%
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">%value inTitle%</td>
			</tr>
			<tr>
				<tr>
					<td class="evenrow" width="30%">Opened</td>
					<td class="evenrow-l" width="70%">
						%ifvar ServerPortInfo/enabled equals('true')%
							<img src="%value designPath%images/enable_icon_16.png" alt="enabled" border="0">&nbsp;&nbsp;&nbsp;Yes
						%else%
							<img src="%value designPath%images/disable_icon_16.png" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;No
						%endifvar%
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Port Number</td>
					<td class="evenrow-l" width="70%">
						%value ServerPortInfo/portNumber%
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Description</td>
					<td class="evenrow-l" width="70%">
						%value ServerPortInfo/description%
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Listener Service</td>
					<td class="evenrow-l" width="70%">
						%value ServerPortInfo/servicePath%
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Allowed Session Count</td>
					<td class="evenrow-l" width="70%">
						%value ServerPortInfo/allowedSessionCount%
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Connected Session Count</td>
					<td class="evenrow-l" width="70%">
						%value inSocketCount%
					</td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						%ifvar ServerPortInfo/enabled equals('true')%
							<input type="button" name="SUBMIT" value="Server Down"  onclick="return doAction('runningYes')"></input>
						%else%
							<input type="button" name="SUBMIT" value="Server Run"  onclick="return doAction('runningNo')"></input>
						%endifvar%
					</td>
				</tr>
			</tr>			
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="3">Connected Socket Client Information</td>
			</tr>
			<tr class="subheading2">
				<td>Session Name</td>
				<td>Connected Server</td>
				<td>Client IP</td>
			</tr>
			%ifvar inSocketList -notempty%
				%loop inSocketList%
					<tr>
						<td>%value sessionName%</td>
						<td>%value connectedServer%</td>
						<td>%value clientIP%</td>
					</tr>
				%endloop%
			%else%
					<tr><td colspan="3">No online socket clients are currently connected.</td></tr>
			%endifvar%
		</table>
		
		%ifvar OutServerPortInfo -notempty%
			<table>
				<tr><td>&nbsp;</td></tr>
				<tr><td>&nbsp;</td></tr>
			</table>
			
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">%value outTitle%</td>
				</tr>
				<tr>
					<tr>
						<td class="evenrow" width="30%">Opened</td>
						<td class="evenrow-l" width="70%">
							%ifvar OutServerPortInfo/enabled equals('true')%
								<img src="%value designPath%images/enable_icon_16.png" alt="enabled" border="0">&nbsp;&nbsp;&nbsp;Yes
							%else%
								<img src="%value designPath%images/disable_icon_16.png" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;No
							%endifvar%
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Port Number</td>
						<td class="evenrow-l" width="70%">
							%value OutServerPortInfo/outPortNumber%
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Description</td>
						<td class="evenrow-l" width="70%">
							%value OutServerPortInfo/description%
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Allowed Session Count</td>
						<td class="evenrow-l" width="70%">
							%value OutServerPortInfo/allowedSessionCount%
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Connected Session Count</td>
						<td class="evenrow-l" width="70%">
							%value outSocketCount%
						</td>
					</tr>
				</tr>			
			</table>
			
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="3">Connected Socket Client Information</td>
				</tr>
				<tr class="subheading2">
					<td>Session Name</td>
					<td>Connected Server</td>
					<td>Client IP</td>
				</tr>
				%ifvar outSocketList -notempty%
					%loop outSocketList%
						<tr>
							<td>%value sessionName%</td>
							<td>%value connectedServer%</td>
							<td>%value clientIP%</td>
						</tr>
					%endloop%
				%else%
						<tr><td colspan="3">No online socket clients are currently connected.</td></tr>
				%endifvar%
			</table>
		%endifvar%
		
		</form>		
	</body>
</html>

%endinvoke%