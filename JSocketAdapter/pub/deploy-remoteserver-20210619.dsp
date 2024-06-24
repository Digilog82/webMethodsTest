%invoke JSocketAdapter.ADMIN:adminDeployConfig%

<html>
<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<title>Deploy Remote Server Socket</title>
<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
<SCRIPT SRC="%value designPath%webMethods.js.txt"></SCRIPT>

		<script language="javascript">
			function doAction(todo) {				
				document.pform.deploy.value = todo;
				
				if (todo == 'search') {
					document.pform.submit();
				} else {
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
						if(confirm("Do you really want to deploy all remote server sockets?")){
							document.pform.submit();
						}
					} else {
						document.pform.submit();
					}
				}
			}
			
			function alertMsg() {
				var msg = document.pform.alertMsg.value;
				
				if (msg != "") {
					alert(msg);
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
<body onload="javascript:alertMsg()">
	
		<div class="message">Target Server에서 Socket Name에 대한 정보(IP, Port 등)가 다를 경우 Deploy 한 후에 Target Server에서 직접 수정을 해야 합니다.</div>
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%

		<form name="pform" method="post" target="_self">
			<input type="hidden" name="deploy" value="">
			<input type="hidden" name="deployClass" value="%value deployClass%">
			<input type="hidden" name="selectedList" value="">
			<input type="hidden" name="targetServers" value="">
			<input type="hidden" name="checkMode" value="uncheck">
			<input type="hidden" name="alertMsg" value="%value deployMsg%">
		
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					Deploy Config &gt;
					Remote Server Socket
				</td>
			</tr>
		</table>
				
		%ifvar deploy equals('remote')%
			
			<ul class="listitems">
				<li class="listitem"><a href="deploy-remoteserver.dsp?deployClass=%value deployClass%&searchType=noDeploy">Return to Remote Server Socket Deployment Information</a></li>
			</ul>
			
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Remote Server Socket Deployment Result</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			
			%ifvar DeployResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>Remote Server Socket Information</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>Socket Name</td>
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
        	
        </table>
        
       %endifvar%
			
		%else%

			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Remote Server Socket Deployment</td>
				</tr>
				<tr>
					<tr>
						<td class="evenrow" width="30%">Target Server</td>
						<td class="evenrow-l" width="70%">
							<!-- 하나만 선택한 경우에는 targetServer 라는 이름으로 선택한 값이 flow service에 전달되고
							     두 개 이상을 선택한 경우에는 targetServer 라는 이름으로 첫번째 선택한 값과
							     targetServerList 라는 이름으로(자동으로 생성됨) 선택한 모든 값이 StringList 형태로
							     flow service에 전달된다. -->
							<select name="targetServer" style="width:110" size=3 multiple>
								%loop remoteServerList%
									<option value="%value remoteServerList%">%value remoteServerList%</option>
								%endloop%
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
							<input type="button" name="SUBMIT" value="Search Remote Server Socket"  onclick="return doAction('search')"></input>&nbsp;&nbsp;
							<input type="button" name="SUBMIT" value="Deploy Remote Server Socket"  onclick="return doAction('remote')"></input>
						</td>
					</tr>
				</tr>
			</table>

      <table class="tableView" width=100%>
        <tr>
					<td class="heading" colspan=10>Remote Server Socket Information</td>
				</tr>
        <tr class="subheading2">
					<td>Select <a href="javascript:allChecked()">All</a></td>
					<td>Enabled</td>
					<td>Provider System Name</td>
					<td>Socket Name</td>
					<td>Description</td>
					<td>IP</td>
					<td>Port</td>
					<td>Read Timeout</td>
					<td>Asynch Online YN</td>
					<td>Listener Service</td>
        </tr>
				%ifvar -notempty RegInfoList%
					%loop RegInfoList -$index%
						<tr>
							<td class="evenrowdata"><input type="checkbox" name="selectedList%value $index%" value="%value name%">
							<td>
								%ifvar enabled equals('enabled')%
									Yes
								%else%
									No
								%endifvar%
							</td>
							<td>%value systemName%</td>
							<td>%value name%</td>
							<td>%value description%</td>
							<td>%value ip%</td>
							<td>%value port%</td>
							<td class="evenrowdata">%value readTimeout%</td>
							<td class="evenrowdata">%value online%</td>
							<td>%value servicePath%</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan=10>No remote server sockets to deploying are currently.</td></tr>
				%endif%
    	</table>
		%endifvar%
	</form>
</body>
</html>

%endinvoke%