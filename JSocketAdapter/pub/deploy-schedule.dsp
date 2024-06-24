%invoke JSocketAdapter.ADMIN:adminDeploySchedule%

<html>
<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<title>Deploy Schedule</title>
<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
<script src="stats/js/jquery-3.6.0.min.js"></script>
<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>

		<script language="javascript">
			function doAction(status){				
				if(confirm("Target Server에 Schedule Service가 이미 생성되어 있어야 합니다.\nDeploy 하시겠습니까?")){
				} else {
					return;
				}
				
				if (status == "Suspended") { // Schedule을 Deploy 한 후 Suspended 상태로 Update
					document.pform.deploy.value = "remote";
					document.pform.deployScheStatus.value = "Suspended";
				} else if (status == "Active") { // Schedule을 Active 상태로 Deploy
					document.pform.deploy.value = "remote";
					document.pform.deployScheStatus.value = "Active";
				} else if (status == "Reserve") { // Schedule Deploy를 예약시간에 수행하도록 함. Schedule을 Deploy 한 후 Suspended 상태로 Update
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
					document.pform.deployScheStatus.value = "Suspended";
				} else if (status == "Reserveactive") { // Schedule Deploy를 예약시간에 수행하도록 함. Schedule을 Active 상태로 Deploy
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
					document.pform.deployScheStatus.value = "Active";
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
					alert("Deploy할 ID를 선택하십시요!!!");
					return;
				} else {
					if (status == 'Reserve' || status == 'Reserveactive') {
						// Deploy를 예약하는 경우 예약처리 후 Deploy Config > Schedule Reservation 화면으로 이동하고 Deploy Config > Schedule Reservation 메뉴에 포커스가 간다.
						parent.menu.menuSelect("ideploy-scheduledeployreservation.dsp", "deploy-scheduledeployreservation.dsp");
					}
				
					document.pform.submit();
				}
			}
			
			/* 2022.08.17 수정. iframe을 사용하지 않고 JQuery를 사용하는 방식으로 변경
			function searchTargetNodes(remoteAlias) {
				document.frames["searchTargetNodeForm"].document.sform.remoteAlias.value = remoteAlias;
				document.frames["searchTargetNodeForm"].document.sform.submit();
			}
			*/
			
			function searchTargetNodes(remoteAlias) {
				if (remoteAlias == "") {
					alert("Target Server를 먼저 선택하십시요.");
					return;
				}
				
				$.ajax({
					type : "POST",
					url : "/invoke/JSocketAdapter.ADMIN/adminDeploySchedule",
					cache : false,
					data : "deploy=target&remoteAlias=" + remoteAlias,
					dataType : "json",
					async : true,
					success : function(result) {
								setTargetNodes(result.targetNodes);
							  },
					error : function() {
								alert("Target Node 목록을 조회하는 중에 에러가 발생하였습니다 !!!");
					        }
				});
			};
			
			function setTargetNodes(targetNodes) {
				var targetNodeList = targetNodes.split("/");
				var targetNodeSize = targetNodeList.length;
				var targetNode = document.pform.targetNode;
				
				// 기존의 Option 삭제
				while (targetNode.options.length > 0) {
					targetNode.options.remove(0);
				}
				
				// Target Node Option 추가
				targetNode.options[0] = new Option("Any server", "$any");
				targetNode.options[1] = new Option("All servers", "$all");
				
				for (var i = 0; i < targetNodeSize; i++) {
					targetNode.options[i + 2] = new Option(targetNodeList[i], targetNodeList[i]);
				}
			}
			
			function alertMsg() {
				var msg = document.pform.alertMsg.value;
				
				if (msg != "") {
					alert(msg);
				} 
			}
			
			function allCheckedS() {
				var checkModeS = document.pform.checkModeS.value;
				var eleName;
				
				if (checkModeS == "uncheck") { // All Checked
					for (var i=0; i < document.pform.length; i++) {
						eleName = document.pform.elements[i].name;
						
						if (eleName.indexOf("selectedListS") >= 0) {
							if (!document.pform.elements[i].checked) {
								document.pform.elements[i].checked = true;
							}
						}
					}
					
					document.pform.checkModeS.value = "check";
				} else { // All Unchecked
					for (var i=0; i < document.pform.length; i++) {
						eleName = document.pform.elements[i].name;
						
						if (eleName.indexOf("selectedListS") >= 0) {
							if (document.pform.elements[i].checked) {
								document.pform.elements[i].checked = false;
							}
						}
					}
					
					document.pform.checkModeS.value = "uncheck";
				}
			}
			
			function allCheckedC() {
				var checkModeC = document.pform.checkModeC.value;
				var eleName;
				
				if (checkModeC == "uncheck") { // All Checked
					for (var i=0; i < document.pform.length; i++) {
						eleName = document.pform.elements[i].name;
						
						if (eleName.indexOf("selectedListC") >= 0) {
							if (!document.pform.elements[i].checked) {
								document.pform.elements[i].checked = true;
							}
						}
					}
					
					document.pform.checkModeC.value = "check";
				} else { // All Unchecked
					for (var i=0; i < document.pform.length; i++) {
						eleName = document.pform.elements[i].name;
						
						if (eleName.indexOf("selectedListC") >= 0) {
							if (document.pform.elements[i].checked) {
								document.pform.elements[i].checked = false;
							}
						}
					}
					
					document.pform.checkModeC.value = "uncheck";
				}
			}
		</script>
		
</head>

<body onload="javascript:alertMsg()">

		%ifvar deploy equals('reserve')%
			<!-- Deploy를 예약하는 경우 예약처리 후 Deploy Config > Schedule Reservation 화면으로 이동하고 Deploy Config > Schedule Reservation 메뉴에 포커스가 간다. -->
			<form name="dform" action="deploy-scheduledeployreservation.dsp" method="post">
				<input type="hidden" name="alertMsg" value="%value deployMsg%">
			</form>
			<script langauge='javascript'>
				document.dform.submit();
			</script>
		%endifvar%
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%

		<form name="pform" method="post" target="_self">
			<input type="hidden" name="deploy" value="remote">
			<input type="hidden" name="selectedList" value="">
			<input type="hidden" name="deployScheStatus" value="">
			<input type="hidden" name="checkModeS" value="uncheck">
			<input type="hidden" name="checkModeC" value="uncheck">
			<input type="hidden" name="alertMsg" value="%value deployMsg%">
		
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					Deploy Config &gt;
					Schedule
				</td>
			</tr>
		</table>
				
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Schedule Deployment</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Target Server</td>
					<td class="evenrow-l" width="70%">
						<select name="remoteAlias" style="width:100" onchange="javascript:searchTargetNodes(this.value)">
							%loop remoteServerList%
								<option value="%value remoteServerList%">%value remoteServerList%</option>
							%endloop%
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Target Node</td>
					<td class="evenrow-l" width="70%">
						<select name="targetNode">
							<option value="$any">Any server</option>
							<option value="$all">All servers</option>
							%loop targetNodeList%
								<option value="%value logicalServerName%">%value logicalServerName%</option>
							%endloop%
						</select>
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
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Deploy Schedule to Suspended"  onclick="return doAction('Suspended')"></input>&nbsp;&nbsp;
						<input type="button" name="SUBMIT" value="Deploy Schedule to Active"  onclick="return doAction('Active')"></input>&nbsp;&nbsp;
						<input type="button" name="SUBMIT" value="Reserve to Suspended"  onclick="return doAction('Reserve')"></input>&nbsp;&nbsp;
						<input type="button" name="SUBMIT" value="Reserve to Active"  onclick="return doAction('Reserveactive')"></input>
					</td>
				</tr>
			</table>

      <table class="tableView" width=100%>
        <tr><td class="heading" colspan=6>One-Time and Simple Interval Tasks</td></tr>
        <tr class="subheading2">
					<td>Select <a href="javascript:allCheckedS()">All</a></td>
          <td>ID</td>
					<td>Service</td>
					<td>Description</td>
					<td>Target</td>
					<td>Status</td>
        </tr>
				%ifvar -notempty tasks%
        %loop tasks -$index%
				<tr>
					<td class="evenrowdata"><input type="checkbox" name="selectedListS%value $index%" value="%value oid%">					
					<td>%value oid%</td>
					<td>%value service%</td>
					<td>%value description%</td>
					<td>
						<font color="red">
						%ifvar target equals('$all')%
							All cluster nodes
						%else%
							%ifvar target equals('$any')%
								Any cluster node
							%else%
								%value target%
							%endifvar%
						%endifvar%
						</font>
					</td>
					<td>
						%ifvar schedState equals('expired')%
							Expired
						%else%
							%ifvar execState equals('suspended')%
								<font color="red">Suspended</font>
							%else%
								<img src="/WmRoot/images/green_check.gif" border=0>
								%ifvar execState equals('running')%
									Running
								%else%
									Active
								%endif%
							%endif%
						%endif%
					</td>
				</tr>
			%endloop%
			%else%
			<tr><td colspan=6>No schedules are currently registered.</td></tr>
      %endif%
		</table>
		
		<table><tr><td class="space" colspan="9">&nbsp;</td></tr></table>
		
		<table class="tableView" width=100%>
        <tr><td class="heading" colspan=6>Complex Repeating Tasks</td></tr>
        <tr class="subheading2">
					<td>Select <a href="javascript:allCheckedC()">All</a></td>
          <td>ID</td>
					<td>Service</td>
					<td>Description</td>
					<td>Target</td>
					<td>Status</td>
        </tr>
				%ifvar -notempty extTasks%
        %loop extTasks -$index%
				<tr>
					<td class="evenrowdata"><input type="checkbox" name="selectedListC%value $index%" value="%value oid%">
					<td>%value oid%</td>
					<td>%value service%</td>
					<td>%value description%</td>
					<td>
						<font color="red">
						%ifvar target equals('$all')%
							All cluster nodes
						%else%
							%ifvar target equals('$any')%
								Any cluster node
							%else%
								%value target%
							%endifvar%
						%endifvar%
						</font>
					</td>
					<td>
						%ifvar schedState equals('expired')%
							Expired
						%else%
							%ifvar execState equals('suspended')%
								<font color="red">Suspended</font>
							%else%
								<img src="/WmRoot/images/green_check.gif" border=0>
								%ifvar execState equals('running')%
									Running
								%else%
									Active
								%endif%
							%endif%
						%endif%
					</td>
				</tr>
			%endloop%
			%else%
			<tr><td colspan=6>No schedules are currently registered.</td></tr>
      %endif%
		</table>
   </form>   
</body>
</html>

%endinvoke%