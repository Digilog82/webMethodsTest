%invoke JSocketAdapter.ADMIN:adminDeployQueueTopic%

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
				} else {
					if (aDeploying == 'remote') {
						document.pform.todo.value = "remote";
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
								document.pform.selectedList.value = document.pform.selectedList.value + "$" + document.pform.elements[i].value;
							}
						}
					}
				
					if (document.pform.selectedList.value == "") {
						alert("Deploy 할 Queue/Topic을 선택하십시요.");
						return;
					}
					
					document.pform.submit();
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
			<input type="hidden" name="selectedList" value="">
			<input type="hidden" name="targetServers" value="">
			<input type="hidden" name="checkMode" value="uncheck">
			<input type="hidden" name="alertMsg" value="%value deployMsg%">
			
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					Deploy Config &gt;
					Queue/Topic
				</td>
			</tr>
		</table>
			
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Queue/Topic Deployment</td>
			</tr>
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
				<td class="action" colspan="2">						
					<input type="button" name="SUBMIT" value="Deploy Queue/Topic"  onclick="return doAction('remote')"></input>
				</td>
			</tr>
		</table>

		<table class="tableView" width=100%>
			<tr>
				<td class="heading" colspan=3>Queue/Topic</td>
			</tr>
			<tr class="subheading2">
				<td>Select <a href="javascript:allChecked()">All</a></td>
				<td>Queue/Topic</td>
				<td>Queue/Topic Name</td>
			</tr>
			%ifvar -notempty QueueTopicList%
				%loop QueueTopicList -$index%
					<tr>
						<td class="evenrowdata"><input type="checkbox" name="selectedList%value $index%" value="%value aliasName%|%value type%|%value name%">
						<td>%value type%</td>
						<td>%value name%</td>
					</tr>
				%endloop%
			%else%
				<tr><td colspan=7>No queues/topics are currently registered.</td></tr>
			%endifvar%
    	</table>
		</form>
	</body>
</html>

%endinvoke%