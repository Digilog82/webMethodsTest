%invoke JSocketAdapter.ADMIN:adminLocalServerConnectionLog%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(){
				var frm = document.pform;
				var logDate = frm.logDate.value;
				var portNumber = frm.portNumber.value;
					
				if (logDate == "") {
					alert("Log Date를 입력하십시요.");
					return;
				}
					
				if (portNumber == "") {
					alert("Port Number를 선택하십시요.");
					return;
				}
					
				frm.submit();
			}
		</script>
	</head>
	<body>
	
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Socket Log &gt;
						Local Server Connection Log
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
					<input type="text" name="fromTime" value="%value fromTime%" style="font-size:10pt;width:100"> ~ <input type="text" name="toTime" value="%value toTime%" style="font-size:10pt;width:100"> (Time Format : HHmmssSSS)
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Port Number</td>
				<td class="evenrow-l" width="70%">
					<select name="portNumber" style="width:400">
						<option value="">선택</option>
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
				<td class="action" colspan="2">
					<input type="button" name="SUBMIT" value="Search Logs"  onclick="return doAction()"></input>
				</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan=5>Local Server Connection Log</td>
			</tr>
			<tr class="subheading2">
				<td>Port Number</td>
				<td>Action</td>
				<td>Occur Time</td>
				<td>Execution Server</td>
				<td>Closing Side</td>
			</tr>
			%ifvar -notempty OnlineConnectionInfoList%			
				%loop OnlineConnectionInfoList%
					<tr>
						<td>%value portNumber%</td>
						<td>%value action%</td>
						<td>%value occurTime%</td>
						<td>%value serverIP%</td>
						<td>%value closingSide%</td>
					</tr>
				%endloop%
			%else%
				<tr><td colspan=5>No local server connection logs are currently saved.</td></tr>
			%endifvar%
		</table>				
		</form>		
	</body>
</html>

%endinvoke%