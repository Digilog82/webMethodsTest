%invoke JSocketAdapter.ADMIN:adminOnlineRemoteServer%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">

			function doChange(pname, ptodo) {
				if (ptodo == 'alltrue') {
					if (confirm("Are you sure you want to enable all connection?")) {
						// continue
					} else {
						return;
					}
				} else if (ptodo == 'allfalse') {
					if (confirm("Are you sure you want to close all connection?")) {
						// continue
					} else {
						return;
					}
				}
				
				var frm = document.pform;
				frm.name.value = pname;
				frm.todo.value = ptodo;	
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
					%value systemName% Online Client &gt;
					Online Connection
				</td>
			</tr>
		</table>
		<input type="hidden" name="name" value="">
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="systemName" value="%value systemName%">
		<input type="hidden" name="deleteFirstConnFile" value="true">
		<input type="hidden" name="connectOrderer" value="Administrator">
		<table class="tableForm" width="100%">				
			<tr>
				<td class="heading" colspan=8>%value systemName% Asynch Online Socket Connections Infomation</td>
			</tr>
			<tr class="subheading2">
				<td>Socket Name</td>
				<td>Description</td>
				<td>IP</td>
				<td>Port Number</td>
				<td>Listener Service</td>
				<td>Connction Status</td>
				<td>Alive Status</td>
				<td>To Do</td>
			</tr>
			%loop ClientPortConfig/Ports%
			
				%ifvar name -notempty%
				
				<tr>
					<td>%value name%</td>
					<td>%value description%</td>
					<td>%value ip%</td>
					<td>%value port%</td>
					<td>%value servicePath%</td>					
					<td class="evenrowdata">
						%ifvar connection equals('true')%
							<img src="%value ../../designPath%images/enable_icon_16.png" alt="connected" border="0">
						%else%
							<img src="%value ../../designPath%images/disable_icon_16.png" alt="disconnected" border="0">
						%endifvar%
					</td>
					<td class="evenrowdata">
						%ifvar alive equals('true')%
							<img src="%value ../../designPath%images/enable_icon_16.png" alt="enabled" border="0">
						%else%
							<img src="%value ../../designPath%images/disable_icon_16.png" alt="closed" border="0">
						%endifvar%
					</td>
					<td class="evenrowdata">
						%ifvar connection equals('true')%
							<a href="javascript:doChange('%value name%', 'false')" onclick="return confirm('Are you sure you want to close connection?');">Close</a>
						%else%
							<a href="javascript:doChange('%value name%', 'true')" onclick="return confirm('Are you sure you want to enable connection?');">Connect</a>
						%endifvar%
					</td>
				</tr>
				
				%else%
				
				<tr>
					<td colspan="8" height="10" bgcolor="white"></td>
				</tr>
				
				%endif%
				
			%endloop%
			
			<tr>
				<td class="action" colspan="8">
					<input type="button" name="SUBMIT" value="All Connect"  onclick="return doChange('', 'alltrue')"></input>&nbsp;&nbsp;
					<input type="button" name="SUBMIT" value="All Close"  onclick="return doChange('', 'allfalse')"></input>
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>

%endinvoke%