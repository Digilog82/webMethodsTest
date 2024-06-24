%invoke JSocketAdapter.ADMIN:adminCustomVariableValue%

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
					var variableName = frm.variableName.value;
					var desc = frm.description.value;
					var variableValue = frm.variableValue;
					var valueLength = variableValue.options.length;
					
					if (variableName == "") {
						alert("Variable Name을 입력하십시요.");
						return;
					}
					
					if (desc == "") {
						alert("Description을 입력하십시요.");
						return;
					} else {
						if (desc.indexOf('\|') >= 0) {
							alert("Description에 '\|' 를 사용할 수 없습니다.");
							return;
						}
					}
					
					if (valueLength < 2) {
						alert("Variable Value는 두 개 이상 입력해야 합니다.");
						return;
					}
					
					// Variable Value List 전체를 선택한 것으로 처리
					for (var i=0; i < valueLength; i++) {
						variableValue.options[i].selected = true;
					}
					
					frm.submit();
				} else {
					frm.submit();
				}
			}
			
			function addValue() {
				var variableValue = document.pform.variableValue;
				var tempValue = document.pform.tempValue.value;
				var tempDesc = document.pform.tempDesc.value;
				
				if (tempValue == "") {
					alert("Variable Value를 입력하십시요.");
					return;
				} else {
					if (tempValue.indexOf('\|') >= 0) {
						alert("Variable Value에 '\|' 를 사용할 수 없습니다.");
						return;
					}
					
					if (tempValue.indexOf('\/') >= 0) {
						alert("Variable Value에 '\/' 를 사용할 수 없습니다.");
						return;
					}
				}
				
				if (tempDesc == "") {
					alert("Variable Value에 대한 Description을 입력하십시요.");
					return;
				}
				
				// Variable Value 중복 체크
				var valueLength = variableValue.options.length;
				for (var i=0; i < valueLength; i++) {
					var varValueDesc = variableValue.options[i].value;
					var varValue = varValueDesc.split("/")[0];
					
					if (tempValue == varValue) {
						alert("Variable Value " + tempValue + "는 이미 추가되어 있습니다.");
						document.pform.tempValue.value = "";
						document.pform.tempDesc.value = "";
						return;
					}
				}
				
				variableValue.options[valueLength] = new Option(tempValue + "/" + tempDesc, tempValue + "/" + tempDesc);
				document.pform.tempValue.value = "";
				document.pform.tempDesc.value = "";
			}
			
			function deleteValue() {
				var variableValue = document.pform.variableValue;
				var valueLength = variableValue.options.length;
				
				var optionIndex = 0;
				var newValueLength;
				var selectYN = "false";
				
				for (var i = 0; i < valueLength; i++) {
					if (variableValue.options[optionIndex].selected) {
						document.pform.tempValue.value = "";
						document.pform.tempDesc.value = "";
						variableValue.options.remove(optionIndex);
						selectYN = "true";
					} else {
						optionIndex++;
					}
					
					newValueLength = variableValue.options.length;
					
					if (optionIndex > (newValueLength-1)) {
						break;
					}
				}
				
				if (selectYN == "false") {
					alert("삭제할 Variable Value를 선택하십시요.");
					return;
				}
			}
			
			function updateVariableValue() {
				var variableValue = document.pform.variableValue;
				var valueLength = variableValue.options.length;
				var tempValue = document.pform.tempValue.value;
				var tempDesc = document.pform.tempDesc.value;
				var optionIndex = 0;
				var selectYN = "false";
				
				if (tempValue == "") {
					alert("Variable Value를 입력하십시요.");
					return;
				} else {
					if (tempValue.indexOf('\|') >= 0) {
						alert("Variable Value에 '\|' 를 사용할 수 없습니다.");
						return;
					}
					
					if (tempValue.indexOf('\/') >= 0) {
						alert("Variable Value에 '\/' 를 사용할 수 없습니다.");
						return;
					}
				}
				
				if (tempDesc == "") {
					alert("Variable Value에 대한 Description을 입력하십시요.");
					return;
				}
				
				// Variable Value 중복 체크
				for (var i=0; i < valueLength; i++) {
					if (variableValue.options[i].selected) {
						// 수정하기 위해서 선택한 Option인 경우에는 Skip
					} else {
						var varValueDesc = variableValue.options[i].value;
						var varValue = varValueDesc.split("/")[0];
						
						if (tempValue == varValue) {
							alert("Variable Value " + tempValue + "는 이미 추가되어 있습니다.");
							document.pform.tempValue.value = "";
							document.pform.tempDesc.value = "";
							return;
						}
					}
				}
								
				for (var i = 0; i < valueLength; i++) {
					if (variableValue.options[optionIndex].selected) {
						variableValue.options[optionIndex] = new Option(tempValue + "/" + tempDesc, tempValue + "/" + tempDesc);
						selectYN = "true";
						break;
					} else {
						optionIndex++;
					}
				}
				
				if (selectYN == "false") {
					alert("수정할 Variable Value를 먼저 선택하십시요.");
					return;
				}
				
				document.pform.tempValue.value = "";
				document.pform.tempDesc.value = "";
			}
			
			function setUpdateVariableValue(vValue) {
				var varValue = vValue.split("/");
				document.pform.tempValue.value = varValue[0];
				document.pform.tempDesc.value = varValue[1];
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
						Custom Variable Value &gt;
						Create Custom Variable Value
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						  Custom Variable Value &gt;
							Edit Custom Variable Value
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						  Custom Variable Value
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="oldVariableName" value="%value variableName%">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		
		%ifvar todo -notempty%
			<ul class="listitems">
				<li class="listitem"><a href="basic-customvariablevalue.dsp">Return to Custom Variable Value Information</a></li>
			</ul>
		%else%
			<input type="hidden" name="variableName" value="">		
				<ul class="listitems">
					<li class="listitem"><a href="javascript:doAction('create', '')">Create New Custom Variable Value</a></li>	
				</ul>
		%endifvar%
		
		<table class="tableForm" width="100%">	
			%ifvar todo equals('create')%
				<tr>
					<td class="heading" colspan="2">Custom Variable Value Properties</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Variable Name</td>
					<td class="evenrow-l" width="70%"><input type="text" name="variableName" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Description</td>
					<td class="evenrow-l" width="70%"><input type="text" name="description" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Variable Value/Description</td>
					<td class="evenrow-l" width="70%"><input type="text" name="tempValue" size="20" style="font-size:10pt;width:100">&nbsp;/&nbsp;
						                                   <input type="text" name="tempDesc" size="20" style="font-size:10pt;width:400">&nbsp;
						                                   <input type="button" name="ADDVALUE" value="Add Value"  onclick="return addValue()"></input>&nbsp;
							                               <input type="button" name="ADDVALUE" value="Update Value"  onclick="return updateVariableValue()"></input>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Variable Value List</td>
					<td class="evenrow-l" width="70%">
						<select name="variableValue" style="width:515" size=5 multiple onclick="setUpdateVariableValue(this.value)">
						</select>&nbsp;
						<input type="button" name="DELETEVALUE" value="Delete Value"  onclick="return deleteValue()"></input>
					</td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Create Custom Variable Value"  onclick="return doAction('add', '')"></input>
					</td>
				</tr>
			%else%
				%ifvar todo equals('read')%
					<tr>
						<td class="heading" colspan="2">Custom Variable Value Properties</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Variable Name</td>
						<td class="evenrow-l" width="70%"><input type="text" name="variableName" value="%value variableName%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Description</td>
						<td class="evenrow-l" width="70%"><input type="text" name="description" value="%value description%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Variable Value/Description</td>
						<td class="evenrow-l" width="70%"><input type="text" name="tempValue" size="20" style="font-size:10pt;width:100">&nbsp;/&nbsp;
							                                   <input type="text" name="tempDesc" size="20" style="font-size:10pt;width:400">&nbsp;
							                                   <input type="button" name="ADDVALUE" value="Add Value"  onclick="return addValue()"></input>&nbsp;
							                                   <input type="button" name="ADDVALUE" value="Update Value"  onclick="return updateVariableValue()"></input>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Variable Value List</td>
						<td class="evenrow-l" width="70%">
							<select name="variableValue" style="width:515" size=5 multiple onclick="setUpdateVariableValue(this.value)">
								%loop variableValueList%
									<option value="%value variableValueList%">%value variableValueList%</option>
								%endloop%
							</select>&nbsp;
							<input type="button" name="DELETEVALUE" value="Delete Value"  onclick="return deleteValue()"></input>
						</td>
					</tr>					
					<tr>
						<td class="action" colspan="2">
							<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>
						</td>
					</tr>
				%else%
					<tr>
						<td class="heading" colspan=5>Custom Variable Value Information</td>
					</tr>
					<tr class="subheading2">
						<td>Variable Name</td>
						<td>Description</td>
						<td>Variable Values</td>						
						<td>Edit</td>
						<td>Delete</td>
					</tr>
					%ifvar -notempty CustomVariableValueConfig/Items%
						%loop CustomVariableValueConfig/Items%
							<tr>
								<td>%value variableName%</td>
								<td>%value description%</td>
								<td>
									%loop variableValueList%
										%value value%<br>
									%endloop%
								</td>								
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
						<tr><td colspan=5>No custom variable values are currently registered.</td></tr>
					%endifvar%
				%endifvar%
			%endifvar%
		</table>
		</form>
	</body>
</html>

%endinvoke%