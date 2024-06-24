%invoke JSocketAdapter.ADMIN:adminBusinessName%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, pname, action){
				var frm = document.pform;
				frm.todo.value = todo;
				frm.action = action;
				
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
					var businessName = frm.name.value;
					var len = businessName.length;
					
					if (len != 4) {
						alert("입력한 Business Name의 길이는 " + len + " 입니다.\nBusiness Name의 길이는 4 이어야만 합니다.");
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
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		<form name="pform" action="" method="post" target="_self">
		<table width="100%">
			<tr>
				<td class="menusection-Settings">
					JSocketAdapter Package Home &gt;
					Basic Info &gt;
					Business Name
				</td>
			</tr>
		</table>
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="usevalue" value="">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		<input type="hidden" name="name" value="">		
		<ul>
			<li><a href="javascript:doAction('create', '', 'basic-businessname-c.dsp')">Create New Business Name</a></li>	
		</ul>
		<table class="tableForm" width="100%">	
			<tr>
				<td class="heading" colspan=9>Business Name Information</td>
			</tr>
			<tr>
				<td class="oddcol">Enabled</td>
				<td class="oddcol">Business Name</td>
				<td class="oddcol">Provider System Name</td>
				<td class="oddcol">Asynch Online Socket YN</td>
				<td class="oddcol">Receive DataQ Name</td>
				<td class="oddcol">Receive DataQ KeyLength</td>
				<td class="oddcol">Description</td>
				<td class="oddcol">Edit</td>
				<td class="oddcol">Delete</td>
			</tr>
			%ifvar -notempty BusinessNameConfig/Items%
				%loop BusinessNameConfig/Items%
					<tr class="evenrowdata-l">
						<td align="CENTER" width="60">
							%ifvar enabled equals('enabled')%
								<img src="%value ../../designPath%images/enabled.gif" alt="enabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('usingYes', '%value name%', 'basic-businessname-l.dsp')">Yes</a>
							%else%
								<img src="%value ../../designPath%images/close.gif" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('usingNo', '%value name%', 'basic-businessname-l.dsp')">No</a>
							%endifvar%
						</td>
						<td><a href="basic-businessname-r.dsp?businessName=%value name%&systemName=%value systemName%">%value name%</a></td>
						<td>%value systemName%</td>
						<td>%value online%</td>
						<td>%value qName%</td>
						<td>%value keyLength%</td>
						<td>%value description%</td>
						<td align="CENTER" width="50">
							<a href="javascript:doAction('read', '%value name%', 'basic-businessname-u.dsp')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
						</td>
						<td align="CENTER" width="50">
							<a href="javascript:doAction('delete', '%value name%', 'basic-businessname-l.dsp')"><img src="%value ../../designPath%icons/delete.gif" alt="Delete" border="0"></a>
						</td>
					</tr>
				%endloop%
			%else%
				<tr><td class="evenrow-l" colspan=9>No business names are currently registered.</td></tr>
			%endifvar%
		</table>
		</form>
	</body>
</html>

%endinvoke%