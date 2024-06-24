%invoke JSocketAdapter.ADMIN:adminBusinessInterfaceList%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, docName){
				var frm = document.pform;
				frm.todo.value = todo;
				
				if(docName != '') {
					if (todo == 'download') {
						frm.fileName.value = docName;
					} else {
						frm.docName.value = docName;
					}
				}
				
				// 실제 파일 다운로드가 실행될 경우 화면 이동이 없다. 그러므로 Download 버튼 클릭 이후에는
				// action이 downloadFile로 바뀐 상태이기 때문에 아래 처리를 하지 않을 경우 모든 버튼 클릭 시
				// downloadFile로 submit 된다.
				if (todo == 'download') {
					frm.action = "/invoke/JSocketAdapter.ADMIN/downloadFile";
				} else {
					frm.action = "";
				}
				
				if(todo == 'delete'){
					if(confirm("Do you really want to delete config of  " + docName)){
						frm.submit();
					}
				}  else if (todo == 'add' || todo == 'update') {
					var systemName = frm.systemName.value;
					var businessName = frm.businessName.value;
					var classCode = frm.classCode.value;
					var businessCode = frm.businessCode.value;
					var interfaceID = frm.interfaceID.value;
					var schemaDefineService = frm.schemaDefineService.value;
                    var schemaDocType = frm.schemaDocType.value;
                    var schemaDefine = frm.schemaDefine.value;
					//var schemaDefineFileName = document.frames["uploadFileForm"].document.uform.schemaDefineFileName.value;
					var schemaDefineFileName = "";
					var upload = frm.schemaDefUpload.value;
					
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
						
						if (schemaDefine == "" && schemaDefineFileName == "") {
							alert("Schema Define을 입력하거나 Schema Define File을 선택해야 합니다.");
							return;
						}						
					} else if (todo == "update") {
						if (schemaDefine != "" && schemaDefineService != "" && schemaDocType == "") {
							alert("Schema Define Service를 수정하기 위해서는 Schema Document Type Name을 입력해야 합니다.");
							return;
						}
						
						if (schemaDefineFileName != "" && schemaDefineService != "" && schemaDocType == "") {
							alert("Schema Define Service를 수정하기 위해서는 Schema Document Type Name을 입력해야 합니다.");
							return;
						}
					}
					
					if (schemaDefineFileName != "") {
						if (upload == "false") {
							alert("현재 서버에서는 파일 업로드를 할 수 없습니다.");
							return;
						}
						
						var docFileExtension = "%value docFileExtension%";
						var fnindex = schemaDefineFileName.indexOf("." + docFileExtension);
						
						if (fnindex < 0) {
							alert("파일 형식은 Custom Variable \"ESB.SOCKET.DOCFILE.EXTENSION\"에 설정된 Value(." + docFileExtension + ")와 같아야 합니다.");
							return;
						}
						
						fnindex = schemaDefineFileName.indexOf(".xls");						
						
						if (fnindex < 0 && schemaDefine == "") {
							alert("파일 형식이 .xls가 아닌 경우에는 Schema Define 항목을 반드시 입력해야 합니다.");
							return;
						}
						
						//document.frames["uploadFileForm"].document.uform.docName.value = systemName + businessName + classCode + businessCode;
						//document.frames["uploadFileForm"].document.uform.interfaceID.value = interfaceID;
						//document.frames["uploadFileForm"].document.uform.socketServerType.value = "remote";
						//document.frames["uploadFileForm"].document.uform.submit();
						frm.docName.value = systemName + businessName + classCode + businessCode;
						frm.schemaDefineFileUpload.value = "Yes";
						setTimeout(function() {frm.submit();}, 500); // 0.5초 후에 pform submit
					} else {					
						frm.docName.value = systemName + businessName + classCode + businessCode;
						frm.schemaDefineFileUpload.value = "No";
						frm.submit();
					}
				} else {
					frm.submit();
				}
			}
			
			function makeDocName(type) {
				var frm = document.pform;
				var systemName = frm.systemName.value;
				var businessName = frm.businessName.value;
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
						frm.tempDocName.value = systemName + businessName + classCode + businessCode;
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
				
					frm.tempDocName.value = systemName + businessName + classCode + businessCode;
				}
			}
			
			function schemaView(docName, comSchemaService, schemaService) {
				window.open('/JSocketAdapter/basic-bifdocschemadetail.dsp?todo=schemaView&docName=' + docName + '&commSchemaDefineService=' + comSchemaService + '&schemaDefineService=' + schemaService, 'schemaView', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
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
				<input type="hidden" name="businessName" value="%value businessName%">
				<input type="hidden" name="systemName" value="%value systemName%">
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
						Business Doc List &gt;
						Create Business Doc
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
							Business Name &gt;
							Business Doc List &gt;
							Edit Business Doc
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
							Business Name &gt;
							Business Doc List
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="businessName" value="%value businessName%">
		<input type="hidden" name="systemName" value="%value systemName%">
		<input type="hidden" name="oldInterfaceID" value="%value interfaceID%">
		<input type="hidden" name="oldDocName" value="%value docName%">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		<input type="hidden" name="schemaDefineFileUpload" value="">
		<input type="hidden" name="schemaDefUpload" value="%value schemaDefUpload%">
		%ifvar todo -notempty%
			%ifvar todo equals('download')%
				<input type="hidden" name="docName" value="">		
					<ul class="listitems">
						<li class="listitem"><a href="basic-businessname.dsp">Return to Business Name Information</a></li>
						<li class="listitem"><a href="javascript:doAction('create', '')">Create New Business Doc</a></li>
					</ul>
			%else%
				<ul class="listitems">
					<li class="listitem"><a href="basic-businessif.dsp?businessName=%value businessName%&systemName=%value systemName%">Return to Business Doc List Information</a></li>
				</ul>
			%endifvar%
		%else%
			<input type="hidden" name="docName" value="">		
				<ul class="listitems">
					<li class="listitem"><a href="basic-businessname.dsp">Return to Business Name Information</a></li>
					<li class="listitem"><a href="javascript:doAction('create', '')">Create New Business Doc</a></li>
				</ul>
		%endifvar%
		<table class="tableForm" width="100%">	
			%ifvar todo equals('create')%
				<tr>
					<td class="heading" colspan="2">Business Doc Properties</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Business Name</td>
					<td class="evenrow-l" width="70%">%value businessName%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">System Name</td>
					<td class="evenrow-l" width="70%">%value systemName%</td>
				</tr>
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
					<td class="evenrow" width="30%">Send Status Timeout</td>
					<td class="evenrow-l" width="70%"><input type="text" name="sendStatusTimeout" size="20" style="font-size:10pt;width:400"> (초단위)</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Response Timeout</td>
					<td class="evenrow-l" width="70%"><input type="text" name="responseTimeout" size="20" style="font-size:10pt;width:400"> (초단위)</td>
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
					<td class="evenrow" width="30%">Schema Define File</td>
					<td class="evenrow-l" width="70%">
						<!--
						<iframe id="uploadFileFrame" name="uploadFileForm" src="basic-docuploadiframe.dsp" style="width:600;height:40;border:0;display:;">
		                </iframe>
						-->
					</td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Create Business Doc"  onclick="return doAction('add', '')"></input>
					</td>
				</tr>
			%else%
				%ifvar todo equals('read')%
					<tr>
						<td class="heading" colspan="2">Business Doc Properties</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Business Name</td>
						<td class="evenrow-l" width="70%">%value businessName%</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">System Name</td>
						<td class="evenrow-l" width="70%">%value systemName%</td>
					</tr>
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
						<td class="evenrow" width="30%">Send Status Timeout</td>
						<td class="evenrow-l" width="70%"><input type="text" name="sendStatusTimeout" value="%value sendStatusTimeout%" size="20" style="font-size:10pt;width:400"> (초단위)</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Response Timeout</td>
						<td class="evenrow-l" width="70%"><input type="text" name="responseTimeout" value="%value responseTimeout%" size="20" style="font-size:10pt;width:400"> (초단위)</td>
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
						<td class="evenrow" width="30%">Schema Define File</td>
						<td class="evenrow-l" width="70%">
							<!--
							<iframe id="uploadFileFrame" name="uploadFileForm" src="basic-docuploadiframe.dsp" style="width:600;height:40;border:0;display:;">
							</iframe>
							-->
						</td>
					</tr>
					<tr>
						<td class="action" colspan="2">
							<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>
						</td>
					</tr>
				%else%
					<!-- 전문 Schema 정의 엑셀파일 다운로드 시 필요 -->
					<input type="hidden" name="filePath" value="%value filePath%">
					<input type="hidden" name="fileName" value="">
					<input type="hidden" name="moveAction" value="/JSocketAdapter/basic-businessif.dsp">
					<tr>
						<td class="heading" colspan=11>Doc List Information in Business Name(%value businessName%)</td>
					</tr>
					<tr class="subheading2">
						<td>Business Name</td>
						<td>System Name</td>
						<td>Doc Name</td>
						<td>Doc Class Code (전문종별코드)</td>
						<td>Doc Business Code (전문업무구분코드)</td>
						<td>Interface ID</td>						
						<td>Description</td>
						%ifvar schemaDefDownload equals('true')%
						<td>Schema Def Download</td>
						%endifvar%
						<td>Schema</td>
						<td>Edit</td>
						<td>Delete</td>
					</tr>
					%ifvar -notempty InterfaceListConfig/Items%
						%loop InterfaceListConfig/Items%
							<tr>
								<td>%value businessName%</td>
								<td>%value systemName%</td>
								<td>%value docName%</td>
								<td>%value classCode%</td>
								<td>%value businessCode%</td>
								<td>%value interfaceID%</td>
								<td>%value description%</td>
								%ifvar ../schemaDefDownload equals('true')%
								<td class="evenrowdata">
									<a href="javascript:doAction('download', '%value interfaceID%.%value ../docFileExtension%')"><img src="%value ../../designPath%icons/movedown_enabled.png" alt="Download" border="0"></a>
								</td>
								%endifvar%
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
						<tr><td colspan=11>No business docs are currently registered.</td></tr>
					%endifvar%
				%endifvar%
			%endifvar%
		%endifvar%
		</table>
		</form>
	</body>
</html>

%endinvoke%