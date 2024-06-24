%invoke JSocketAdapter.ADMIN:adminOnlineRemoteServerList%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, sname){
				var frm = document.pform;
				frm.todo.value = todo;
				
				if(sname != '')
					frm.name.value = sname;
					
				if(todo == 'search') {
					frm.submit();
				} else if(todo == 'read') {
					window.open('/JSocketAdapter/asynchonclient-detail.dsp?systemName=' + sname, '', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
				} else if (todo == 'false') {
					frm.submit();
				} else if (todo == 'true') {
					frm.submit();
				} else if (todo == 'enable' || todo == 'disable' || todo == 'disableAndEnable') {
					var enableDisable = "";
					
					if (todo == 'enable') {
						enableDisable = "be enable";
					} else if (todo == 'disable') {
						enableDisable = "be disable";
					} else {
						enableDisable = "switch";
					}
					
					for (var i=0; i < frm.length; i++) {
						if (frm.elements[i].checked) {
							if (frm.selectedList.value == "") {
								frm.selectedList.value = frm.elements[i].value;
							} else {
								frm.selectedList.value = frm.selectedList.value + "|" + frm.elements[i].value;
							}
						}
					}
					
					if (frm.selectedList.value == "") {
						if(confirm("Do you really want to " + enableDisable + " below all online remote server sockets?")) {
							for (var i=0; i < frm.length; i++) {
								var eleName = frm.elements[i].name;
								var nameIndex = eleName.indexOf("selectedList");
								
								if (nameIndex >= 0) {
									if (frm.selectedList.value == "") {
										frm.selectedList.value = frm.elements[i].value;
									} else {
										frm.selectedList.value = frm.selectedList.value + "|" + frm.elements[i].value;
									}
								}
							}
							
							frm.submit();
						}
					} else {
						frm.submit();
					}
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
			
			var seq = 1;
		</script>
	</head>
	<body onload="javascript:alertMsg()">
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					Online Client &gt;
					Online Client List
				</td>
			</tr>
		</table>
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="name" value="">
		<input type="hidden" name="checkMode" value="uncheck">
		<input type="hidden" name="selectedList" value="">
		<input type="hidden" name="deleteFirstConnFile" value="true">
		<input type="hidden" name="connectOrderer" value="Administrator">
		<input type="hidden" name="alertMsg" value="%value alertMessage%">
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Search Properties</td>
			</tr>
			
			<!-- 현대제철 냉연공장 전용 -->
			%ifvar customerCode equals('HCC')%
			<tr>
				<td class="evenrow" width="30%">Plant</td>
				<td class="evenrow-l" width="70%">
					<select name="searchPlantCode" style="width:300">
						<option value="">ALL</option>
						%loop PlantCodeDescList%
							<option value="%value codeValue%">%value codeDisplay%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.searchPlantCode.value = "%value searchPlantCode%";
					</script>
				</td>
			</tr>
			%endifvar%
			<!-- 현대제철 냉연공장 전용 -->
			
			<tr>
				<td class="evenrow" width="30%">Target System Name</td>
				<td class="evenrow-l" width="70%">
					<select name="searchSystemName" style="width:300">
						<option value="">ALL</option>
						%loop OnlineSystemNameList%
							<option value="%value systemNameValue%">%value systemNameDisplay%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.searchSystemName.value = "%value searchSystemName%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Socket Name</td>
				<td class="evenrow-l" width="70%">
					<select name="searchSocketName" style="width:300">
						<option value="">ALL</option>
						%loop OnlineSocketNameList%
							<option value="%value socketNameValue%">%value socketNameDisplay%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.searchSocketName.value = "%value searchSocketName%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Connection Status</td>
				<td class="evenrow-l" width="70%">
					<select name="searchConnStatus" style="width:300">
						<option value="">ALL</option>
						<option value="true">Connected</option>
						<option value="false">Closed</option>
					</select>
					<script language="javascript">
						document.pform.searchConnStatus.value = "%value searchConnStatus%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="action" colspan="2">
					<input type="button" name="SUBMIT" value="Search"  onclick="return doAction('search', '')"></input>
				</td>
			</tr>
		</table>

		<table class="tableForm" width="100%">	
			<tr>
				<td class="action" colspan=12>
					<input type="button" name="SUBMIT" value="Business Enable"  onclick="return doAction('enable', '')"></input>&nbsp;&nbsp;
					<input type="button" name="SUBMIT" value="Business Disable"  onclick="return doAction('disable', '')"></input>&nbsp;&nbsp;
					%ifvar remoteAlias -notempty%
						&nbsp;&nbsp;<input type="button" name="SUBMIT" value="Socket Operation Switching"  onclick="return doAction('disableAndEnable', '')"></input>
						&nbsp;&nbsp;<font color="black">Switching Target Server</font>&nbsp;&nbsp;
						<select name="targetRemoteAlias">
							%loop multiClusterAliasList%
								<option value="%value multiClusterAliasList%">%value multiClusterAliasList%</option>
							%endloop%
						</select>
					%endifvar%
				</td>
			</tr>
			<tr>
				<td class="heading" colspan="12">Online Client Socket Information</td>
			</tr>
			<tr class="subheading2">				
				<td>Target System Name</td>
				<td>Select <a href="javascript:allChecked()">All</a></td>
				<td>Business Name</td>
				<td>Seq</td>
				<!-- 현대제철 냉연공장 전용 -->
				%ifvar customerCode equals('HCC')%
				<td>Plant</td>
				%endifvar%
				<!-- 현대제철 냉연공장 전용 -->
				<td>Socket Name</td>				
				<td>Description</td>
				<td>IP</td>
				<td>Port Number</td>
				<td>Connction Status</td>
				<td>Alive Status</td>
				<td>To Do</td>
			</tr>
			%ifvar OnlineClientSystemInfoList -notempty%
				%loop OnlineClientSystemInfoList%
					<tr>
						<td rowspan="%value systemCount%"><a href="javascript:doAction('read', '%value systemName%')">%value systemName%</a></td>
						%loop OnlineClientSocketInfoList -$index%
							%ifvar $index equals('0')%
							%else%
								<tr>
							%endifvar%
								<td class="evenrowdata" rowspan="%value clientCount%"><input type="checkbox" name="selectedList%value indexNum%" value="%value systemName%/%value businessName%"></td>
								<td rowspan="%value clientCount%">%value businessName%</td>
							%loop ClientPortInfoList -$index%
								%ifvar $index equals('0')%
								%else%
									<tr>
								%endifvar%
									<td class="evenrowdata">
										<script language="javascript">
											document.write(seq);
											seq++;
										</script>
									</td>
									<!-- 현대제철 냉연공장 전용 -->
									%ifvar ../../../customerCode equals('HCC')%
									<td class="evenrowdata">%value plantCode%</td>
									%endifvar%
									<!-- 현대제철 냉연공장 전용 -->
									<td>%value name%</td>
									<td>%value description%</td>
									<td>%value ip%</td>
									<td>%value port%</td>
									<td class="evenrowdata">
										%ifvar connection equals('true')%
											<img src="%value ../../../designPath%images/enable_icon_16.png" alt="connected" border="0">
										%else%
											<img src="%value ../../../designPath%images/disable_icon_16.png" alt="disconnected" border="0">
										%endifvar%
									</td>
									<td class="evenrowdata">
										%ifvar alive equals('true')%
											<img src="%value ../../../designPath%images/enable_icon_16.png" alt="enabled" border="0">
										%else%
											<img src="%value ../../../designPath%images/disable_icon_16.png" alt="closed" border="0">
										%endifvar%
									</td>
									<td class="evenrowdata">
										%ifvar connection equals('true')%
											<a href="javascript:doAction('false', '%value name%')" onclick="return confirm('Are you sure you want to close connection?');">Close</a>
										%else%
											<a href="javascript:doAction('true', '%value name%')" onclick="return confirm('Are you sure you want to enable connection?');">Connect</a>
										%endifvar%
									</td>								
								</tr>
							%endloop%
							</tr>
						%endloop%
					</tr>
				%endloop%
			%else%
				<tr><td colspan="12">No online remote server ports are currently registered.</td></tr>
			%endifvar%
		</table>
		</form>
	</body>
</html>

%endinvoke%