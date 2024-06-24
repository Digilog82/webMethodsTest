%invoke JSocketAdapter.ADMIN:adminDeployConfig%

<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
<SCRIPT SRC="%value designPath%webMethods.js.txt"></SCRIPT>

		<script language="javascript">
			function doAction(todo) {				
				document.pform.deploy.value = todo;
				
				if (todo == 'search') {
					document.pform.submit();
				} else {
					if (confirm("Target Server에 이미 Deploy 한 Interface ID에 대해서는 Target Server에서 Update 하고 처음 Deploy 하는 Interface ID에 대해서는 Add 합니다.\n계속 진행하시겠습니까?")){
					} else {
						return;
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
						alert("Deploy할 Interface ID를 선택하십시요!!!");
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
					Source Target Email
				</td>
			</tr>
		</table>
				
		%ifvar deploy equals('remote')%
			
			<ul class="listitems">
				<li class="listitem"><a href="deploy-stemail.dsp?deployClass=%value deployClass%&searchType=noDeploy">Return to Source Target Email Deployment Information</a></li>
			</ul>
			
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Source Target Email Deployment Result</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			
			%ifvar DeployResult -notempty%
			
			<table class="tableView" width=100%>
				<tr>
					<td class="heading" colspan=5>Source Target Email Information</td>
				</tr>
				<tr class="subheading2">
					<td>Seq</td>
					<td>Target Server</td>
					<td>Interface ID</td>
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
					<td class="heading" colspan="2">Source Target Email Deployment</td>
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
						<input type="button" name="SUBMIT" value="Search Source Target Email"  onclick="return doAction('search')"></input>&nbsp;&nbsp;
						<input type="button" name="SUBMIT" value="Deploy Source Target Email"  onclick="return doAction('remote')"></input>
					</td>
				</tr>
			</table>

			<table class="tableView" width=100%>
				<tr>
					<td class="heading" colspan=6>Source Target Email Information</td>
				</tr>
				<tr class="subheading2">
					<td>Select <a href="javascript:allChecked()">All</a></td>
					<td>Interface ID</td>
					<td>Doc Name</td>
					<td>Description</td>
					<td>Source System Incharge Email</td>
					<td>Target System Incharge Email</td>
				</tr>
				%ifvar -notempty RegInfoList%
					%loop RegInfoList -$index%
						<tr>
							<td class="evenrowdata"><input type="checkbox" name="selectedList%value $index%" value="%value interfaceID%">
							<td>%value interfaceID%</td>
							<td>%value docName%</td>
							<td>%value description%</td>
							<td>
								%loop sourceEmailList%
									%value email%<br>
								%endloop%
							</td>
							<td>
								%loop targetEmailList%
									%value email%<br>
								%endloop%
							</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan=6>No source target emails to deploying are currently.</td></tr>
				%endif%
			</table>
		%endifvar%
	</form>
</body>
</html>

%endinvoke%