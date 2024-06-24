%invoke JSocketAdapter.ADMIN:adminToggleDataQListener%

<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
<SCRIPT SRC="%value designPath%webMethods.js.txt"></SCRIPT>

		<script language="javascript">
			function doAction(enable){
				document.pform.enable.value = enable;
				document.pform.submit();
			}
			
			function makeBusinessName(systemName) {
				var businessName = document.pform.businessName;
				
				if (systemName == 'ALL') {
					// 기존의 Option 삭제
					while (businessName.options.length > 0) {
						businessName.options.remove(0);
					}
					
					businessName.options[0] = new Option("ALL", "ALL");
				} else {				
					for (var i=0; i < document.pform.length; i++) {
						if (document.pform.elements[i].name == systemName) {
							var businessNames = document.pform.elements[i].value;
							var tockens = businessNames.split("/");
						  
							// 기존의 Option 삭제
							while (businessName.options.length > 0) {
								businessName.options.remove(0);
							}
						
							// 해당 System Name에 속한 Business Name Option 추가
							businessName.options[0] = new Option("ALL", "ALL");
							for (var i = 0; i < tockens.length; i++) {
								businessName.options[i + 1] = new Option(tockens[i], tockens[i]);
							}
						
							break;
						}
					}
				}
			}
			
			function makeSearchBusinessName(systemName) {
				if (systemName == 'ALL') {
				} else {
					/*
					var busiName = "%value businessName%";
					makeBusinessName(systemName);
					var businessName = document.pform.businessName;
					
					for (var i = 0; i < businessName.options.length; i++) {
						if (businessName.options[i].value == busiName) {
							businessName.options[i].checked = true;
							break;
						}
					}
					*/
					makeBusinessName(systemName);
					
					// 검색조건 Business Name Set.
					document.pform.businessName.value = "%value businessName%";
				}
				
				var frm = document.pform;
				var msg = frm.alertMsg.value;
				
				if (msg != "") {
					alert(msg);
					frm.alertMsg.value = ""; // 다른 화면으로 이동 시 영향을 주기 때문에 alertMsg 를 공백처리 한다.
				}
			}
		</script>
		
</head>

<body onload="javascript:makeSearchBusinessName('%value systemName%')">

		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%

		<form name="pform" method="post" target="_self">
			<input type="hidden" name="enable" value="">
			<input type="hidden" name="alertMsg" value="%value alertMsg%">
			
		%loop businessNameList%		
			<input type="hidden" name="%value systemName%" value="%value businessName%">			
		%endloop%
		
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					AS/400 &gt;
					Toggle Listener
				</td>
			</tr>
		</table>
				
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Data Q Listeners Enable/Disable</td>
			</tr>
			<tr>
				<tr>
					<td class="evenrow" width="30%">Provider System Name</td>
					<td class="evenrow-l" width="70%">
						<select name="systemName" style="width:90" onchange="makeBusinessName(this.value)">
							<option value="ALL">ALL</option>
							%loop systemNameList%
								<option value="%value systemNameList%">%value systemNameList%</option>
							%endloop%
						</select>
						<script language="javascript">
							document.pform.systemName.value = "%value systemName%";
						</script>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Business Name</td>
					<td class="evenrow-l" width="70%">
						<select name="businessName" style="width:90">
							<option value="ALL">ALL</option>
						</select>	
					</td>
				</tr>
				<tr>
					<td class="action" colspan="2">						
						<input type="button" name="SUBMIT" value="Search Listener"  onclick="return doAction('search')"></input>&nbsp;&nbsp;
						<input type="button" name="SUBMIT" value="Enable Listener"  onclick="return doAction('true')"></input>&nbsp;&nbsp;
						<input type="button" name="SUBMIT" value="Disable Listener"  onclick="return doAction('false')"></input>
					</td>
				</tr>
			</tr>
		</table>

    <table class="tableView" width=100%>     
      
      %ifvar serverType equals('PROD')%
      
      <tr><td class="heading" colspan="9">AS400 Data Q Listeners</td></tr>
      <tr class="subheading2">
        <td rowspan="2">Connection Alias</td>
        <td rowspan="2">Listener Node Name</td>
        <td rowspan="2">Data Queue Name</td>
        <td rowspan="2">Is Keyed</td>
        <td rowspan="2">Key Value</td>
        <td colspan="2">PROD1</td>
        <td colspan="2">PROD2</td>
      </tr>
      <tr class="subheading2">
        <td>Status</td>
        <td>Enabled</td>
        <td>Status</td>
        <td>Enabled</td>
      </tr>
			%ifvar -notempty dataQueueListeners%
      %loop dataQueueListeners%
			<tr>
				<td>%value connectionAlias%</td>
				<td>%value notificationNodeName%</td>
				<td>%value dataQueueName%</td>
				<td>%value isKeyedDataQueue%</td>
				<td>%value keyValue%</td>
				<td class="evenrowdata">
					%ifvar isRunning1 equals('true')%
						<img src="%value ../designPath%icons/green-ball.gif" alt="Listener is Running" border="0">
					%else%
						<img src="%value ../designPath%icons/red-ball.gif" alt="Listener Not Running" border="0">
					%endifvar%
				</td>
				<td class="evenrowdata">
					%ifvar notificationEnabled1 equals('true')%
						<img src="%value ../designPath%images/green_check.png" height=13 width=13 alt="Enabled" border=0>Yes
					%else%
						<img src="%value ../designPath%images/blank.gif" border=0 alt="Disabled">No
					%endifvar%
				</td>
				<td class="evenrowdata">
					%ifvar isRunning2 equals('true')%
						<img src="%value ../designPath%icons/green-ball.gif" alt="Listener is Running" border="0">
					%else%
						<img src="%value ../designPath%icons/red-ball.gif" alt="Listener Not Running" border="0">
					%endifvar%
				</td>
				<td class="evenrowdata">
					%ifvar notificationEnabled2 equals('true')%
						<img src="%value ../designPath%images/green_check.png" height=13 width=13 alt="Enabled" border=0>Yes
					%else%
						<img src="%value ../designPath%images/blank.gif" border=0 alt="Disabled">No
					%endifvar%
				</td>
			</tr>
		%endloop%
		%else%
			<tr><td colspan="9">No listeners are currently registered.</td></tr>
    %endif%
    
    %else%
    
    	<tr><td class="heading" colspan="7">AS400 Data Q Listeners</td></tr>
    	<tr class="subheading2">
    	  <td>Connection Alias</td>
    	  <td>Listener Node Name</td>
    	  <td>Data Queue Name</td>
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
			<tr><td colspan=7>No listeners are currently registered.</td></tr>
    %endif%
    
    %endif%        

    </table>
   </form>
</body>
</html>

%endinvoke%