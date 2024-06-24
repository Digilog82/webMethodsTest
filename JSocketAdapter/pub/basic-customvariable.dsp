%invoke JSocketAdapter.ADMIN:adminCustomVariable%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, vname){
				var frm = document.pform;
				frm.todo.value = todo;
				
				if(vname != '') {
					frm.variableName.value = vname;
				}
				
				if(todo == 'delete'){
					if(confirm("Do you really want to delete config of  " + vname)){
						frm.submit();
					}
				} else if (todo == 'add' || todo == 'update') {
					var selectName = frm.selectName.value;
					var variableName = frm.variableName.value;
					var desc = frm.description.value;
					var variableValue = frm.variableValue.value;
					
					// Config XML 파일 저장위치는 수정하지 못하도록 한다.
					if (todo == 'update') {
						if (variableName == "ESB.CONFIG.AS400.CONFIGPATH" || variableName == "ESB.CONFIG.LOCALFILE.CONFIGPATH" || variableName == "ESB.SOCKET.CONFIG.PATH") {
							alert("Variable " + variableName + "에 대한 Value는 수정할 수 없습니다.");
							return;
						}
					}

					if (variableName == "") {
						alert("Variable Name을 입력하십시요.");
						return;
					}
					
					if (selectName == "") { // 직접입력을 선택한 경우
						if (variableName == "ESB.CONFIG.AS400.CLUSTERPATH" || variableName == "ESB.CONFIG.EXCEPT.IP" || variableName == "ESB.CONFIG.OTHER.SERVERNAME" || variableName == "ESB.CONFIG.REMOTE.ALIAS" ||
						    variableName == "ESB.CONFIG.MULTIREMOTE.ALIAS" || variableName == "ESB.SOCKET.ACK.DOCLIST" || variableName == "ESB.SOCKET.ONLINE.SYNCHSERVER" || variableName == "ESB.SOCKET.ONLINE.UMCONALIAS" ||
							variableName == "ESB.CONFIG.GWSERVER.ALIAS" || variableName == "ESB.CONFIG.MASERVER.ALIAS" || variableName == "ESB.CONFIG.ERRORNOTI.EMAIL" || variableName == "ESB.CONFIG.CUSTOMMENU.CUSTOMER" ||
							variableName == "ESB.SOCKET.MAINSVC.COMMSVC" || variableName == "ESB.SOCKET.SYNCHRT.UMCONALIAS" || variableName == "ESB.SOCKET.SCHEMASVC.COMMSVC" || variableName == "ESB.CONFIG.REMOTE.IP" ||
							variableName == "ESB.SOCKET.CONFIG.SHAREPATH" || variableName == "ESB.SOCKET.TRIGGER.CONTSVC" || variableName == "ESB.SOCKET.GWMASEP.RTNPATH" ||
							variableName == "ESB.CONFIG.EMAIL.HOST" || variableName == "ESB.CONFIG.EMAIL.HOSTPORT" || variableName == "ESB.CONFIG.INCHARGE.EMAIL" || variableName == "ESB.SOCKET.MAINSVC.MAINSVC") {
							// Variable Value를 입력하지 않아도 됨.
						} else {
							if (variableValue == "") {
								alert("Variable Value를 입력하십시요.");
								return;
							}
						}
						
						// Variable Name이 선택 리스트 중에 있는지 체크
						for (var i=0; i < frm.selectName.options.length; i++) {
							if (variableName == frm.selectName.options[i].value) {
								alert("Variable Name이 선택 리스트에 존재하고 있습니다.\n직접입력 선택 시 Variable Name은 선택 리스트에\n존재하지 않는 값이어야 합니다.");
								frm.selectName.value = variableName;
								makeValueList(variableName);
								return;
							}
						}
					} else {
						frm.variableValue.value = frm.selectValue.value;
					}
					
					if (desc == "") {
						alert("Description을 입력하십시요.");
						return;
					}
					
					frm.submit();
				} else {
					frm.submit();
				}
			}
			
			function makeValueList(variableName) {
				var selectValue = document.pform.selectValue;
				
				if (variableName == "") { // 직접입력
					document.all.variableValue.style.display="";
					document.all.inputDesc.style.display="";
					document.all.selectValue.style.display="none";
					document.pform.variableName.value = "";
					document.pform.variableValue.value = "";
					document.pform.description.value = "";
				} else {
					for (var i=0; i < document.pform.length; i++) {
						if (document.pform.elements[i].name == variableName) {
							var descValueList = document.pform.elements[i].value;
							var tocken1 = descValueList.split("|");
							var desc = tocken1[0];
							var valueList = tocken1[1];
							var tocken2 = valueList.split("/");
						  
							// 기존의 Option 삭제
							while (selectValue.options.length > 0) {
								selectValue.options.remove(0);
							}
						
							// 해당 Variable Name에 속한 Value를 Option에 추가
							for (var i = 0; i < tocken2.length; i++) {
								selectValue.options[i] = new Option(tocken2[i], tocken2[i]);
							}
						
							break;
						}
					}
					
					document.all.variableValue.style.display="none";
					document.all.inputDesc.style.display="none";
					document.all.selectValue.style.display="";
					document.pform.variableName.value = variableName;
					document.pform.description.value = desc;
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
						Custom Variable &gt;
						Create Custom Variable
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						  Custom Variable &gt;
							Edit Custom Variable
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						  Custom Variable
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="oldVariableName" value="%value variableName%">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		
		%loop variableValueList%		
			<input type="hidden" name="%value variableName%" value="%value descValueList%">			
		%endloop%
			
		%ifvar todo -notempty%
			<ul class="listitems">
				<li class="listitem"><a href="basic-customvariable.dsp">Return to Custom Variable Information</a></li>
			</ul>
		%else%
			<input type="hidden" name="variableName" value="">		
				<ul class="listitems">
					<li class="listitem"><a href="javascript:doAction('create', '')">Create New Custom Variable</a></li>	
				</ul>
		%endifvar%		
		<table class="tableForm" width="100%">	
			%ifvar todo equals('create')%
				<tr>
					<td class="heading" colspan="2">Custom Variable Properties</td>
				</tr>
				<tr>
					<td class="evenrow" width="20%">Variable Name</td>
					<td class="evenrow-l" width="80%">
						<select name="selectName" onchange="makeValueList(this.value)">
							<option value="">직접입력</option>
							%loop variableNameList%
								<option value="%value variableNameList%">%value variableNameList%</option>
							%endloop%
						</select><br>
						<input type="text" name="variableName" size="20" style="font-size:10pt;width:400">
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="20%">Variable Value</td>
					<td class="evenrow-l" width="80%">
						<input type="text" name="variableValue" id="variableValue" size="20" style="font-size:10pt;width:400">
						<div id="inputDesc">여러 개의 Value 입력 필요 시에는 '/' 를 구분자로 해서 입력. 예)abc/def/ghi</div>
						<select name="selectValue" id="selectValue" style="display:none">
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="20%">Description</td>
					<td class="evenrow-l" width="80%"><input type="text" name="description" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Create Custom Variable"  onclick="return doAction('add', '')"></input>
					</td>
				</tr>
			%else%
				%ifvar todo equals('read')%
					<tr>
						<td class="heading" colspan="2">Custom Variable Properties</td>
					</tr>
					<tr>
						<td class="evenrow" width="20%">Variable Name</td>
						<td class="evenrow-l" width="80%">
							<select name="selectName" onchange="makeValueList(this.value)">
								<option value="">직접입력</option>
								%loop variableNameList%
									<option value="%value variableNameList%">%value variableNameList%</option>
								%endloop%
							</select><br>
							<script language="javascript">
								document.pform.selectName.value = "%value selectName%";
							</script>
							<input type="text" name="variableName" value="%value variableName%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="20%">Variable Value</td>
						<td class="evenrow-l" width="80%">
							%ifvar selectValueList -notempty%
								<input type="text" name="variableValue" value="%value variableValue%" id="variableValue" size="20" style="font-size:10pt;width:400;display:none">
								<div id="inputDesc" style="display:none">여러 개의 Value 입력 필요 시에는 '/' 를 구분자로 해서 입력. 예)abc/def/ghi</div>
								<select name="selectValue" id="selectValue">
									%loop selectValueList%
										<option value="%value selectValueList%">%value selectValueList%</option>
									%endloop%
								</select>
								<script language="javascript">
									document.pform.selectValue.value = "%value variableValue%";
								</script>
							%else%
								<input type="text" name="variableValue" value="%value variableValue%" id="variableValue" size="20" style="font-size:10pt;width:400">
								<div id="inputDesc">여러 개의 Value 입력 필요 시에는 '/' 를 구분자로 해서 입력. 예)abc/def/ghi</div>
								<select name="selectValue" id="selectValue" style="display:none">
								</select>
							%endifvar%
							<input type="hidden" name="oldVariableValue" value="%value variableValue%">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="20%">Description</td>
						<td class="evenrow-l" width="80%"><input type="text" name="description" value="%value description%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="action" colspan="2">
							<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>
						</td>
					</tr>
				%else%
					<tr>
						<td class="heading" colspan=5>Custom Variable Information</td>
					</tr>
					<tr class="subheading2">
						<td>Variable Name</td>
						<td>Variable Value</td>
						<td>Description</td>
						<td>Edit</td>
						<td>Delete</td>
					</tr>
					%ifvar -notempty CustomVariableConfig/Items%
						%loop CustomVariableConfig/Items%
							<tr>
								<td>%value variableName%</td>
								<td>%value variableValue%</td>
								<td>%value description%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('read', '%value variableName%')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
								</td>
								<td class="evenrowdata">
									%ifvar canDelete equals('No')%
										<img src="%value ../../designPath%icons/delete_disabled.png" alt="Disable Local Server Socket to Delete" border=0>
									%else%
										<a href="javascript:doAction('delete', '%value variableName%')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
									%endifvar%
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=5>No custom variables are currently registered.</td></tr>
					%endifvar%
				%endifvar%
			%endifvar%
		%endifvar%
		</table>
		</form>
	</body>
</html>
%endinvoke%