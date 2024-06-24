%invoke JSocketAdapter.ADMIN:adminDeployConfig%

<html>
<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<title>Deploy System Name</title>
<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
<SCRIPT SRC="%value designPath%webMethods.js.txt"></SCRIPT>

		<script language="javascript">
			function doAction(todo, aRestName) {				
				document.pform.deploy.value = todo;
				
				if (todo == 'search') {
					document.pform.submit();
				} else if (todo == 'read') {
					document.pform.restName.value = aRestName;
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
					
					if (aRestName == "update") {
						// 상세화면에서 데이터 수정 후 Deploy 하는 경우
						var tempHttpHeaders = document.pform.tempHttpHeaders;
						var hLength = tempHttpHeaders.options.length;
						
						if (hLength == 0) {
						} else if (hLength == 1) {
							frm.httpHeader.value = tempHttpHeaders.options[0].value;
						} else {					
							// Http Header List 전체를 선택한 것으로 처리
							for (var i = 0; i < hLength; i++) {
								tempHttpHeaders.options[i].selected = true;
							}
						}
						
						document.pform.selectedList.value = document.pform.restName.value;
						document.pform.processLoc.value = "update";
					} else {
						for (var i=0; i < document.pform.length; i++) {
							if (document.pform.elements[i].checked) {
								if (document.pform.selectedList.value == "") {
									document.pform.selectedList.value = document.pform.elements[i].value;
								} else {
									document.pform.selectedList.value = document.pform.selectedList.value + "/" + document.pform.elements[i].value;
								}
							}
						}
					}
					
					if (document.pform.selectedList.value == "") {
						alert("Deploy할 REST API Protocol을 선택하십시요!!!");
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
			
			function addHttpHeader() {
				var tempHttpHeaders = document.pform.tempHttpHeaders;
				var tempHeaderName = document.pform.tempHeaderName.value;
				var tempHeaderValue = document.pform.tempHeaderValue.value;
				var tempHeaderService = document.pform.tempHeaderService.value;
				
				if (tempHeaderName == "") {
					alert("Http Header Name을 입력하십시요.");
					return;
				}
				
				if (tempHeaderValue == "" && tempHeaderService == "") {
					alert("Http Header Value, Service 중에서 하나를 입력하십시요.");
					return;
				}
				
				if (tempHeaderValue != "" && tempHeaderService != "") {
					alert("Http Header Value, Service 중에서 하나만 입력하십시요.");
					return;
				}
				
				if (tempHeaderValue == "") {
					tempHeaderValue = "NA";
				}
				
				if (tempHeaderService == "") {
					tempHeaderService = "NA";
				}
				
				var headerNV = tempHeaderName + "|" + tempHeaderValue + "|" + tempHeaderService;
				
				// Http Header Name 중복 체크
				var hNLength = tempHttpHeaders.options.length;
				for (var i=0; i < hNLength; i++) {
					var hNV = tempHttpHeaders.options[i].value;
					var hNVs = hNV.split("|");
					var hN = hNVs[0];
					
					if (tempHeaderName == hN) {
						alert("Http Header Name " + tempHeaderName + "는 이미 추가되어 있습니다.");
						return;
					}
				}
				
				tempHttpHeaders.options[hNLength] = new Option(headerNV, headerNV);
				document.pform.tempHeaderName.value = "";
				document.pform.tempHeaderValue.value = "";
				document.pform.tempHeaderService.value = "";
			}
			
			function deleteHttpHeader() {
				var tempHttpHeaders = document.pform.tempHttpHeaders;
				var hNLength = tempHttpHeaders.options.length;
				
				var optionIndex = 0;
				var newValueLength;
				var selectYN = "false";
				
				for (var i = 0; i < hNLength; i++) {
					if (tempHttpHeaders.options[optionIndex].selected) {
						document.pform.tempHeaderName.value = "";
						document.pform.tempHeaderValue.value = "";
						document.pform.tempHeaderService.value = "";
						tempHttpHeaders.options.remove(optionIndex);
						selectYN = "true";
					} else {
						optionIndex++;
					}
					
					newValueLength = tempHttpHeaders.options.length;
					
					if (optionIndex > (newValueLength-1)) {
						break;
					}
				}
				
				if (selectYN == "false") {
					alert("삭제할 Http Header Name:Value를 선택하십시요.");
					return;
				}
			}
			
			function updateHttpHeader() {
				var tempHttpHeaders = document.pform.tempHttpHeaders;
				var hNLength = tempHttpHeaders.options.length;
				var tempHeaderName = document.pform.tempHeaderName.value;
				var tempHeaderValue = document.pform.tempHeaderValue.value;
				var tempHeaderService = document.pform.tempHeaderService.value;
				var optionIndex = 0;
				var selectYN = "false";
				
				if (tempHeaderName == "") {
					alert("Http Header Name을 입력하십시요.");
					return;
				}
				
				if (tempHeaderValue == "" && tempHeaderService == "") {
					alert("Http Header Value, Service 중에서 하나를 입력하십시요.");
					return;
				}
				
				if (tempHeaderValue != "" && tempHeaderService != "") {
					alert("Http Header Value, Service 중에서 하나만 입력하십시요.");
					return;
				}
				
				if (tempHeaderValue == "") {
					tempHeaderValue = "NA";
				}
				
				if (tempHeaderService == "") {
					tempHeaderService = "NA";
				}
				
				var headerNV = tempHeaderName + "|" + tempHeaderValue + "|" + tempHeaderService;
				
				// Http Header Name 중복 체크
				for (var i=0; i < hNLength; i++) {
					var hNV = tempHttpHeaders.options[i].value;
					var hNVs = hNV.split("|");
					var hN = hNVs[0];
					
					if (tempHeaderName == hN) {
						if (confirm("Http Header Name " + tempHeaderName + "는 이미 추가되어 있습니다.\nValue 또는 Service만 수정하시겠습니까?")) {
							break;
						} else {
							return;
						}
					}
				}
								
				for (var i = 0; i < hNLength; i++) {
					if (tempHttpHeaders.options[optionIndex].selected) {
						tempHttpHeaders.options[optionIndex] = new Option(headerNV, headerNV);
						selectYN = "true";
						break;
					} else {
						optionIndex++;
					}
				}
				
				if (selectYN == "false") {
					alert("수정할 Http Header를 먼저 선택하십시요.");
					return;
				}
				
				document.pform.tempHeaderName.value = "";
				document.pform.tempHeaderValue.value = "";
				document.pform.tempHeaderService.value = "";
			}
			
			function setUpdateHttpHeader(hHeader) {
				var hNVs = hHeader.split("|");
				var tempHeaderName = hNVs[0];
				var tempHeaderValue = hNVs[1];
				var tempHeaderService = hNVs[2];
				
				if (tempHeaderValue == "NA") {
					tempHeaderValue = "";
				}
				
				if (tempHeaderService == "NA") {
					tempHeaderService = "";
				}
				
				document.pform.tempHeaderName.value = tempHeaderName;
				document.pform.tempHeaderValue.value = tempHeaderValue;
				document.pform.tempHeaderService.value = tempHeaderService;
			}
		</script>
		
</head>

<body onload="javascript:alertMsg()">
		%ifvar deploy equals('remote')%
		%else%
			%ifvar deploy equals('read')%
				<div class="message">Target Server에서 REST API Protocol에 대한 정보가 다를 경우 해당 항목의 Value를 수정해야 합니다.</div>
			%else%
				<div class="message">Target Server에서 REST API Protocol에 대한 정보가 다를 경우 Deploy 한 후에 Target Server에서 직접 수정을 해야 합니다.</div>
			%endifvar%
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
			<input type="hidden" name="restName" value="%value restName%">
			<input type="hidden" name="processLoc" value="">
		
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					Deploy Config &gt;
					REST API Protocol
				</td>
			</tr>
		</table>
				
		%ifvar deploy equals('remote')%
			
			<ul class="listitems">
				<li class="listitem"><a href="deploy-restapiprotocol.dsp?deployClass=%value deployClass%&searchType=noDeploy&dupProcessType=notAdd">Return to REST API Protocol Information</a></li>
			</ul>
			
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">REST API Protocol Deployment Result</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			
			%ifvar DeployResult -notempty%
			
				<table class="tableView" width=100%>
					<tr>
						<td class="heading" colspan=5>REST API Protocol Information</td>
					</tr>
					<tr class="subheading2">
						<td>Seq</td>
						<td>Target Server</td>
						<td>Name</td>
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
			
		%ifvar deploy equals('read')%
			
			<ul class="listitems">
				<li class="listitem"><a href="deploy-restapiprotocol.dsp?deployClass=%value deployClass%&searchType=%value searchType%&dupProcessType=%value dupProcessType%">Return to REST API Protocol Information</a></li>
			</ul>
			
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">REST API Protocol Deployment</td>
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
			</table>
			
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">REST API Protocol Properties</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Name</td>
					<td class="evenrow-l" width="70%">%value restName%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">API System Name</td>
					<td class="evenrow-l" width="70%">%value systemName%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">API Business Name</td>
					<td class="evenrow-l" width="70%">%value businessName%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Description</td>
					<td class="evenrow-l" width="70%">%value description%</td>
				</tr>					
				<tr>
					<td class="evenrow" width="30%">Internal API URL</td>
					<td class="evenrow-l" width="70%"><input type="text" name="internalApiUrl" value="%value internalApiUrl%" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Internal API Client ID</td>
					<td class="evenrow-l" width="70%"><input type="text" name="internalClientID" value="%value internalClientID%" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Internal API Client Password</td>
					<td class="evenrow-l" width="70%"><input type="text" name="internalClientSecret" value="%value internalClientSecret%" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Access Token API URL</td>
					<td class="evenrow-l" width="70%"><input type="text" name="accessTokenUrl" value="%value accessTokenUrl%" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Access Token Client ID</td>
					<td class="evenrow-l" width="70%"><input type="text" name="authClientID" value="%value authClientID%" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Access Token Client Password</td>
					<td class="evenrow-l" width="70%"><input type="text" name="authClientSecret" value="%value authClientSecret%" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Unlimited Access Token</td>
					<td class="evenrow-l" width="70%"><input type="text" name="unlimitedAccessToken" value="%value unlimitedAccessToken%" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Target API URL</td>
					<td class="evenrow-l" width="70%"><input type="text" name="targetApiUrl" value="%value targetApiUrl%" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Target API Client ID</td>
					<td class="evenrow-l" width="70%"><input type="text" name="targetClientID" value="%value targetClientID%" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Target API Client Password</td>
					<td class="evenrow-l" width="70%"><input type="text" name="targetClientSecret" value="%value targetClientSecret%" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Http Header</td>
					<td class="evenrow-l" width="70%">Name <input type="text" name="tempHeaderName" size="20" style="font-size:10pt;width:160">&nbsp;&nbsp;
													  Value <input type="text" name="tempHeaderValue" size="20" style="font-size:10pt;width:170"><br><br>
												      Service <input type="text" name="tempHeaderService" size="20" style="font-size:10pt;width:360">&nbsp;
													  <input type="button" name="ADDVALUE" value="Add Value"  onclick="return addHttpHeader()"></input>&nbsp;
													  <input type="button" name="ADDVALUE" value="Update Value"  onclick="return updateHttpHeader()"></input>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Http Header List</td>
					<td class="evenrow-l" width="70%">
						<select name="tempHttpHeaders" style="width:400" size=5 multiple onclick="setUpdateHttpHeader(this.value)">
							%loop httpHeaders%
								<option value="%value httpHeaders%">%value httpHeaders%</option>
							%endloop%
						</select>&nbsp;
						<input type="button" name="DELETEVALUE" value="Delete Value"  onclick="return deleteHttpHeader()"></input>
						<input type="hidden" name="httpHeader" value="">
					</td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Deploy REST API Protocol"  onclick="return doAction('remote', 'update')"></input>
					</td>
				</tr>
			</table>
		
		%else%

			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">REST API Protocol Deployment</td>
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
						<input type="button" name="SUBMIT" value="Search REST API Protocol"  onclick="return doAction('search', '')"></input>&nbsp;&nbsp;
						<input type="button" name="SUBMIT" value="Deploy REST API Protocol"  onclick="return doAction('remote', '')"></input>
					</td>
				</tr>
			</table>

			<table class="tableView" width=100%>
				<tr>
					<td class="heading" colspan=6>REST API Protocol Information</td>
				</tr>
				<tr class="subheading2">
					<td>Select <a href="javascript:allChecked()">All</a></td>
					<td>Name</td>
					<td>API System Name</td>
					<td>API Business Name</td>
					<td>Description</td>
					<td>Edit</td>
				</tr>
				%ifvar -notempty RegInfoList%
					%loop RegInfoList -$index%
						<tr>
							<td class="evenrowdata"><input type="checkbox" name="checkedList%value $index%" value="%value restName%">
							<td>%value restName%</td>
							<td>%value systemName%</td>
							<td>%value businessName%</td>
							<td>%value description%</td>
							<td class="evenrowdata">
								<a href="javascript:doAction('read', '%value restName%')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
							</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan=6>No rest api protocols to deploying are currently.</td></tr>
				%endif%
    	</table>
		%endifvar%
		%endifvar%
	</form>
</body>
</html>

%endinvoke%