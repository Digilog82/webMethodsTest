%invoke JSocketAdapter.ADMIN:adminSwitchingSchedule%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, pname){
				var frm = document.pform;
				frm.todo.value = todo;
				
				if(pname != '') {
					frm.soid.value = pname;
				}
				
				if(todo == 'delete'){
					if(confirm("Do you really want to delete config of  " + pname)){
						frm.submit();
					}
				} else if (todo == 'add' || todo == 'update') {
					var switchingType = frm.switching.value;
					var businessName = frm.businessName.value;
					
					if (switchingType == "disableAndEnable" && businessName != "") {
						alert("Switching Type이 'Socket Operation Switching'일 경우\nBusiness Name은 'ALL'을 선택해야 합니다.");
						return;
					}
					
					if (businessName == "") {
						businessName = "All";
					}
					
					if (switchingType == "enable") {
						frm.description.value = businessName + " Business Enable";
					} else if (switchingType == "disable") {
						frm.description.value = businessName + " Business Disable";
					} else {
						frm.description.value = frm.systemName.value + " Socket Operation Switching";
					}
					
					frm.submit();
				} else {
					frm.submit();
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
		
		<div class="message">JSocketAdapter Package Home > %value systemName% Online > Switch Socket Operation  메뉴에서 수행하는 기능(Enable/Disable/Switching)에 대해서 Scheduler에 등록, 관리하는 메뉴입니다.</div>
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">
		<table width="100%">
			<tr>
				%ifvar todo equals('create')%
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						%value systemName% Online Client &gt;
						Switching Schedule &gt;
						Create Switching Schedule
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							%value systemName% Online Client &gt;
							Switching Schedule &gt;
							Edit Switching Schedule
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							%value systemName% Online Client &gt;
							Switching Schedule
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="systemName" value="%value systemName%">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		
		%ifvar todo -notempty%
			<ul class="listitems">
				<li class="listitem"><a href="asynchon-switchingschedule.dsp?systemName=%value systemName%">Return to Switching Schedule Information</a></li>
			</ul>
		%else%
			<input type="hidden" name="soid" value="">		
				<ul class="listitems">
					<li class="listitem"><a href="javascript:doAction('create', '')">Create New Switching Schedule</a></li>	
				</ul>
		%endifvar%
		
		<table class="tableForm" width="100%">	
			%ifvar todo equals('create')%
				<tr>
					<td class="heading" colspan="2">%value systemName% Switching Schedule Properties</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Provider System Name</td>
					<td class="evenrow-l" width="70%">%value systemName%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Business Name</td>
					<td class="evenrow-l" width="70%">
						<select name="businessName" style="width:90">
							<option value="">ALL</option>
							%loop onlineBusinessNameList%
								<option value="%value onlineBusinessNameList%">%value onlineBusinessNameList%</option>
							%endloop%
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Switching Type</td>
					<td class="evenrow-l" width="70%">
						<select name="switching" style="width:190">
							<option value="enable">Business Enable</option>
							<option value="disable">Business Disable</option>
							%ifvar serverDuplexing matches('true')%
							<option value="disableAndEnable">Socket Operation Switching</option>
							%endifvar%
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Target Node</td>
					<td class="evenrow-l" width="70%">
						<select name="target" style="width:190">
							%loop targetNodeList%
								<option value="%value logicalServerName%">%value logicalServerName%</option>
							%endloop%
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Start Date</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="sDate" value="" style="font-size:10pt;width:100"> YYYY/MM/DD
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Start Time</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="sTime" value="" style="font-size:10pt;width:100"> HH:MM:SS
						<input type="hidden" name="description" value="">
					</td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Create Schedule"  onclick="return doAction('add', '')"></input>
					</td>
				</tr>
			%else%
				%ifvar todo equals('read')%
					<tr>
						<td class="heading" colspan="2">%value systemName% Switching Schedule Properties</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Provider System Name</td>
						<td class="evenrow-l" width="70%">%value systemName%</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Business Name</td>
						<td class="evenrow-l" width="70%">
							<select name="businessName" style="width:90">
								<option value="">ALL</option>
								%loop onlineBusinessNameList%
									<option value="%value onlineBusinessNameList%">%value onlineBusinessNameList%</option>
								%endloop%
							</select>
							<script language="javascript">
								document.pform.businessName.value = "%value businessName%";
							</script>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Switching Type</td>
						<td class="evenrow-l" width="70%">
							<select name="switching" style="width:190">
								<option value="enable">Business Enable</option>
								<option value="disable">Business Disable</option>
								%ifvar serverDuplexing matches('true')%
								<option value="disableAndEnable">Socket Operation Switching</option>
								%endifvar%
							</select>
							<script language="javascript">
								document.pform.switching.value = "%value switching%";
							</script>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Target Node</td>
						<td class="evenrow-l" width="70%">
							<select name="target" style="width:190">
								%loop targetNodeList%
									<option value="%value logicalServerName%">%value logicalServerName%</option>
								%endloop%
							</select>
							<script language="javascript">
								document.pform.target.value = "%value target%";
							</script>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Start Date</td>
						<td class="evenrow-l" width="70%">
							<input type="text" name="sDate" value="%value sDate%" style="font-size:10pt;width:100"> YYYY/MM/DD
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Start Time</td>
						<td class="evenrow-l" width="70%">
							<input type="text" name="sTime" value="%value sTime%" style="font-size:10pt;width:100"> HH:MM:SS
							<input type="hidden" name="description" value="">
							<input type="hidden" name="soid" value="%value soid%">
						</td>
					</tr>
					<tr>
						<td class="action" colspan="2">
							<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>
						</td>
					</tr>
				%else%
					<tr>
						<td class="heading" colspan=8>%value systemName% Switching Schedule Information</td>
					</tr>
					<tr class="subheading2">						
						<td>Description</td>
						<td>Target</td>
						<td>Run Time</td>
						<td>Status</td>
						<td>Business Name</td>
						<td>Switching Type</td>
						<td>Edit</td>
						<td>Delete</td>
					</tr>
					%ifvar -notempty onceTasks%
						%loop onceTasks%
							<tr>
								<td>%value description%</td>								
								<td>%value target%</td>
								<td>%value date% %value time%</td>
								<td>
									%ifvar scheStatus equals('Active')%
										<img src="%value ../designPath%images/green_check.png" border=0>%value scheStatus%
									%else%
										<font color="red">%value scheStatus%</font>
									%endifvar%
								</td>
								<td>%value inputs/businessName%</td>
								<td>
									%ifvar inputs/switching equals('enable')%
										Business Enable
									%else%
										%ifvar inputs/switching equals('disable')%
											Business Disable
										%else%
											Socket Operation Switching
										%endifvar%
									%endifvar%
								</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('read', '%value oid%')"><img src="%value ../designPath%icons/copy.gif" alt="Edit" border="0"></a>
								</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value oid%')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan="8">No schedules are currently registered.</td></tr>
					%endifvar%
				%endifvar%
			%endifvar%		
		</table>
		</form>		
	</body>
</html>

%endinvoke%