%invoke JSocketAdapter.ADMIN:adminDocInterfaceID%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, dname){
				var frm = document.pform;
				frm.todo.value = todo;
				
				if (dname != '') {
					frm.docName.value = dname;
				}
				
				if (todo == 'delete') {
					if(confirm("Do you really want to delete config of  " + dname)){
						frm.submit();
					}
				} else if (todo == 'add' || todo == 'update') {
					var classCode = frm.classCode.value;
					var businessCode = frm.businessCode.value;
					var interfaceID = frm.interfaceID.value;
					var schemaDefineService = frm.schemaDefineService.value;
                    var schemaDocType = frm.schemaDocType.value;
                    var schemaDefine = frm.schemaDefine.value;
					var targetService = frm.targetService.value;
					var commonLogicService = frm.commonLogicService.value;
					var inputName = frm.inputName.value;
					
					if (classCode == "") {
						alert("Doc Class Code (전문종별코드)를 입력하십시요.");
						return;
					}
					
					if (businessCode == "") {
						alert("Doc Business Code (전문업무구분코드)를 입력하십시요.");
						return;
					}
					
					if (interfaceID == "") {
						alert("Interface ID를 입력하십시요.");
						return;
					}
					
					if (todo == "add") {
						if (schemaDefineService != "" && schemaDocType == "") {
							alert("Schema Define Service를 생성하기 위해서는 Schema Document Type Name을 입력해야 합니다.");
							return;
						}
						
						if (schemaDefine == "") {
							alert("Schema Define을 입력하십시요.");
							return;
						}
						
						if (commonLogicService != "" && inputName == "") {
							alert("Processing Service를 생성하기 위해서는 Processing Service Input Parameter Name을 입력해야 합니다.");
							return;
						}
						
						if (commonLogicService == "" && inputName != "") {
							alert("Processing Service를 생성하기 위해서는 Processing Common Service를 입력해야 합니다.");
							return;
						}
						
						if (commonLogicService != "" && inputName != "" && targetService == "") {
							alert("Processing Service를 생성하기 위해서는 Processing Service를 입력해야 합니다.");
							return;
						}
					} else if (todo == "update") {
						if (schemaDefine != "" && schemaDefineService != "" && schemaDocType == "") {
							alert("Schema Define Service를 수정하기 위해서는 Schema Document Type Name을 입력해야 합니다.");
							return;
						}
						
						if (commonLogicService != "" && inputName == "") {
							alert("Processing Service를 수정하기 위해서는 Processing Service Input Parameter Name을 입력해야 합니다.");
							return;
						}
						
						if (commonLogicService == "" && inputName != "") {
							alert("Processing Service를 수정하기 위해서는 Processing Common Service를 입력해야 합니다.");
							return;
						}
						
						if (commonLogicService != "" && inputName != "" && targetService == "") {
							alert("Processing Service를 수정하기 위해서는 Processing Service를 입력해야 합니다.");
							return;
						}
					}
					
					frm.docName.value = classCode + businessCode;
					frm.submit();
				} else {
					frm.submit();
				}
			}
			
			function makeDocName(type) {
				var frm = document.pform;
				var classCode = frm.classCode.value;
				var businessCode = frm.businessCode.value;
				
				if (type == "classCode") {
					if (classCode == "") {
						alert("Doc Class Code (전문종별코드)를 입력하십시요.");
						return;
					}
					
					if (businessCode == "") {
						//Skip
					} else {
						frm.tempDocName.value = classCode + businessCode;
					}
				} else {
					if (classCode == "") {
						alert("Doc Class Code (전문종별코드)를 입력하십시요.");
						return;
					}
					
					if (businessCode == "") {
						alert("Doc Business Code (전문업무구분코드)를 입력하십시요.");
						return;
					}
				
					frm.tempDocName.value = classCode + businessCode;
				}
			}
			
			function schemaView(docName, comSchemaService, schemaService) {
				window.open('/JSocketAdapter/basic-docschemadetail.dsp?todo=schemaView&docName=' + docName + '&commSchemaDefineService=' + comSchemaService + '&schemaDefineService=' + schemaService, 'schemaView', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
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
				<input type="hidden" name="todo" value="docSearch">
				<input type="hidden" name="alertMsg" value="%value alertMsg%">
				<input type="hidden" name="sClassCode" value="%value sClassCode%">
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
						Local Server Socket Doc &gt;
						Create Local Server Socket Doc
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						    Local Server Socket Doc &gt;
							Edit Local Server Socket Doc
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						    Local Server Socket Doc
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="oldDocName" value="%value docName%">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		%ifvar todo equals('docSearch')%
			<input type="hidden" name="docName" value="">		
			<ul class="listitems">
				<li class="listitem"><a href="javascript:doAction('create', '')">Create New Local Server Socket Doc</a></li>	
			</ul>			
		%else%
			<ul class="listitems">
				<li class="listitem"><a href="basic-docinterfaceid.dsp?todo=docSearch&sClassCode=%value sClassCode%&sDocName=%value sDocName%">Return to Local Server Socket Doc Information</a></li>
			</ul>
		%endifvar%
		<table class="tableForm" width="100%">	
			%ifvar todo equals('create')%
				<tr>
					<td class="heading" colspan="2">Local Server Socket Doc Properties</td>
				</tr>
				<tr>
					<tr>
						<td class="evenrow" width="30%">Doc Name</td>
						<td class="evenrow-l" width="70%"><input type="text" name="tempDocName" disabled size="20" style="font-size:10pt;width:400">
						                                     <input type="hidden" name="docName" value="">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Doc Class Code (전문종별코드)</td>
						<td class="evenrow-l" width="70%"><input type="text" name="classCode" onblur="makeDocName('classCode')" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Doc Business Code (전문업무구분코드)</td>
						<td class="evenrow-l" width="70%"><input type="text" name="businessCode" onblur="makeDocName('businessCode')" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Interface ID</td>
						<td class="evenrow-l" width="70%"><input type="text" name="interfaceID" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Description</td>
						<td class="evenrow-l" width="70%"><input type="text" name="description" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Common Header Schema Define Service</td>
						<td class="evenrow-l" width="70%"><input type="text" name="commSchemaDefineService" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Schema Define Service</td>
						<td class="evenrow-l" width="70%"><input type="text" name="schemaDefineService" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Processing Service</td>
						<td class="evenrow-l" width="70%"><input type="text" name="targetService" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Processing Common Service</td>
						<td class="evenrow-l" width="70%"><input type="text" name="commonLogicService" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Processing Service Input Parameter Name</td>
						<td class="evenrow-l" width="70%"><input type="text" name="inputName" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Save Audit Log to DB YN</td>
						<td class="evenrow-l" width="70%">
							<select name="saveAuditLog" style="width:90">								
								<option value="Yes">Yes</option>
								<option value="No">No</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Serial Processing YN</td>
						<td class="evenrow-l" width="70%">
							<select name="serialProcessing" style="width:90">								
								<option value="No">No</option>
								<option value="Yes">Yes</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Processing Skip YN</td>
						<td class="evenrow-l" width="70%">
							<select name="processingSkip" style="width:90">
								<option value="No">No</option>
								<option value="Yes">Yes</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Acknowledgement Doc YN</td>
						<td class="evenrow-l" width="70%">
							<select name="returnResponse" style="width:90">
								<option value="No">No</option>
								<option value="Yes">Yes</option>								
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">JMS Send Queue/Topic Name</td>
						<td class="evenrow-l" width="70%"><input type="text" name="jmsSendQueue" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Publishing Document Type Name</td>
						<td class="evenrow-l" width="70%"><input type="text" name="publishDocType" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Doc Length</td>
						<td class="evenrow-l" width="70%"><input type="text" name="docLength" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Send Status Timeout</td>
						<td class="evenrow-l" width="70%"><input type="text" name="sendStatusTimeout" size="20" style="font-size:10pt;width:400"> (초단위)</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Response Timeout</td>
						<td class="evenrow-l" width="70%"><input type="text" name="responseTimeout" size="20" style="font-size:10pt;width:400"> (초단위)</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Target System Name</td>
						<td class="evenrow-l" width="70%"><input type="text" name="targetSystemName" size="20" style="font-size:10pt;width:400"> (여러 개의 System Name 입력 필요 시에는 '/' 를 구분자로 해서 입력)</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Target Socket Name</td>
						<td class="evenrow-l" width="70%">
							<select name="targetSocketName" style="width:200">
								<option value="">선택</option>
								%loop socketNameList%
									<option value="%value socketNameList%">%value socketNameList%</option>
								%endloop%
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Listening Port</td>
						<td class="evenrow-l" width="70%">
							<select name="portNumber" style="width:200">
								<option value="">선택</option>
								<option value="MultiPort">Multi Port</option>
								%loop portList%
									<option value="%value portList%">%value portList%</option>
								%endloop%
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Multi Record Count Field Name</td>
						<td class="evenrow-l" width="70%"><input type="text" name="recCountFieldName" size="20" style="font-size:10pt;width:400"> (여러 개의 Field Name 입력 필요 시에는 '/' 를 구분자로 해서 입력)</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Schema Document Type Name</td>
						<td class="evenrow-l" width="70%"><input type="text" name="schemaDocType" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Schema Define</td>
						<td class="evenrow-l" width="70%"><textarea name="schemaDefine" cols="100" rows="20"></textarea></td>
					</tr>
					<tr>
						<td class="action" colspan="2">
							<input type="button" name="SUBMIT" value="Create Local Server Socket Doc"  onclick="return doAction('add', '')"></input>
						</td>
					</tr>
				</tr>	
			%else%
				%ifvar todo equals('read')%
					<tr>
						<td class="heading" colspan="2">Local Server Socket Doc Properties</td>
					</tr>
					<tr>
						<tr>
							<td class="evenrow" width="30%">Doc Name</td>
							<td class="evenrow-l" width="70%"><input type="text" name="tempDocName" value="%value docName%" disabled size="20" style="font-size:10pt;width:400">
						                                      <input type="hidden" name="docName" value="%value docName%">
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Doc Class Code (전문종별코드)</td>
							<td class="evenrow-l" width="70%"><input type="text" name="classCode" value="%value classCode%" onblur="makeDocName('classCode')" size="20" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Doc Business Code (전문업무구분코드)</td>
							<td class="evenrow-l" width="70%"><input type="text" name="businessCode" value="%value businessCode%" onblur="makeDocName('businessCode')" size="20" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Interface ID</td>
							<td class="evenrow-l" width="70%"><input type="text" name="interfaceID" value="%value interfaceID%" size="20" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Description</td>
							<td class="evenrow-l" width="70%"><input type="text" name="description" value="%value description%" size="20" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Common Header Schema Define Service</td>
							<td class="evenrow-l" width="70%"><input type="text" name="commSchemaDefineService" value="%value commSchemaDefineService%" size="20" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
						  <td class="evenrow" width="30%">Schema Define Service</td>
						  <td class="evenrow-l" width="70%"><input type="text" name="schemaDefineService" value="%value schemaDefineService%" size="20" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Processing Service</td>
							<td class="evenrow-l" width="70%"><input type="text" name="targetService" value="%value targetService%" size="20" style="font-size:10pt;width:400">
							                                  <input type="hidden" name="orgTargetService" value="%value targetService%">
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Processing Common Service</td>
							<td class="evenrow-l" width="70%"><input type="text" name="commonLogicService" value="%value commonLogicService%" size="20" style="font-size:10pt;width:400">
							                                  <input type="hidden" name="orgCommonLogicService" value="%value commonLogicService%">
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Processing Service Input Parameter Name</td>
							<td class="evenrow-l" width="70%"><input type="text" name="inputName" value="%value inputName%" size="20" style="font-size:10pt;width:400">
							                                  <input type="hidden" name="orgInputName" value="%value inputName%">
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Save Audit Log to DB YN</td>
							<td class="evenrow-l" width="70%">
								<select name="saveAuditLog" style="width:90">								
									<option value="Yes">Yes</option>
									<option value="No">No</option>
								</select>
								<script language="javascript">
									document.pform.saveAuditLog.value = "%value saveAuditLog%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Serial Processing YN</td>
							<td class="evenrow-l" width="70%">
								<select name="serialProcessing" style="width:90">																		
									<option value="No">No</option>
									<option value="Yes">Yes</option>
								</select>
								<script language="javascript">
									document.pform.serialProcessing.value = "%value serialProcessing%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Processing Skip YN</td>
							<td class="evenrow-l" width="70%">
								<select name="processingSkip" style="width:90">
									<option value="No">No</option>
									<option value="Yes">Yes</option>
								</select>
								<script language="javascript">
									document.pform.processingSkip.value = "%value processingSkip%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Acknowledgement Doc YN</td>
							<td class="evenrow-l" width="70%">
								<select name="returnResponse" style="width:90">									
									<option value="No">No</option>
									<option value="Yes">Yes</option>
								</select>
								<script language="javascript">
									document.pform.returnResponse.value = "%value returnResponse%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">JMS Send Queue/Topic Name</td>
							<td class="evenrow-l" width="70%"><input type="text" name="jmsSendQueue" value="%value jmsSendQueue%" size="20" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Publishing Document Type Name</td>
							<td class="evenrow-l" width="70%"><input type="text" name="publishDocType" value="%value publishDocType%" size="20" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Doc Length</td>
							<td class="evenrow-l" width="70%"><input type="text" name="docLength" value="%value docLength%" size="20" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Send Status Timeout</td>
							<td class="evenrow-l" width="70%"><input type="text" name="sendStatusTimeout" value="%value sendStatusTimeout%" size="20" style="font-size:10pt;width:400"> (초단위)</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Response Timeout</td>
							<td class="evenrow-l" width="70%"><input type="text" name="responseTimeout" value="%value responseTimeout%" size="20" style="font-size:10pt;width:400"> (초단위)</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Target System Name</td>
							<td class="evenrow-l" width="70%"><input type="text" name="targetSystemName" value="%value targetSystemName%" size="20" style="font-size:10pt;width:400"> (여러 개의 System Name 입력 필요 시에는 '/' 를 구분자로 해서 입력)</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Target Socket Name</td>
							<td class="evenrow-l" width="70%">
								<select name="targetSocketName" style="width:200">
									<option value="">선택</option>
									%loop socketNameList%
										<option value="%value socketNameList%">%value socketNameList%</option>
									%endloop%
								</select>
								<script language="javascript">
									document.pform.targetSocketName.value = "%value targetSocketName%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Listening Port</td>
							<td class="evenrow-l" width="70%">
								<select name="portNumber" style="width:200">
									<option value="">선택</option>
									<option value="MultiPort">Multi Port</option>
									%loop portList%
										<option value="%value portList%">%value portList%</option>
									%endloop%
								</select>
								<script language="javascript">
									document.pform.portNumber.value = "%value portNumber%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Multi Record Count Field Name</td>
							<td class="evenrow-l" width="70%"><input type="text" name="recCountFieldName" value="%value recCountFieldName%" size="20" style="font-size:10pt;width:400"> (여러 개의 Field Name 입력 필요 시에는 '/' 를 구분자로 해서 입력)</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Schema Document Type Name</td>
							<td class="evenrow-l" width="70%"><input type="text" name="schemaDocType" value="%value schemaDocType%" size="20" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Schema Define</td>
							<td class="evenrow-l" width="70%"><textarea name="schemaDefine" cols="100" rows="20"></textarea></td>
						</tr>
						<tr>
							<td class="action" colspan="2">
								<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>
								<input type="hidden" name="sClassCode" value="%value sClassCode%">
								<input type="hidden" name="sDocName" value="%value sDocName%">
							</td>
						</tr>
					</tr>
				%else%
					</table>
					<table class="tableForm" width="100%">
						<tr>
							<td class="heading" colspan="2">Search Condition</td>
						</tr>
						<tr>
							<tr>
								<td class="evenrow" width="30%">Doc Class Code (전문종별코드)</td>
								<td class="evenrow-l" width="70%">
									<input type="text" name="sClassCode" value="%value sClassCode%" size="20" style="font-size:10pt;width:200">
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
									<input type="button" name="SUBMIT" value="Search"  onclick="return doAction('docSearch', '')"></input>
								</td>
							</tr>
						</tr>			
					</table>
					
					<table class="tableForm" width="100%">					
					<tr>
						<td class="heading" colspan=9>Local Server Socket Doc Information</td>
					</tr>
					<tr class="subheading2">
						<td>Doc Name</td>
						<td>Doc Class Code (전문종별코드)</td>
						<td>Doc Business Code (전문업무구분코드)</td>
						<td>Interface ID</td>
						<td>Description</td>
						<td>Listening Port</td>
						<td>Schema</td>						
						<td>Edit</td>
						<td>Delete</td>
					</tr>
					%ifvar -notempty DocInterfaceIDConfig/Items%
						%loop DocInterfaceIDConfig/Items%
							<tr>
								<td>%value docName%</td>
								<td>%value classCode%</td>
								<td>%value businessCode%</td>
								<td>%value interfaceID%</td>
								<td>%value description%</td>
								<td>%value portNumber%</td>
								<td class="evenrowdata">
									<a href="javascript:schemaView('%value docName%', '%value commSchemaDefineService%', '%value schemaDefineService%')"><img src="%value ../../designPath%icons/file.gif" alt="View" border="0"></a>
								</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('read', '%value docName%')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
								</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value docName%')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=9>No local server socket docs are currently registered.</td></tr>
					%endifvar%
				</table>
				%endifvar%
			%endifvar%
		%endifvar%

		</form>
	</body>
</html>

%endinvoke%