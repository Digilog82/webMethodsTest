%invoke JSocketAdapter.ADMIN:adminSystemName%

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
				
				if (pname != '') {
					frm.name.value = pname;
				}
				
				if (todo == 'delete') {
					if(confirm("Do you really want to delete config of  " + pname)){
						frm.submit();
					}
				} else if (todo == 'add' || todo == 'update') {
					var systemNameLenChk = "%value systemNameLengthChk%";
					var systemNameLen = %value systemNameLength%;
					var systemName = frm.name.value;
					var len = systemName.length;
					
					if (systemName.indexOf("_") >= 0) {
						alert("System Name은 언더바( _ )를 포함할 수 없습니다.");
						return;
					}
					
					if (systemNameLenChk == "true" && len != systemNameLen) {
						alert("입력한 System Name의 길이는 " + len + " 입니다.\nSystem Name의 길이는 " + systemNameLen + " 이어야만 합니다.");
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
						System Name &gt;
						Create System Name
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						  System Name &gt;
							Edit System Name
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						  System Name
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="oldName" value="%value name%">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		%ifvar todo -notempty%
			<ul class="listitems">
				<li class="listitem"><a href="basic-systemname.dsp">Return to System Name Information</a></li>
			</ul>
		%else%
			<input type="hidden" name="name" value="">		
				<ul class="listitems">
					<li class="listitem"><a href="javascript:doAction('create', '')">Create New System Name</a></li>	
				</ul>
		%endifvar%
		<table class="tableForm" width="100%">	
			%ifvar todo equals('create')%
				<tr>
					<td class="heading" colspan="2">System Name Properties</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">System Name</td>
					<td class="evenrow-l" width="70%"><input type="text" name="name" size="20" style="font-size:10pt;width:400">
						%ifvar systemNameLengthChk equals('true')%
							&nbsp;(Fixed Length %value systemNameLength%)
						%endifvar%
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Description</td>
					<td class="evenrow-l" width="70%"><input type="text" name="description" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Create System Name"  onclick="return doAction('add', '')"></input>
					</td>
				</tr>
			%else%
				%ifvar todo equals('read')%
					<tr>
						<td class="heading" colspan="2">System Name Properties</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">System Name</td>
						<td class="evenrow-l" width="70%"><input type="text" name="name" value="%value name%" size="20" style="font-size:10pt;width:400">
							%ifvar systemNameLengthChk equals('true')%
								&nbsp;(Fixed Length %value systemNameLength%)
							%endifvar%
						</td>
					</tr>
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
						<td class="heading" colspan=4>System Name Information</td>
					</tr>
					<tr class="subheading2">
						<td>System Name</td>
						<td>Description</td>
						<td>Edit</td>
						<td>Delete</td>
					</tr>
					%ifvar -notempty SystemCodeConfig/Items%
						%loop SystemCodeConfig/Items%
							<tr>
								<td>%value name%</td>
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
						<tr><td colspan=4>No system names are currently registered.</td></tr>
					%endifvar%
				%endifvar%
			%endifvar%
		%endifvar%
		</table>
		</form>
	</body>
</html>

%endinvoke%