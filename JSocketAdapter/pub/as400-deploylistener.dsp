%invoke JSocketAdapter.ADMIN:adminDeployDataQListener%

<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
<SCRIPT SRC="%value designPath%webMethods.js.txt"></SCRIPT>

		<script language="javascript">
			function doAction(aDeploying) {
				if (aDeploying == 'search') {
					document.pform.deploy.value = "search";
					document.pform.submit();
				} else {
					if (aDeploying == 'remote') { // Listener를 Disable 상태로 Deploy
						document.pform.deploy.value = "remote";
						document.pform.deployType.value = "disabled";
					} else if (aDeploying == 'remoteenabled') { // Listener를 Deploy 한 후 Enable 상태로 Update
						document.pform.deploy.value = "remote";
						document.pform.deployType.value = "enabled";
					} else if (aDeploying == 'reserve') { // Listener Deploy를 예약시간에 수행하도록 함. Listener를 Disable 상태로 Deploy
						var sDate = document.pform.sDate.value;
						var sTime = document.pform.sTime.value;
						
						if (sDate == "") {
							alert("예약 날짜를 입력하십시요.");
							return;
						}
						
						if (sTime == "") {
							alert("예약 시간을 입력하십시요.");
							return;
						}
						
						document.pform.deploy.value = "reserve";
						document.pform.deployType.value = "disabled";
					} else if (aDeploying == 'reserveenabled') { // Listener Deploy를 예약시간에 수행하도록 함. Listener를 Deploy 한 후 Enable 상태로 Update
						var sDate = document.pform.sDate.value;
						var sTime = document.pform.sTime.value;
						
						if (sDate == "") {
							alert("예약 날짜를 입력하십시요.");
							return;
						}
						
						if (sTime == "") {
							alert("예약 시간을 입력하십시요.");
							return;
						}
						
						document.pform.deploy.value = "reserve";
						document.pform.deployType.value = "enabled";
					}
					
					var targetServerLength = document.pform.targetServer.options.length;
					var remoteAliasList = "";
					
					for (var i = 0; i < targetServerLength; i++) {
						if (document.pform.targetServer.options[i].selected) {
							if (remoteAliasList == "") {
								remoteAliasList = document.pform.targetServer.options[i].value;
							} else {
								remoteAliasList = remoteAliasList + "/" + document.pform.targetServer.options[i].value;
							}
						}
					}
					
					if (remoteAliasList == "") {
						alert("Target Server를 선택하십시요!!!");
						return;
					}
					
					document.pform.targetServers.value = remoteAliasList;
					
					// 운영서버에 Deploy 한 후에 Enable 하는 경우
					var deployToProd = document.pform.deployToProd.value;
					
					if (deployToProd == "Yes") {
						var deployType = document.pform.deployType.value;
						
						if (deployType == "enabled") {
							var enablingServer = document.pform.enablingServer.value;
						
							if(confirm("운영서버에 Deploy 하는 경우 어떤 서버에서 Enable 할지\n정확하게 선택해야 합니다.\n" + enablingServer + " 서버에서 Enable 하시겠습니까?")) {
							} else {
								return;
							}
						}
					}
					
					for (var i=0; i < document.pform.length; i++) {
						if (document.pform.elements[i].checked) {
							if (document.pform.selectedList.value == "") {
								document.pform.selectedList.value = document.pform.elements[i].value;
							} else {
								document.pform.selectedList.value = document.pform.selectedList.value + "/" + document.pform.elements[i].value;
							}
						}
					}
				
					if (document.pform.selectedList.value == "") {
						if(confirm("Do you really want to deploy all data q listeners?")) {
							document.pform.submit();
						}
					} else {
						document.pform.submit();
					}
				}
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
				var deploy = "%value deploy%";
				
				if (deploy == "remote") {
					return;
				}
				
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
			
			function displayEnablingServer(toProd) {
				var enablingServer = document.pform.enablingServer;
				
				if (toProd == 'No') { // 운영서버에 Deploy 하지 않는 경우
					// 기존의 Option 삭제
					while (enablingServer.options.length > 0) {
						enablingServer.options.remove(0);
					}
				} else { // 운영서버에 Deploy 하는 경우
					enablingServer.options[0] = new Option("PROD1", "PROD1");
					enablingServer.options[1] = new Option("PROD2", "PROD2");
					enablingServer.options[2] = new Option("ALL", "ALL");
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

<body onload="javascript:makeSearchBusinessName('%value systemName%')">

		<div class="message">Deploy 하기 전에 Target Server에서 Listener Node Name에 해당하는 Flow Service가 이미 생성되어 있어야 합니다.</div>
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%

		<form name="pform" method="post" target="_self">
			<input type="hidden" name="deploy" value="">
			<input type="hidden" name="deployType" value="">
			<input type="hidden" name="selectedList" value="">
			<input type="hidden" name="targetServers" value="">
			<input type="hidden" name="checkMode" value="uncheck">
			<input type="hidden" name="alertMsg" value="%value deployMsg%">
			
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					AS/400 &gt;
					Deploy Listener
				</td>
			</tr>
		</table>
				
		%ifvar deploy equals('remote')%
			
			<ul class="listitems">
				<li class="listitem"><a href="as400-deploylistener.dsp?systemName=%value systemName%&businessName=%value businessName%&deploy=search&searchType=noDeploy">Return to Data Q Listeners Deployment Information</a></li>
			</ul>
			
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Data Q Listeners Deployment Result</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			
			%ifvar DeployResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>Data Q Listeners Information</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>Listener Node Name</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>
        	</tr>
        	
        	%loop DeployResult%
        	
        		<tr>
        			<td>%value targetServer%</td>
        			<td>%value keyValue%</td>
        			<td>%value deployYN%</td>
        			<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
        			</td>
        		</tr>
        		
        	%endloop%
        	
        	<tr><td>&nbsp;</td></tr>
        </table>
        
       %endifvar%
			
		%else%
			
			%loop businessNameList%		
				<input type="hidden" name="%value systemName%" value="%value businessName%">			
			%endloop%
			
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Data Q Listeners Deployment</td>
				</tr>
				<tr>
					<tr>
						<td class="evenrow" width="30%">Target Server</td>
						<td class="evenrow-l" width="70%">
							<!-- 하나만 선택한 경우에는 targetServer 라는 이름으로 선택한 값이 flow service에 전달되고
							     두 개 이상을 선택한 경우에는 targetServer 라는 이름으로 첫번째 선택한 값과
							     targetServerList 라는 이름으로(자동으로 생성됨) 선택한 모든 값이 StringList 형태로
							     flow service에 전달된다. -->
							<select name="targetServer" style="width:90" size=3 multiple>
								%loop remoteServerList%
									<option value="%value remoteServerList%">%value remoteServerList%</option>
								%endloop%
							</select>
						</td>
					</tr>										
					<tr>
						<td class="evenrow" width="30%">Change Library</td>
						<td class="evenrow-l" width="70%">
							Local Server Library Name <input type="text" name="fromLib" size="5" style="font-size:10pt;width:100"> -->
							Target Server Library Name <input type="text" name="toLib" size="5" style="font-size:10pt;width:100">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Reservation Time</td>
						<td class="evenrow-l" width="70%">
							<input type="text" name="sDate" size="5" style="font-size:10pt;width:100">&nbsp;YYYY/MM/DD&nbsp;
							<input type="text" name="sTime" size="5" style="font-size:10pt;width:100">&nbsp;HH:MM:SS
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Deploy to PROD Server</td>
						<td class="evenrow-l" width="70%">
							<select name="deployToProd" style="width:110" onchange="displayEnablingServer(this.value)">
								<option value="No">No</option>
								<option value="Yes">Yes</option>
							</select>&nbsp;&nbsp;&nbsp;&nbsp;Enabling Server&nbsp;
							<select name="enablingServer" style="width:90">
							</select>&nbsp;(운영서버에 Deploy 후 Listener를 Enable 하는 경우에 선택)
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Provider System Name</td>
						<td class="evenrow-l" width="70%">
							<select name="systemName" style="width:110" onchange="makeBusinessName(this.value)">
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
							<select name="businessName" style="width:110">
								<option value="ALL">ALL</option>
							</select>	
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Search Type</td>
						<td class="evenrow-l" width="70%">
							<select name="searchType" style="width:110">
								<option value="noDeploy">Only No Deploy</option>
								<option value="All">ALL</option>
							</select>
							<script language="javascript">
								document.pform.searchType.value = "%value searchType%";
							</script></td>							
						</td>
					</tr>
					<tr>
						<td class="action" colspan="2">						
							<input type="button" name="SUBMIT" value="Search Listener"  onclick="return doAction('search')"></input>&nbsp;&nbsp;
							<input type="button" name="SUBMIT" value="Deploy Listener to Disabled"  onclick="return doAction('remote')"></input></input>&nbsp;&nbsp;
							<input type="button" name="SUBMIT" value="Deploy Listener to Enabled"  onclick="return doAction('remoteenabled')"></input>&nbsp;&nbsp;
							<input type="button" name="SUBMIT" value="Reserve to Disabled"  onclick="return doAction('reserve')"></input>&nbsp;&nbsp;
							<input type="button" name="SUBMIT" value="Reserve to Enabled"  onclick="return doAction('reserveenabled')"></input>
						</td>
					</tr>
				</tr>
			</table>

      <table class="tableView" width=100%>
        <tr><td class="heading" colspan=8>AS400 Data Q Listeners</td></tr>
        <tr class="subheading2">
					<td>Select <a href="javascript:allChecked()">All</a></td>
          <td>Connection Alias</td>
          <td>Listener Node Name</td>
          <td>Data Queue Name</td>
          <td>Is Keyed</td>
          <td>Key Value</td>
          <td>Status</td>
          <td>Enabled</td>
        </tr>
				%ifvar -notempty dataQueueListeners%
        	%loop dataQueueListeners -$index%
						<tr>
							<td class="evenrowdata"><input type="checkbox" name="selectedList%value $index%" value="%value connectionAlias%|%value notificationNodeName%|%value systemName%|%value businessName%|%value online%">
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
					<tr><td colspan=8>No listeners are currently registered.</td></tr>
      	%endifvar%
    	</table>
		%endifvar%
	</form>
</body>
</html>

%endinvoke%