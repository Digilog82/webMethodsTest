%invoke JSocketAdapter.ADMIN:getOnlineDataQListenerList%

<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
<SCRIPT SRC="%value designPath%webMethods.js.txt"></SCRIPT>
</head>

<body>

<table width="100%">
	<tr>
		<td class="menusection-Settings" colspan="2">
			JSocketAdapter Package Home &gt;
			%value systemName% Online Client &gt;
			Data Q Listener
		</td>
	</tr>
</table>

      <table class="tableView" width=100%>
        <tr><td class="heading" colspan=8>AS400 Data Q Listeners</td></tr>
        <tr class="subheading2">
          <td>Connection Alias</td>
          <td>Listener Node Name</td>
          <td>Data Queue Name</td>
          <td>Business Name</td>
          <td>Is Keyed</td>
          <td>Key Value</td>
          <td>Status</td>
          <td>Enabled</td>
        </tr>
				%ifvar -notempty dataQueueListeners%
        %loop dataQueueListeners%
				<tr>
					<td>%value connectionAlias%</td>
					<td>%value notificationNodeName%</td>
					<td>%value dataQueueName%</td>
					<td>%value businessName%</td>
					<td>%value isKeyedDataQueue%</td>
					<td>%value keyValue%</td>
					<td class="evenrowdata">
						%ifvar isRunning equals('true')%
							<img src="%value ../designPath%icons/green-ball.gif" alt="Listener is Running" border="0">
						%else%
							<img src="%value ../designPath%icons/red-ball.gif" alt="Listener Not Running" border="0">
						%endifvar%
					</td>
					<td class="evenrowdata">
						%ifvar notificationEnabled equals('true')%
							<img src="%value ../designPath%images/green_check.png" height=13 width=13 alt="Enabled" border=0>Yes
						%else%
							<img src="%value ../designPath%images/blank.gif" border=0 alt="Disabled">No
						%endifvar%
					</td>
				</tr>
			%endloop%
			%else%
			<tr><td colspan=8>No listeners are currently registered.</td></tr>
      %endif%
    </table>
</body>
</html>

%endinvoke%