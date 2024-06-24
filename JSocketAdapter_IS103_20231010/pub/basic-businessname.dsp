%invoke JSocketAdapter.ADMIN:adminBusinessName%

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
					frm.name.value = pname;
				}
				
				if(todo == 'delete'){
					if(confirm("Do you really want to delete config of  " + pname)){
						frm.submit();
					}
				} else if (todo == 'usingYes'){
					frm.todo.value = 'using';
					frm.usevalue.value = 'Yes';
					frm.submit();
				} else if (todo == 'usingNo'){
					frm.todo.value = 'using';
					frm.usevalue.value = 'No';
					frm.submit();
				} else if (todo == 'add' || todo == 'update') {
					var businessNameLenChk = "%value businessNameLengthChk%";
					var businessNameLen = %value businessNameLength%;
					var businessName = frm.name.value;
					var len = businessName.length;
					
					if (businessName.indexOf("_") >= 0) {
						alert("Business Name은 언더바( _ )를 포함할 수 없습니다.");
						return;
					}
					
					if (businessNameLenChk == "true" && len != businessNameLen) {
						alert("입력한 Business Name의 길이는 " + len + " 입니다.\nBusiness Name의 길이는 " + businessNameLen + " 이어야만 합니다.");
						return;
					} else {
						frm.submit();
					}
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
		
		%ifvar changed equals('true')%
			<form name="dform" method="post">
				<input type="hidden" name="alertMsg" value="%value alertMsg%">
			</form>
			<script langauge='javascript'>
				document.dform.submit();
			</script>
		%endifvar%
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		<form name="pform" method="post" target="_self">
		<table width="100%">
			<tr>
				%ifvar todo equals('create')%
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Basic Info &gt;
						Business Name &gt;
						Create Business Name
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						  Business Name &gt;
							Edit Business Name
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						  Business Name
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="oldName" value="%value name%">
		<input type="hidden" name="usevalue" value="">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		%ifvar todo -notempty%
			<ul class="listitems">
				<li class="listitem"><a href="basic-businessname.dsp">Return to Business Name Information</a></li>
			</ul>
		%else%
			<input type="hidden" name="name" value="">		
				<ul class="listitems">
					<li class="listitem"><a href="javascript:doAction('create', '')">Create New Business Name</a></li>	
				</ul>
		%endifvar%
		<table class="tableForm" width="100%">
			%ifvar todo equals('create')%
				<tr>
					<td class="heading" colspan="2">Business Name Properties</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Enabled</td>
					<td class="evenrow-l" width="70%">
						<select name="enabled" style="width:90">
							<option value="enabled">Enabled</option>
							<option value="disabled">Disabled</option>								
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Business Name</td>
					<td class="evenrow-l" width="70%"><input type="text" name="name" size="20" style="font-size:10pt;width:400">
						%ifvar businessNameLengthChk equals('true')%
							&nbsp;(Fixed Length %value businessNameLength%)
						%endifvar%
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Provider System Name</td>
					<td class="evenrow-l" width="70%">
						<select name="systemName" style="width:90">
							%loop systemNameList%
								<option value="%value systemNameList%">%value systemNameList%</option>
							%endloop%
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Asynch Online Socket YN</td>
					<td class="evenrow-l" width="70%">
						<select name="online" style="width:90">
							<option value="No">No</option>
							<option value="Yes">Yes</option>								
						</select>
					</td>
				</tr>
				<!--
				<tr>
					<td class="evenrow" width="30%">Connection on IS Startup</td>
					<td class="evenrow-l" width="70%">
						<select name="startupConnection" style="width:90">
							<option value="No">No</option>
							<option value="Yes">Yes</option>								
						</select>
					</td>
				</tr>
				-->
				%ifvar as400dqYN equals('true')%
				<tr>
					<td class="evenrow" width="30%">Receive Data Q Name</td>
					<td class="evenrow-l" width="70%"><input type="text" name="qName" size="20" style="font-size:10pt;width:400">&nbsp;(AS400 System Business)</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Receive Data Q Key Length</td>
					<td class="evenrow-l" width="70%"><input type="text" name="keyLength" size="20" style="font-size:10pt;width:400">&nbsp;(bytes)&nbsp;(AS400 System Business)</td>
				</tr>
				%endifvar%
				<tr>
					<td class="evenrow" width="30%">Description</td>
					<td class="evenrow-l" width="70%"><input type="text" name="description" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Create Business Name"  onclick="return doAction('add', '')"></input>
					</td>
				</tr>
			%else%
				%ifvar todo equals('read')%
					<tr>
						<td class="heading" colspan="2">Business Name Properties</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Enabled</td>
						<td class="evenrow-l" width="70%">
							%ifvar enabled equals('enabled')%
								Enabled
							%else%
								Disabled
							%endifvar%
							<input type="hidden" name="enabled" value="%value enabled%">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Business Name</td>
						<td class="evenrow-l" width="70%"><input type="text" name="name" value="%value name%" size="20" style="font-size:10pt;width:400">
							%ifvar businessNameLengthChk equals('true')%
								&nbsp;(Fixed Length %value businessNameLength%)
							%endifvar%
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Provider System Name</td>
						<td class="evenrow-l" width="70%">
							<select name="systemName" style="width:90">
								%loop systemNameList%
									<option value="%value systemNameList%">%value systemNameList%</option>
								%endloop%
							</select>
							<script language="javascript">
								document.pform.systemName.value = "%value systemName%";
							</script>
							<input type="hidden" name="oldSystemName" value="%value systemName%">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Asynch Online Socket YN</td>
						<td class="evenrow-l" width="70%">
							<select name="online" style="width:90">
								<option value="No">No</option>
								<option value="Yes">Yes</option>								
							</select>
							<script language="javascript">
								document.pform.online.value = "%value online%";
							</script>
							<input type="hidden" name="oldOnline" value="%value online%">
						</td>
					</tr>
					<!--
					<tr>
						<td class="evenrow" width="30%">Connection on IS Startup</td>
						<td class="evenrow-l" width="70%">
							<select name="startupConnection" style="width:90">
								<option value="No">No</option>
								<option value="Yes">Yes</option>								
							</select>
							<script language="javascript">
								document.pform.startupConnection.value = "%value startupConnection%";
							</script>
						</td>
					</tr>
					-->
					%ifvar as400dqYN equals('true')%
					<tr>
						<td class="evenrow" width="30%">Receive Data Q Name</td>
						<td class="evenrow-l" width="70%"><input type="text" name="qName" value="%value qName%" size="20" style="font-size:10pt;width:400">&nbsp;(AS400 System Business)</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Receive Data Q Key Length</td>
						<td class="evenrow-l" width="70%"><input type="text" name="keyLength" value="%value keyLength%" size="20" style="font-size:10pt;width:400">&nbsp;(bytes)&nbsp;(AS400 System Business)</td>
					</tr>
					%endifvar%
					<tr>
						<td class="evenrow" width="30%">Description</td>
						<td class="evenrow-l" width="70%"><input type="text" name="description" value="%value description%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="action" colspan="2">
							<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>
						</td>
					</tr>
				%else%
					<tr>
						<td class="heading" colspan=7>Business Name Information</td>
					</tr>
					<tr class="subheading2">
						<td>Enabled</td>
						<td>Business Name</td>
						<td>Provider System Name</td>
						<td>Asynch Online Socket YN</td>
						<td>Description</td>
						<td>Edit</td>
						<td>Delete</td>
					</tr>
					%ifvar -notempty BusinessNameConfig/Items%
						%loop BusinessNameConfig/Items%
							<tr>
								<td class="evenrowdata">
									%ifvar enabled equals('enabled')%
										<img src="%value ../../designPath%images/enabled.gif" alt="enabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('usingYes', '%value name%')">Yes</a>
									%else%
										<img src="%value ../../designPath%images/close.gif" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('usingNo', '%value name%')">No</a>
									%endifvar%
								</td>
								<!-- 2022.08.17 수정. Business Doc 사용 안함으로 Link 해제
								<td><a href="basic-businessif.dsp?businessName=%value name%&systemName=%value systemName%">%value name%</a></td>
								-->
								<td>%value name%</td>
								<td>%value systemName%</td>
								<td>%value online%</td>
								<td>%value description%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('read', '%value name%')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
								</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value name%')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=7>No business names are currently registered.</td></tr>
					%endifvar%
				%endifvar%
			%endifvar%
		%endifvar%
		</table>
		</form>
	</body>
</html>

%endinvoke%