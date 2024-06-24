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
		<form name="pform" method="post" target="_self">
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					Basic Info &gt;
					Business Name &gt;
					Read Business Name
				</td>
			</tr>
		</table>
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="oldName" value="%value name%">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		<ul>
			<li><a href="basic-businessname-l.dsp">Return to Business Name Information</a></li>
		</ul>
		<table class="tableForm" width="100%">	
			<tr>
				<td class="heading" colspan="2">Business Name Properties</td>
			</tr>
			<tr>
				<tr>
					<td class="evenrowdata-r" width="30%">Enabled</td>
					<td class="evenrowdata-l" width="70%">
						%ifvar enabled equals('enabled')%
							Enabled
						%else%
							Disabled
						%endifvar%
						<input type="hidden" name="enabled" value="%value enabled%">
					</td>
				</tr>
				<tr>
					<td class="oddrowdata-r" width="30%">Business Name</td>
					<td class="oddrowdata-l" width="70%">%value name%</td>
				</tr>
				<tr>
					<td class="evenrowdata-r" width="30%">Provider System Name</td>
					<td class="evenrowdata-l" width="70%">%value systemName%</td>
				</tr>
				<tr>
					<td class="oddrowdata-r" width="30%">Asynch Online Socket YN</td>
					<td class="oddrowdata-l" width="70%">%value online%</td>
				</tr>
				<tr>
					<td class="evenrowdata-r" width="30%">Receive Data Q Name</td>
					<td class="evenrowdata-l" width="70%">%value qName%</td>
				</tr>
				<tr>
					<td class="oddrowdata-r" width="30%">Receive Data Q Key Length</td>
					<td class="oddrowdata-l" width="70%">%value keyLength%</td>
				</tr>
				<tr>
					<td class="evenrowdata-r" width="30%">Description</td>
					<td class="evenrowdata-l" width="70%">%value description%</td>
				</tr>
			</tr>
		</table>
		</form>
	</body>
</html>

%endinvoke%