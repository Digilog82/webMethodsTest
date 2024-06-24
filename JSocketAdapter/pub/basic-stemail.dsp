%invoke JSocketAdapter.ADMIN:adminSourceTargetEmail%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, ifid){
				var frm = document.pform;
				frm.todo.value = todo;
				
				if (ifid != '') {
					frm.interfaceID.value = ifid;
				}
				
				if (todo == 'delete') {
					if(confirm("Do you really want to delete config of  " + ifid)){
						frm.submit();
					}
				} else if (todo == 'add' || todo == 'update') {
					var interfaceID = frm.interfaceID.value;
					var sEmailList = frm.sEmailList;
					var tEmailList = frm.tEmailList;
					var sLength = sEmailList.options.length;
					var tLength = tEmailList.options.length;
					
					if (interfaceID == "") {
						alert("Interface ID를 선택하십시요.");
						return;
					}
					
					if (sLength == 0 && tLength == 0) {
						alert("Source System 담당자 이메일 또는 Target System 담당자 이메일 정보를 입력하십시요.");
						return;
					}
					
					if (sLength == 0) {
						//alert("Source System 담당자 이메일을 입력하십시요.");
						//return;
					} else if (sLength == 1) {
						frm.sourceEmail.value = sEmailList.options[0].value;
					} else {					
						// Email List 전체를 선택한 것으로 처리
						for (var i = 0; i < sLength; i++) {
							sEmailList.options[i].selected = true;
						}
					}
					
					if (tLength == 0) {
						//alert("Target System 담당자 이메일을 입력하십시요.");
						//return;
					} else if (tLength == 1) {
						frm.targetEmail.value = tEmailList.options[0].value;
					} else {					
						// Email List 전체를 선택한 것으로 처리
						for (var i = 0; i < tLength; i++) {
							tEmailList.options[i].selected = true;
						}
					}
					
					if (todo == 'update') {
						var sMailList = [];
						var tMailList = [];
						var mailChange = "false";
						
						%loop sourceEmailList -$index%
							sMailList[%value $index%] = "%value sourceEmailList%";
						%endloop%
						
						%loop targetEmailList -$index%
							tMailList[%value $index%] = "%value targetEmailList%";
						%endloop%
						
						// Source System 담당자 메일 목록에 변경이 있는지 확인
						if (sLength != sMailList.length) {
							// Source System 담당자 메일 목록에 변경이 있는 경우
							mailChange = "true";
						} else {
							for (var i = 0; i < sLength; i++) {
								var mailExist = "false";
								
								for (var j = 0; j < sMailList.length; j++) {
									if (sEmailList.options[i].value == sMailList[j]) {
										mailExist = "true";
										break;
									}
								}
								
								// Source System 담당자 메일 목록에 변경이 있는 경우
								if (mailExist == "false") {
									mailChange = "true";
									break;
								}
							}
						}
						
						// Target System 담당자 메일 목록에 변경이 있는지 확인
						if (mailChange == "false") {
							if (tLength != tMailList.length) {
								// Target System 담당자 메일 목록에 변경이 있는 경우
								mailChange = "true";
							} else {
								for (var i = 0; i < tLength; i++) {
									var mailExist = "false";
									
									for (var j = 0; j < tMailList.length; j++) {
										if (tEmailList.options[i].value == tMailList[j]) {
											mailExist = "true";
											break;
										}
									}
									
									// Target System 담당자 메일 목록에 변경이 있는 경우
									if (mailExist == "false") {
										mailChange = "true";
										break;
									}
								}
							}
						}
						
						// Source, Target System 담당자 메일 목록에 변경이 있는 경우에는 다시 Deploy 가능하도록 deployYN을 No로 업데이트 해준다.
						if (mailChange == "true") {
							frm.deployYN.value = "No";
						}
					}
					
					frm.submit();
				} else {
					frm.submit();
				}
			}					
			
			function addValue(st) {
				var emailList;
				var objSName;
				var objName;
				var objEmail;
				var tempSName;
				var tempName;
				var tempEmail;
				
				if (st == "s") {
					emailList = document.pform.sEmailList;
					objSName = document.pform.tempSSName;
					objName = document.pform.tempSName;
					objEmail = document.pform.tempSEmail;
					tempSName = document.pform.tempSSName.value;
					tempName = document.pform.tempSName.value;
					tempEmail = document.pform.tempSEmail.value;
				} else {
					emailList = document.pform.tEmailList;
					objSName = document.pform.tempTSName;
					objName = document.pform.tempTName;
					objEmail = document.pform.tempTEmail;
					tempSName = document.pform.tempTSName.value;
					tempName = document.pform.tempTName.value;
					tempEmail = document.pform.tempTEmail.value;
				}
				
				if (tempSName == "") {
					alert("System Name을 입력하십시요.");
					return;
				} else {
					if (tempSName.indexOf('\/') >= 0) {
						alert("System Name에 '\/' 를 사용할 수 없습니다.");
						return;
					}
				}
				
				if (tempName == "") {
					alert("Name을 입력하십시요.");
					return;
				} else {
					if (tempName.indexOf('\/') >= 0) {
						alert("Name에 '\/' 를 사용할 수 없습니다.");
						return;
					}
				}
				
				if (tempEmail == "") {
					alert("Email을 입력하십시요.");
					return;
				} else {
					if (tempEmail.indexOf('\/') >= 0) {
						alert("Email에 '\/' 를 사용할 수 없습니다.");
						return;
					}
				}
				
				// Email 중복 체크
				var emailLength = emailList.options.length;
				for (var i=0; i < emailLength; i++) {
					var varEmailDesc = emailList.options[i].value;
					var varEmail = varEmailDesc.split("/")[2];
					
					if (tempEmail == varEmail) {
						alert("Email " + tempEmail + "는 이미 추가되어 있습니다.");
						objSName.value = "";
						objName.value = "";
						objEmail.value = "";
						return;
					}
				}
				
				emailList.options[emailLength] = new Option(tempSName + "/" + tempName + "/" + tempEmail, tempSName + "/" + tempName + "/" + tempEmail);
				objSName.value = "";
				objName.value = "";
				objEmail.value = "";
			}
			
			function deleteValue(st) {
				var emailList;
				var objSName;
				var objName;
				var objEmail;
				
				if (st == "s") {
					emailList = document.pform.sEmailList;
					objSName = document.pform.tempSSName;
					objName = document.pform.tempSName;
					objEmail = document.pform.tempSEmail;
				} else {
					emailList = document.pform.tEmailList;
					objSName = document.pform.tempTSName;
					objName = document.pform.tempTName;
					objEmail = document.pform.tempTEmail;
				}
				
				var emailLength = emailList.options.length;
				
				var optionIndex = 0;
				var newValueLength;
				var selectYN = "false";
				
				for (var i = 0; i < emailLength; i++) {
					if (emailList.options[optionIndex].selected) {
						objSName.value = "";
						objName.value = "";
						objEmail.value = "";
						emailList.options.remove(optionIndex);
						selectYN = "true";
					} else {
						optionIndex++;
					}
					
					newValueLength = emailList.options.length;
					
					if (optionIndex > (newValueLength-1)) {
						break;
					}
				}
				
				if (selectYN == "false") {
					alert("삭제할 Email을 선택하십시요.");
					return;
				}
			}
			
			function updateValue(st) {
				var emailList;
				var objSName;
				var objName;
				var objEmail;
				var tempSName;
				var tempName;
				var tempEmail;
				
				if (st == "s") {
					emailList = document.pform.sEmailList;
					objSName = document.pform.tempSSName;
					objName = document.pform.tempSName;
					objEmail = document.pform.tempSEmail;
					tempSName = document.pform.tempSSName.value;
					tempName = document.pform.tempSName.value;
					tempEmail = document.pform.tempSEmail.value;
				} else {
					emailList = document.pform.tEmailList;
					objSName = document.pform.tempTSName;
					objName = document.pform.tempTName;
					objEmail = document.pform.tempTEmail;
					tempSName = document.pform.tempTSName.value;
					tempName = document.pform.tempTName.value;
					tempEmail = document.pform.tempTEmail.value;
				}
				
				var emailLength = emailList.options.length;
				var optionIndex = 0;
				var selectYN = "false";
				
				if (tempSName == "") {
					alert("System Name을 입력하십시요.");
					return;
				} else {
					if (tempSName.indexOf('\/') >= 0) {
						alert("System Name에 '\/' 를 사용할 수 없습니다.");
						return;
					}
				}
				
				if (tempName == "") {
					alert("Name을 입력하십시요.");
					return;
				} else {
					if (tempName.indexOf('\/') >= 0) {
						alert("Name에 '\/' 를 사용할 수 없습니다.");
						return;
					}
				}
				
				if (tempEmail == "") {
					alert("Email을 입력하십시요.");
					return;
				} else {
					if (tempEmail.indexOf('\/') >= 0) {
						alert("Email에 '\/' 를 사용할 수 없습니다.");
						return;
					}
				}
				
				// Email 중복 체크
				for (var i=0; i < emailLength; i++) {
					if (emailList.options[i].selected) {
						// 수정하기 위해서 선택한 Option인 경우에는 Skip
					} else {
						var varEmailDesc = emailList.options[i].value;
						var varEmail = varEmailDesc.split("/")[2];
						
						if (tempEmail == varEmail) {
							alert("Email " + tempEmail + "는 이미 추가되어 있습니다.");
							objSName.value = "";
							objName.value = "";
							objEmail.value = "";
							return;
						}
					}
				}
				
				for (var i = 0; i < emailLength; i++) {
					if (emailList.options[optionIndex].selected) {
						emailList.options[optionIndex] = new Option(tempSName + "/" + tempName + "/" + tempEmail, tempSName + "/" + tempName + "/" + tempEmail);
						selectYN = "true";
						break;
					} else {
						optionIndex++;
					}
				}
				
				if (selectYN == "false") {
					alert("수정할 Email을 먼저 선택하십시요.");
					return;
				}
				
				objSName.value = "";
				objName.value = "";
				objEmail.value = "";
			}
			
			function setUpdateValue(st, vValue) {
				var objSName;
				var objName;
				var objEmail;
				
				if (st == "s") {
					objSName = document.pform.tempSSName;
					objName = document.pform.tempSName;
					objEmail = document.pform.tempSEmail;
				} else {
					objSName = document.pform.tempTSName;
					objName = document.pform.tempTName;
					objEmail = document.pform.tempTEmail;
				}
				
				var varValue = vValue.split("/");
				objSName.value = varValue[0];
				objName.value = varValue[1];
				objEmail.value = varValue[2];
			}
			
			function setIFInfo(ifInfo) {
				var frm = document.pform;
				var ifInfos = ifInfo.split("|");
				
				frm.tempDocName.value = ifInfos[1];
				frm.tempDescription.value = ifInfos[2];
				frm.interfaceID.value = ifInfos[0];
				frm.docName.value = ifInfos[1];
				frm.description.value = ifInfos[2];				
			}
			
			function alertMsg() {
				var frm = document.pform;
				var msg = frm.alertMsg.value;
				
				if (msg != "") {
					alert(msg);
					frm.alertMsg.value = ""; // 다른 화면으로 이동 시 영향을 주기 때문에 alertMsg 를 공백처리 한다.
				}
				
				// 신규 등록 화면 최초 진입 시 onchange 이벤트가 발생하지 않아도 Interface ID 리스트 중에서 첫번째 Value에 대해서 setIFInfo() 함수가
				// 적용되게 하기 위한 처리. 목록조회, 상세조회 화면에서는 필요 없음.
				var ifInfo = frm.tempInterfaceID.value;
				
				if (ifInfo != "") {
					setIFInfo(ifInfo);
				}
			}
		</script>
	</head>
	<body onload="javascript:alertMsg()">
		
		%ifvar changed equals('true')%
			<form name="dform" method="post">
				<input type="hidden" name="todo" value="emailSearch">
				<input type="hidden" name="alertMsg" value="%value alertMsg%">
				<input type="hidden" name="sInterfaceID" value="%value sInterfaceID%">
				<input type="hidden" name="sDocName" value="%value sDocName%">
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
						Source Target Email &gt;
						Create Source Target Email
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						    Source Target Email &gt;
							Edit Source Target Email
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						    Source Target Email
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		
		%ifvar todo equals('emailSearch')%
			<input type="hidden" name="interfaceID" value="">
			<ul class="listitems">
				<li class="listitem"><a href="javascript:doAction('create', '')">Create New Source Target Email</a></li>	
			</ul>			
		%else%
			<ul class="listitems">
				<li class="listitem"><a href="basic-stemail.dsp?todo=emailSearch&sInterfaceID=%value sInterfaceID%&sDocName=%value sDocName%">Return to Source Target Email Information</a></li>
			</ul>
		%endifvar%
		
		<table class="tableForm" width="100%">	
			%ifvar todo equals('create')%
				<tr>
					<td class="heading" colspan="2">Source Target Email Properties</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Interface ID</td>
					<td class="evenrow-l" width="70%">
						<select name="tempInterfaceID" onchange="javascript:setIFInfo(this.value)">
							%loop InterfaceIDList%
								<option value="%value interfaceIDValue%">%value interfaceIDDisplay%</option>
							%endloop%
						</select>
						<input type="hidden" name="interfaceID" value="">
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Doc Name</td>
					<td class="evenrow-l" width="70%"><input type="text" name="tempDocName" disabled size="20" style="font-size:10pt;width:400">
					                                  <input type="hidden" name="docName" value="">
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Description</td>
					<td class="evenrow-l" width="70%"><input type="text" name="tempDescription" disabled size="20" style="font-size:10pt;width:400">
					                                  <input type="hidden" name="description" value="">
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Email Receive YN</td>
					<td class="evenrow-l" width="70%">
						<select name="mailReceive">
							<option value="Yes">Yes</option>
							<option value="No">No</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Source System Name/Incharge Name/Email</td>
					<td class="evenrow-l" width="70%"><input type="text" name="tempSSName" size="20" style="font-size:10pt;width:100">&nbsp;/&nbsp;
						                              <input type="text" name="tempSName" size="20" style="font-size:10pt;width:100">&nbsp;/&nbsp;
													  <input type="text" name="tempSEmail" size="20" style="font-size:10pt;width:400">&nbsp;
						                              <input type="button" name="ADDVALUE" value="Add Value"  onclick="return addValue('s')"></input>&nbsp;
							                          <input type="button" name="ADDVALUE" value="Update Value"  onclick="return updateValue('s')"></input>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Source System Incharge Email List</td>
					<td class="evenrow-l" width="70%">
						<select name="sEmailList" style="width:515" size=5 multiple onclick="setUpdateValue('s', this.value)">
						</select>&nbsp;
						<input type="button" name="DELETEVALUE" value="Delete Value"  onclick="return deleteValue('s')"></input>
						<input type="hidden" name="sourceEmail" value="">
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Target System Name/Incharge Name/Email</td>
					<td class="evenrow-l" width="70%"><input type="text" name="tempTSName" size="20" style="font-size:10pt;width:100">&nbsp;/&nbsp;
						                              <input type="text" name="tempTName" size="20" style="font-size:10pt;width:100">&nbsp;/&nbsp;
													  <input type="text" name="tempTEmail" size="20" style="font-size:10pt;width:400">&nbsp;
						                              <input type="button" name="ADDVALUE" value="Add Value"  onclick="return addValue('t')"></input>&nbsp;
							                          <input type="button" name="ADDVALUE" value="Update Value"  onclick="return updateValue('t')"></input>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Target System Incharge Email List</td>
					<td class="evenrow-l" width="70%">
						<select name="tEmailList" style="width:515" size=5 multiple onclick="setUpdateValue('t', this.value)">
						</select>&nbsp;
						<input type="button" name="DELETEVALUE" value="Delete Value"  onclick="return deleteValue('t')"></input>
						<input type="hidden" name="targetEmail" value="">
					</td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Create Source Target Email"  onclick="return doAction('add', '')"></input>
					</td>
				</tr>
			%else%
				%ifvar todo equals('read')%
					<tr>
						<td class="heading" colspan="2">Source Target Email Properties</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Interface ID</td>
						<td class="evenrow-l" width="70%">%value interfaceID%
						                                  <input type="hidden" name="interfaceID" value="%value interfaceID%">
														  <input type="hidden" name="tempInterfaceID" value="">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Doc Name</td>
						<td class="evenrow-l" width="70%">%value docName%</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Description</td>
						<td class="evenrow-l" width="70%">%value description%</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Email Receive YN</td>
						<td class="evenrow-l" width="70%">
							<select name="mailReceive">
								<option value="Yes">Yes</option>
								<option value="No">No</option>
							</select>
							<script language="javascript">
								document.pform.mailReceive.value = "%value mailReceive%";
							</script>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Source System Name/Incharge Name/Email</td>
						<td class="evenrow-l" width="70%"><input type="text" name="tempSSName" size="20" style="font-size:10pt;width:100">&nbsp;/&nbsp;
						                                  <input type="text" name="tempSName" size="20" style="font-size:10pt;width:100">&nbsp;/&nbsp;
														  <input type="text" name="tempSEmail" size="20" style="font-size:10pt;width:400">&nbsp;
						                                  <input type="button" name="ADDVALUE" value="Add Value"  onclick="return addValue('s')"></input>&nbsp;
							                              <input type="button" name="ADDVALUE" value="Update Value"  onclick="return updateValue('s')"></input>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Source System Incharge Email List</td>
						<td class="evenrow-l" width="70%">
							<select name="sEmailList" style="width:515" size=5 multiple onclick="setUpdateValue('s', this.value)">
								%loop sourceEmailList%
									<option value="%value sourceEmailList%">%value sourceEmailList%</option>
								%endloop%
							</select>&nbsp;
							<input type="button" name="DELETEVALUE" value="Delete Value"  onclick="return deleteValue('s')"></input>
							<input type="hidden" name="sourceEmail" value="">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Target System Name/Incharge Name/Email</td>
						<td class="evenrow-l" width="70%"><input type="text" name="tempTSName" size="20" style="font-size:10pt;width:100">&nbsp;/&nbsp;
						                                  <input type="text" name="tempTName" size="20" style="font-size:10pt;width:100">&nbsp;/&nbsp;
														  <input type="text" name="tempTEmail" size="20" style="font-size:10pt;width:400">&nbsp;
						                                  <input type="button" name="ADDVALUE" value="Add Value"  onclick="return addValue('t')"></input>&nbsp;
							                              <input type="button" name="ADDVALUE" value="Update Value"  onclick="return updateValue('t')"></input>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Target System Incharge Email List</td>
						<td class="evenrow-l" width="70%">
							<select name="tEmailList" style="width:515" size=5 multiple onclick="setUpdateValue('t', this.value)">
								%loop targetEmailList%
									<option value="%value targetEmailList%">%value targetEmailList%</option>
								%endloop%
							</select>&nbsp;
							<input type="button" name="DELETEVALUE" value="Delete Value"  onclick="return deleteValue('t')"></input>
							<input type="hidden" name="targetEmail" value="">
							<input type="hidden" name="deployYN" value="%value deployYN%">
						</td>
					</tr>
					<tr>
						<td class="action" colspan="2">
							<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>
							<input type="hidden" name="sInterfaceID" value="%value sInterfaceID%">
							<input type="hidden" name="sDocName" value="%value sDocName%">
						</td>
					</tr>
				%else%
					</table>
					<table class="tableForm" width="100%">
						<tr>
							<td class="heading" colspan="2">Search Condition</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Interface ID</td>
							<td class="evenrow-l" width="70%">
								<input type="text" name="sInterfaceID" value="%value sInterfaceID%" size="20" style="font-size:10pt;width:200">
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Doc Name</td>
							<td class="evenrow-l" width="70%">
								<input type="text" name="sDocName" value="%value sDocName%" size="20" style="font-size:10pt;width:200">
							</td>
						</tr>
						<tr>
							<td class="action" colspan="2">
								<input type="button" name="SUBMIT" value="Search"  onclick="return doAction('emailSearch', '')"></input>
								<input type="hidden" name="tempInterfaceID" value="">
							</td>
						</tr>
					</table>
					
					<table class="tableForm" width="100%">					
					<tr>
						<td class="heading" colspan=7>Source Target Email Information</td>
					</tr>
					<tr class="subheading2">
						<td>Interface ID</td>
						<td>Doc Name</td>
						<td>Description</td>
						<td>Source System Incharge Email</td>
						<td>Target System Incharge Email</td>						
						<td>Edit</td>
						<td>Delete</td>
					</tr>
					%ifvar -notempty SourceTargetEmailConfig/Items%
						%loop SourceTargetEmailConfig/Items%
							<tr>
								<td>%value interfaceID%</td>
								<td>%value docName%</td>
								<td>%value description%</td>
								<td>
									%loop sourceEmailList%
										%value email%<br>
									%endloop%
								</td>
								<td>
									%loop targetEmailList%
										%value email%<br>
									%endloop%
								</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('read', '%value interfaceID%')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
								</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value interfaceID%')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=7>No source target emails are currently registered.</td></tr>
					%endifvar%
				</table>
				%endifvar%
			%endifvar%
		%endifvar%

		</form>
	</body>
</html>

%endinvoke%