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
					
					if (document.pform.dupProcessType.value == "update") {
						if (confirm("Processing Type For Duplicates 항목을 Update를 선택 시 Target Server에 이미 등록되어 있는 정보에 대해서는 Update 처리 됩니다.\n계속 진행하시겠습니까?")) {
						
						} else {
							return;
						}
					}
					
					/*
					var cSocketName = "";
					var asisIP = "";
					var asisPort = "";
					var tobeIP = "";
					var tobePort = "";
					var asisIPVal = "";
					var asisPortVal = "";
					var tobeIPVal = "";
					var tobePortVal = "";
					
					for (var i=0; i < document.pform.length; i++) {
						if (document.pform.elements[i].checked) {
							cSocketName = document.pform.elements[i].value;
							asisIP = "asisIP" + cSocketName;
							asisPort = "asisPort" + cSocketName;
							tobeIP = "tobeIP" + cSocketName;
							tobePort = "tobePort" + cSocketName;
							asisIPVal = document.getElementById(asisIP).value;
							asisPortVal = document.getElementById(asisPort).value;
							tobeIPVal = document.getElementById(tobeIP).value;
							tobePortVal = document.getElementById(tobePort).value;
							
							if (asisIPVal == "" && tobeIPVal != "") {
								document.pform.selectedList.value = "";
								alert("Socket Name " + cSocketName + "의 This Server IP를 입력하십시요!!!");
								return;
							}
							
							if (asisPortVal == "" && tobePortVal != "") {
								document.pform.selectedList.value = "";
								alert("Socket Name " + cSocketName + "의 This Server Port를 입력하십시요!!!");
								return;
							}
							
							if (document.pform.selectedList.value == "") {
								document.pform.selectedList.value = cSocketName + "|" + asisIPVal + "|" + asisPortVal + "|" + tobeIPVal + "|" + tobePortVal;
							} else {
								document.pform.selectedList.value = document.pform.selectedList.value + "/" + cSocketName + "|" + asisIPVal + "|" + asisPortVal + "|" + tobeIPVal + "|" + tobePortVal;
							}
						}
					}
					*/
					
					var cSocketName = "";
					var tobeIP = "";
					var tobePort = "";
					var tobeIPVal = "";
					var tobePortVal = "";
					
					for (var i=0; i < document.pform.length; i++) {
						if (document.pform.elements[i].checked) {
							cSocketName = document.pform.elements[i].value;
							tobeIP = "tobeIP" + cSocketName;
							tobePort = "tobePort" + cSocketName;
							tobeIPVal = document.getElementById(tobeIP).value;
							tobePortVal = document.getElementById(tobePort).value;
							
							if (tobeIPVal == "") {
								tobeIPVal = "NC";
							}
							
							if (tobePortVal == "") {
								tobePortVal = "NC";
							}
							
							if (document.pform.selectedList.value == "") {
								document.pform.selectedList.value = cSocketName + "|" + tobeIPVal + "|" + tobePortVal;
							} else {
								document.pform.selectedList.value = document.pform.selectedList.value + "/" + cSocketName + "|" + tobeIPVal + "|" + tobePortVal;
							}
						}
					}
					
					if (document.pform.selectedList.value == "") {
						alert("Deploy할 Socket Name을 선택하십시요!!!");
						return;
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
						
						if (eleName.indexOf("checkedList") >= 0) {
							if (!document.pform.elements[i].checked) {
								document.pform.elements[i].checked = true;
							}
						}
					}
					
					document.pform.checkMode.value = "check";
				} else { // All Unchecked
					for (var i=0; i < document.pform.length; i++) {
						eleName = document.pform.elements[i].name;
						
						if (eleName.indexOf("checkedList") >= 0) {
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
		%ifvar deploy equals('remote')%
		%else%
		<div class="message">Target Server에서 Socket Name에 대한 정보(IP, Port)가 다를 경우 "Change IP & Port" 항목의 Target Server IP, Port를 수정하십시요.</div>
		%endifvar%
		
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
				<li class="listitem"><a href="deploy-remoteserver.dsp?deployClass=%value deployClass%&searchType=noDeploy&dupProcessType=notAdd">Return to Remote Server Socket Deployment Information</a></li>
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
						<td class="heading" colspan=5>Remote Server Socket Information</td>
					</tr>
					<tr class="subheading2">
						<td>Seq</td>
						<td>Target Server</td>
						<td>Socket Name</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>
        	</tr>
        	
        	%loop DeployResult%
        	
        		<tr>
        			<td>%value deployNum%</td>
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
					<td class="evenrow" width="30%">Processing Type For Duplicates</td>
					<td class="evenrow-l" width="70%">
						<select name="dupProcessType" style="width:110">
							<option value="notAdd">Not Add</option>
							<option value="update">Update</option>
						</select>
						<script language="javascript">
							document.pform.dupProcessType.value = "%value dupProcessType%";
						</script>
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
			</table>

      <table class="tableView" width=100%>
        <tr>
					<td class="heading" colspan="6">Remote Server Socket Information</td>
				</tr>
        <tr class="subheading2">
					<td>Select <a href="javascript:allChecked()">All</a></td>
					<td>Socket Name</td>
					<td>Description</td>
					<td>IP</td>
					<td>Port</td>
					<td>Change IP & Port</td>
        </tr>
				%ifvar -notempty RegInfoList%
					%loop RegInfoList -$index%
						<tr>
							<td class="evenrowdata"><input type="checkbox" name="checkedList%value $index%" value="%value name%">
							<td>%value name%</td>
							<td>%value description%</td>
							<td>%value ip%</td>
							<td>%value port%</td>
							<td>
								This Server <input type="text" disabled id="asisIP%value name%" name="asisIP%value name%nm" value="%value ip%" size="5" style="font-size:10pt;width:200">&nbsp;&nbsp;
                                            <input type="text" disabled id="asisPort%value name%" name="asisPort%value name%nm" value="%value port%" size="5" style="font-size:10pt;width:70"> -->
								Target Server <input type="text" id="tobeIP%value name%" name="tobeIP%value name%nm" value="%value ip%" size="5" style="font-size:10pt;width:200">&nbsp;&nbsp;
								              <input type="text" id="tobePort%value name%" name="tobePort%value name%nm" value="%value port%" size="5" style="font-size:10pt;width:70">
							</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan="6">No remote server sockets to deploying are currently.</td></tr>
				%endif%
    	</table>
		%endifvar%
	</form>
</body>
</html>

%endinvoke%