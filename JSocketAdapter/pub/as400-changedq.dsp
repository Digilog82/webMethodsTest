%invoke JSocketAdapter.ADMIN:adminChangeDataQueue%

<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		<title>Change Data Q Name</title>
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(aTodo) {
				if (aTodo == 'search') {
					document.pform.dqchange.value = "search";
					document.pform.submit();
				} else if (aTodo == 'reserve') { // Listener Data Queue Name 변경을 예약시간에 수행하도록 함.					
					var businessName = document.pform.businessName.value;
					var fromQueue = document.pform.fromQueue.value;
					var toQueue = document.pform.toQueue.value;
					var receiveQueue = document.pform.receiveQueue.value;
					var sDate = document.pform.sDate.value;
					var sTime = document.pform.sTime.value;
					
					if (businessName == "ALL") {
						alert("Business Name을 선택하십시요.");
						return;
					}
					
					if (fromQueue == "") {
						alert("Before Send Data Queue Name을 입력하십시요.");
						return;
					}
					
					if (toQueue == "") {
						alert("After Send Data Queue Name을 입력하십시요.");
						return;
					}
					
					if (receiveQueue == "") {
						alert("After Receive Data Queue Name을 입력하십시요.");
						return;
					}
					
					if (sDate == "") {
						alert("예약 날짜를 입력하십시요.");
						return;
					}
					
					if (sTime == "") {
						alert("예약 시간을 입력하십시요.");
						return;
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
						alert("변경할 Listener Node Name을 선택하십시요.");
						return;
					}
					
					document.pform.dqchange.value = "reserve";
					document.pform.submit();
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

		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%

		<form name="pform" method="post" target="_self">
			<input type="hidden" name="dqchange" value="">
			<input type="hidden" name="selectedList" value="">
			<input type="hidden" name="checkMode" value="uncheck">
			<input type="hidden" name="alertMsg" value="%value alertMsg%">
			
			%loop businessNameList%		
				<input type="hidden" name="%value systemName%" value="%value businessName%">			
			%endloop%
		
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					AS/400 &gt;
					Change Data Queue
				</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Data Q Name Change</td>
			</tr>
			<tr>
				<tr>
					<td class="evenrow" width="30%">Provider System Name</td>
					<td class="evenrow-l" width="70%">
						<select name="systemName" style="width:100" onchange="makeBusinessName(this.value)">
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
						<select name="businessName" style="width:100">
							<option value="ALL">ALL</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Before Send Data Queue Name</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="fromQueue" size="5" style="font-size:10pt;width:100">
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">After Send Data Queue Name</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="toQueue" size="5" style="font-size:10pt;width:100">
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">After Receive Data Queue Name</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="receiveQueue" size="5" style="font-size:10pt;width:100">
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
						<input type="button" name="SUBMIT" value="Search Listener"  onclick="return doAction('search')"></input>&nbsp;&nbsp;
						<input type="button" name="SUBMIT" value="Reserve Change"  onclick="return doAction('reserve')"></input>
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
						<td class="evenrowdata"><input type="checkbox" name="selectedList%value $index%" value="%value connectionAlias%|%value notificationNodeName%">
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
				<tr><td colspan=8>No listeners are currently listened.</td></tr>
    	%endif%		
    </table>
   </form>      
	</body>
</html>

%endinvoke%