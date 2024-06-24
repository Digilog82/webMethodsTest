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
					if (todo == 'download') {
						frm.fileName.value = dname;
					} else {
						frm.docName.value = dname;
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
					var schemaDefineFileName = document.frames["uploadFileForm"].document.uform.schemaDefineFileName.value;
					var targetService = frm.targetService.value;
					var commonLogicService = frm.commonLogicService.value;
					var inputName = frm.inputName.value;
					var upload = frm.schemaDefUpload.value;
					var targetSocketName = frm.targetSocketName.value;
					var targetPortNumber = frm.targetPortNumber.value;
					var healthCheckDoc = frm.healthCheckDoc.value;
					var targetServiceName = frm.targetServiceName.value;
					
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
						
						/*
						// 전문의 Body가 없는 전문도 존재하므로 아래 Step은 Skip
						if (healthCheckDoc == "No" && schemaDefine == "" && schemaDefineFileName == "") {
							alert("Schema Define을 입력하거나 Schema Define File을 선택해야 합니다.");
							return;
						}
						*/
						
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
						
						if (schemaDefineFileName != "" && schemaDefineService != "" && schemaDocType == "") {
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
					
					if (schemaDocType != "") {
						if (confirm("Schema Document Type을 자동으로 생성하기 위해서는 Designer에서 Document Type이 생성될 Package 및 Folder를 미리 생성해 놓아야 합니다(Clustering 환경일 경우 모든 서버에 해당). 계속 진행하시겠습니까?")) {						
						} else {
							return;
						}
					}
					
					if (schemaDefineService != "") {
						if (confirm("Schema Define Service를 자동으로 생성하기 위해서는 Designer에서 Schema Define Service가 생성될 Package 및 Folder를 미리 생성해 놓아야 합니다(Clustering 환경일 경우 모든 서버에 해당). 계속 진행하시겠습니까?")) {						
						} else {
							return;
						}
					}
					
					if (targetService != "" && commonLogicService != "") {
						if (confirm("Processing Service를 자동으로 생성하기 위해서는 Designer에서 Processing Service가 생성될 Package 및 Folder를 미리 생성해 놓아야 합니다(Clustering 환경일 경우 모든 서버에 해당). 계속 진행하시겠습니까?")) {						
						} else {
							return;
						}
					}
					
					if (targetSocketName != "" && targetPortNumber != "") {
						alert("Target Socket Name, Target Port Number 중에서 하나만 선택해야 합니다.");
						return;
					}
					
					if (targetServiceName != null && targetServiceName != "" && targetServiceName != "NO_SERVICE_CALL") {
						var inputParamType = frm.inputParamType.value;
						
						if (inputParamType == "") {
							alert("Target Service에 대한 Input Parameter Type을 선택해야 합니다.");
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
						
						document.frames["uploadFileForm"].document.uform.docName.value = classCode + businessCode;
						document.frames["uploadFileForm"].document.uform.interfaceID.value = interfaceID;
						document.frames["uploadFileForm"].document.uform.socketServerType.value = "local";
						document.frames["uploadFileForm"].document.uform.submit();
						frm.docName.value = classCode + businessCode;
						frm.schemaDefineFileUpload.value = "Yes";
						frm.schemaDefineFileName.value = schemaDefineFileName;
						setTimeout(function() {frm.submit();}, 500); // 0.5초 후에 pform submit
					} else {
						frm.docName.value = classCode + businessCode;
						frm.schemaDefineFileUpload.value = "No";
						frm.submit();
					}
				} else if (todo == "caldoclength") {
					var recCountFieldName = frm.recCountFieldName.value;
					var schemaDefine = frm.schemaDefine.value;
					
					if (schemaDefine == "") {
						alert("Schema Define을 입력해야 전문길이 계산이 가능합니다.");
						return;
					}
					
					document.frames["calDocLengthSumFrame"].document.lform.recCountFieldName.value = recCountFieldName;
					document.frames["calDocLengthSumFrame"].document.lform.schemaDefine.value = schemaDefine;
					document.frames["calDocLengthSumFrame"].document.lform.submit();
				} else {
					frm.submit();
				}
			}
			
			function setDocLengthSum(lengthSum, alertMsg) {
				if (alertMsg != "") {
					alert(alertMsg);
					return;
				}
				
				document.pform.docLength.value = lengthSum;
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
			
			function makeMainServiceName() {
				var frm = document.pform;
				var interfaceID = frm.interfaceID.value;
				
				frm.targetService.value = ":main_" + interfaceID;
			}
			
			function schemaView(docName, comSchemaService, schemaService) {
				window.open('/JSocketAdapter/basic-docschemadetail.dsp?todo=schemaView&docName=' + docName + '&commSchemaDefineService=' + comSchemaService + '&schemaDefineService=' + schemaService, 'schemaView', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
			}
			
			function setSpecifiedNumber(selValue) {
				var frm = document.pform;
				
				if (selValue == "No") {
					frm.tmpSequenceRule2.value = "NSN";
					frm.sequenceRule2.value = "NSN";
					frm.tmpSequenceRule2.disabled = true;
				} else {
					frm.tmpSequenceRule2.value = "";
					frm.sequenceRule2.value = "";
					frm.tmpSequenceRule2.disabled = false;
				}
			}
			
			function setSequenceLength(selValue) {
				var frm = document.pform;
				
				if (selValue == "No") {
					frm.tmpSequenceRule5.value = "NSL";
					frm.sequenceRule5.value = "NSL";
					frm.tmpSequenceRule5.disabled = true;
				} else {
					frm.tmpSequenceRule5.value = "";
					frm.sequenceRule5.value = "";
					frm.tmpSequenceRule5.disabled = false;
				}
			}
			
			function setDelimiterCharacter(selValue) {
				var frm = document.pform;
				
				if (selValue == "No") {
					frm.sequenceRule7.value = "";
					frm.sequenceRule7.disabled = true;
				} else {
					frm.sequenceRule7.value = "";
					frm.sequenceRule7.disabled = false;
				}
			}
			
			function addValue() {
				var frm = document.pform;
				var sequenceRule1 = frm.sequenceRule1.value;
				var sequenceRule4 = frm.sequenceRule4.value;
				var sequenceRule6 = frm.sequenceRule6.value;
				var sequenceRule7 = frm.sequenceRule7.value;
				
				if (sequenceRule1 == "Yes") {
					frm.sequenceRule2.value = frm.tmpSequenceRule2.value;
				}
				
				if (sequenceRule4 == "Yes") {
					frm.sequenceRule5.value = frm.tmpSequenceRule5.value;
				}
				
				if (sequenceRule6 == "Yes") {
					if (sequenceRule7 == "") {
						alert("Delimiter Character를 입력하십시요.");
						return;
					} else if (sequenceRule7 == "_") {
						sequenceRule7 = "UNDERBAR";
					}
				} else {
					sequenceRule7 = "";
				}
				
				var arraySequenceRule = frm.arraySequenceRule.value;
				var sequenceRule2 = frm.sequenceRule2.value;
				var sequenceRule3 = frm.sequenceRule3.value;
				var sequenceRule5 = frm.sequenceRule5.value;
				
				if (arraySequenceRule == "") {
					if (sequenceRule7 == "") {
						frm.arraySequenceRule.value = sequenceRule2 + "_" + sequenceRule3 + "_" + sequenceRule5;
					} else {
						frm.arraySequenceRule.value = sequenceRule2 + "_" + sequenceRule3 + "_" + sequenceRule5 + "_" + sequenceRule7;
					}
				} else {
					if (sequenceRule7 == "") {
						frm.arraySequenceRule.value = arraySequenceRule + "/" + sequenceRule2 + "_" + sequenceRule3 + "_" + sequenceRule5;
					} else {
						frm.arraySequenceRule.value = arraySequenceRule + "/" + sequenceRule2 + "_" + sequenceRule3 + "_" + sequenceRule5 + "_" + sequenceRule7;
					}
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
			
			var seq = 1;
		</script>
	</head>
	<body onload="javascript:alertMsg()">
		
		%ifvar changed equals('true')%
			%ifvar schemaDefValid equals('false')%
			%else%
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
		<input type="hidden" name="schemaDefineFileUpload" value="">
		<input type="hidden" name="schemaDefUpload" value="%value schemaDefUpload%">
		
		<!-- 전문의 Schema 정의 유효성 검증 결과 오류가 있는 경우 -->
		%ifvar schemaDefValid equals('false')%
		<ul class="listitems">
			<li class="listitem"><a href="basic-docinterfaceid.dsp?todo=docSearch&sDocName=%value docName%">Return to Local Server Socket Doc Information</a></li>
		</ul>
			
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Schema Def Validation Result</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Result</td>
				<td class="evenrow-l" width="70%">%value schemaDefValid%</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Error List</td>
				<td class="evenrow-l" width="70%">
					%loop schemaDefErrorList%
						%value schemaDefErrorList%<br>
					%endloop%
				</td>
			</tr>
		</table>
		%else%
			
		<!-- 전문의 Schema 정의 유효성 검증 결과 오류가 없는 경우 -->
		%ifvar todo equals('docSearch')%
			<input type="hidden" name="docName" value="">		
			<ul class="listitems">
				<li class="listitem"><a href="javascript:doAction('create', '')">Create New Local Server Socket Doc</a></li>	
			</ul>			
		%else%
			%ifvar todo equals('download')%
				<input type="hidden" name="docName" value="">		
					<ul class="listitems">
						<li class="listitem"><a href="javascript:doAction('create', '')">Create New Local Server Socket Doc</a></li>	
					</ul>
			%else%
				<ul class="listitems">
					<li class="listitem"><a href="basic-docinterfaceid.dsp?todo=docSearch&sClassCode=%value sClassCode%&sDocName=%value sDocName%">Return to Local Server Socket Doc Information</a></li>
				</ul>
			%endifvar%
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
						<td class="evenrow-l" width="70%"><input type="text" name="interfaceID" size="20" style="font-size:10pt;width:400" onblur="javascript:makeMainServiceName()"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Description</td>
						<td class="evenrow-l" width="70%"><input type="text" name="description" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Common Header Schema Define Service</td>
						<td class="evenrow-l" width="70%">
							<select name="commSchemaDefineService" style="width:400">
								<option value="">선택</option>
								%loop commSchemaDefServiceList%
									<option value="%value commSchemaDefServiceList%">%value commSchemaDefServiceList%</option>
								%endloop%
							</select>
						</td>
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
						<td class="evenrow-l" width="70%">
							<select name="commonLogicService" style="width:400">
								<option value="">선택</option>
								%loop commonLogicServiceList%
									<option value="%value commonLogicServiceList%">%value commonLogicServiceList%</option>
								%endloop%
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Processing Service Input Parameter Name</td>
						<td class="evenrow-l" width="70%"><input type="text" name="inputName" value="MAIN_DATA" size="20" style="font-size:10pt;width:400"></td>
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
								<option value="Yes">Yes</option>
								<option value="No">No</option>								
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
								<option value="Yes">Yes</option><!-- 전문을 수신한 Socket으로 Ack 전문을 리턴하는 경우 -->
								<option value="YesRSS">YesRSS</option><!-- 전문을 수신한 Socket이 아니고 Remote Server Socket으로 Ack 전문을 리턴하는 경우 -->
							</select>&nbsp;&nbsp;&nbsp;&nbsp;
							<!-- 현대제철 전용 -->
							%ifvar customerCode equals('HSC')%
								Acknowledgement Send Service&nbsp;
								<select name="ackService" style="width:400">
									<option value="">선택</option>
									%loop anbServiceList%
										<option value="%value anbServiceList%">%value anbServiceList%</option>
									%endloop%
								</select><br>
								Acknowledgement Doc ID&nbsp;<input type="text" name="ackDocID" value="" size="20" style="font-size:10pt;width:100">&nbsp;&nbsp;&nbsp;&nbsp;
								Acknowledgement Socket Name&nbsp;
								<select name="ackSocketName" style="width:400">
									<option value="">선택</option>
									%loop SocketNameDescList%
										<option value="%value socketNameValue%">%value socketNameDisplay%</option>
									%endloop%
								</select>
							%endifvar%
							<!-- 현대제철 전용 -->
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Health Check Doc YN</td>
						<td class="evenrow-l" width="70%">
							<select name="healthCheckDoc" style="width:90">								
								<option value="No">No</option>
								<option value="Yes">Yes</option>
							</select>&nbsp;&nbsp;&nbsp;&nbsp;
							Health Check Interval&nbsp;&nbsp;<input type="text" name="healthCheckInterval" value="" size="20" style="font-size:10pt;width:50">&nbsp;(초단위)&nbsp;&nbsp;&nbsp;&nbsp;
							<!-- 현대제철 전용 -->
							%ifvar customerCode equals('HSC')%
								Health Check Doc Body Content&nbsp;&nbsp;<input type="text" name="healthCheckBody" value="" size="20" style="font-size:10pt;width:200">&nbsp;(EAI to L2 Health Check 전문인 경우에 입력)
							%endifvar%
							<!-- 현대제철 전용 -->
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Messaging Use YN</td>
						<td class="evenrow-l" width="70%">
							<select name="messagingUse" style="width:90">
								<option value="Yes">Yes</option>
								<option value="No">No</option>								
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">JMS Send Queue/Topic Name</td>
						<td class="evenrow-l" width="70%">
							<select name="jmsSendQueue" style="width:400">
								<option value="">선택</option>
								%loop queueTopicList%
									<option value="%value queueTopicList%">%value queueTopicList%</option>
								%endloop%
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Publishing Document Type Name</td>
						<td class="evenrow-l" width="70%">
							<select name="publishDocType" style="width:400">
								<option value="">선택</option>
								%loop docTypeList%
									<option value="%value docTypeList%">%value docTypeList%</option>
								%endloop%
							</select>
						</td>
					</tr>					
					<tr>
						<td class="evenrow" width="30%">Listening Port</td>
						<td class="evenrow-l" width="70%">
							<select name="portNumber" style="width:90">
								<option value="">선택</option>								
								%loop portList%
									<option value="%value portList%">%value portList%</option>
								%endloop%
								<option value="MultiPort">Multi Port</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Target System Name</td>
						<td class="evenrow-l" width="70%">
							<select name="targetSystemName" style="width:400">
								%loop SystemNameDescList%
									<option value="%value systemNameValue%">%value systemNameDisplay%</option>
								%endloop%
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Target Socket Name</td>
						<td class="evenrow-l" width="70%">
							<select name="targetSocketName" style="width:400">
								<option value="">선택</option>
								%loop SocketNameDescList%
									<option value="%value socketNameValue%">%value socketNameDisplay%</option>
								%endloop%
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Target Port Number</td>
						<td class="evenrow-l" width="70%">
							<select name="targetPortNumber" style="width:90">
								<option value="">선택</option>								
								%loop portList%
									<option value="%value portList%">%value portList%</option>
								%endloop%
							</select>
						</td>
					</tr>
					<!-- 현대제철 전용 -->
					%ifvar customerCode equals('HSC')%
					<tr>
						<td class="evenrow" width="30%">Target Service</td>
						<td class="evenrow-l" width="70%">
							<select name="targetServiceName" style="width:400">
								<option value="">선택</option>								
								%loop targetServiceList%
									<option value="%value targetServiceList%">%value targetServiceList%</option>
								%endloop%
							</select>&nbsp;&nbsp;&nbsp;&nbsp;Input Parameter Type&nbsp;
							<select name="inputParamType" style="width:100">
								<option value="">선택</option>
								<option value="JDTO">JDTO Record</option>
								<option value="String">String</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Target Service System Name</td>
						<td class="evenrow-l" width="70%">
							<select name="targetServiceSystemName" style="width:400">
								<option value="">선택</option>								
								%loop EjbSystemNameDescList%
									<option value="%value systemNameValue%">%value systemNameDisplay%</option>
								%endloop%
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Multi Record Sequence Rule</td>
						<td class="evenrow-l" width="70%">
							Specified Number Apply&nbsp;
							<select name="sequenceRule1" onchange="javascript:setSpecifiedNumber(this.value)">
								<option value="No">No</option>
								<option value="Yes">Yes</option>
							</select>&nbsp;
							<input type="text" name="tmpSequenceRule2" value="NSN" disabled size="20" style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;
							<input type="hidden" name="sequenceRule2" value="NSN">
							Sequence Rule&nbsp;
							<select name="sequenceRule3"">
								<option value="NS">NS : No Sequence</option>
								<option value="IS">IS : Loop Index Sequence</option>
							</select>&nbsp;&nbsp;&nbsp;
							Sequence Length Apply&nbsp;
							<select name="sequenceRule4" onchange="javascript:setSequenceLength(this.value)">
								<option value="No">No</option>
								<option value="Yes">Yes</option>
							</select>&nbsp;
							<input type="text" name="tmpSequenceRule5" value="NSL" disabled size="20" style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;
							<input type="hidden" name="sequenceRule5" value="NSL">
							Delimiter Character&nbsp;
							<select name="sequenceRule6" onchange="javascript:setDelimiterCharacter(this.value)">
								<option value="No">No</option>
								<option value="Yes">Yes</option>
							</select>&nbsp;
							<input type="text" name="sequenceRule7" value="" disabled size="20" style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;
							<input type="button" name="ADDVALUE" value="Add Value"  onclick="return addValue()"></input><br>
							<input type="text" name="arraySequenceRule" size="20" style="font-size:10pt;width:800">
						</td>
					</tr>
					%endifvar%
					<!-- 현대제철 전용 -->
					<tr>
						<td class="evenrow" width="30%">Multi Record Count Field Name</td>
						<td class="evenrow-l" width="70%"><input type="text" name="recCountFieldName" size="20" style="font-size:10pt;width:400"> (여러 개의 Field Name 입력 필요 시에는 '/' 를 구분자로 해서 입력)</td>
					</tr>					
					<tr>
						<td class="evenrow" width="30%">Schema Define</td>
						<td class="evenrow-l" width="70%"><textarea name="schemaDefine" cols="100" rows="20"></textarea></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Schema Define File</td>
						<td class="evenrow-l" width="70%">
							<iframe id="uploadFileFrame" name="uploadFileForm" src="basic-docuploadiframe.dsp" style="width:600;height:40;border:0;display:;">
		                    </iframe>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Doc Length</td>
						<td class="evenrow-l" width="70%"><input type="text" name="docLength" size="20" style="font-size:10pt;width:400">&nbsp;<input type="button" name="SUBMIT" value="Calculate Doc Length"  onclick="return doAction('caldoclength', '')"></input></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Change Sending Doc Length</td>
						<td class="evenrow-l" width="70%">
							<select name="changeDocLength" style="width:100">
								<option value="">선택</option>
								<option value="HB">Header + Body</option>
								<option value="OB">Only Body</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Schema Document Type Name</td>
						<td class="evenrow-l" width="70%"><input type="text" name="schemaDocType" size="20" style="font-size:10pt;width:400"></td>
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
						<td class="action" colspan="2">
							<input type="hidden" name="schemaDefineFileName" value="">
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
							<td class="evenrow-l" width="70%">
								<select name="commSchemaDefineService" style="width:400">
									<option value="">선택</option>
									%loop commSchemaDefServiceList%
										<option value="%value commSchemaDefServiceList%">%value commSchemaDefServiceList%</option>
									%endloop%
								</select>
								<script language="javascript">
									document.pform.commSchemaDefineService.value = "%value commSchemaDefineService%";
								</script>
							</td>
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
							<td class="evenrow-l" width="70%"><input type="hidden" name="orgCommonLogicService" value="%value commonLogicService%">
								<select name="commonLogicService" style="width:400">
									<option value="">선택</option>
									%loop commonLogicServiceList%
										<option value="%value commonLogicServiceList%">%value commonLogicServiceList%</option>
									%endloop%
								</select>
								<script language="javascript">
									document.pform.commonLogicService.value = "%value commonLogicService%";
								</script>
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
									<option value="Yes">Yes</option>
									<option value="No">No</option>									
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
									<option value="Yes">Yes</option><!-- 전문을 수신한 Socket으로 Ack 전문을 리턴하는 경우 -->
									<option value="YesRSS">YesRSS</option><!-- 전문을 수신한 Socket이 아니고 Remote Server Socket으로 Ack 전문을 리턴하는 경우 -->
								</select>
								<script language="javascript">
									document.pform.returnResponse.value = "%value returnResponse%";
								</script>&nbsp;&nbsp;&nbsp;&nbsp;
								<!-- 현대제철 전용 -->
								%ifvar customerCode equals('HSC')%
									Acknowledgement Send Service&nbsp;
									<select name="ackService" style="width:400">
										<option value="">선택</option>
										%loop anbServiceList%
											<option value="%value anbServiceList%">%value anbServiceList%</option>
										%endloop%
									</select>
									<script language="javascript">
										document.pform.ackService.value = "%value ackService%";
									</script><br>
								    Acknowledgement Doc ID&nbsp;<input type="text" name="ackDocID" value="%value ackDocID%" size="20" style="font-size:10pt;width:100">&nbsp;&nbsp;&nbsp;&nbsp;
									Acknowledgement Socket Name&nbsp;
									<select name="ackSocketName" style="width:400">
										<option value="">선택</option>
										%loop SocketNameDescList%
											<option value="%value socketNameValue%">%value socketNameDisplay%</option>
										%endloop%
									</select>
									<script language="javascript">
										document.pform.ackSocketName.value = "%value ackSocketName%";
									</script>
								%endifvar%
								<!-- 현대제철 전용 -->
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Health Check Doc YN</td>
							<td class="evenrow-l" width="70%">
								<select name="healthCheckDoc" style="width:90">								
									<option value="No">No</option>
									<option value="Yes">Yes</option>
								</select>
								<script language="javascript">
									document.pform.healthCheckDoc.value = "%value healthCheckDoc%";
								</script>&nbsp;&nbsp;&nbsp;&nbsp;
								Health Check Interval&nbsp;&nbsp;<input type="text" name="healthCheckInterval" value="%value healthCheckInterval%" size="20" style="font-size:10pt;width:50">&nbsp;(초단위)&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="hidden" name="oldHealthCheckInterval" value="%value healthCheckInterval%">
								<!-- 현대제철 전용 -->
								%ifvar customerCode equals('HSC')%
									Health Check Doc Body Content&nbsp;&nbsp;<input type="text" name="healthCheckBody" value="%value healthCheckBody%" size="20" style="font-size:10pt;width:200">&nbsp;(EAI to L2 Health Check 전문인 경우에 입력)
								%endifvar%
								<!-- 현대제철 전용 -->
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Messaging Use YN</td>
							<td class="evenrow-l" width="70%">
								<select name="messagingUse" style="width:90">
									<option value="Yes">Yes</option>
									<option value="No">No</option>								
								</select>
								<script language="javascript">
									document.pform.messagingUse.value = "%value messagingUse%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">JMS Send Queue/Topic Name</td>
							<td class="evenrow-l" width="70%">
								<select name="jmsSendQueue" style="width:400">
									<option value="">선택</option>
									%loop queueTopicList%
										<option value="%value queueTopicList%">%value queueTopicList%</option>
									%endloop%
								</select>
								<script language="javascript">
									document.pform.jmsSendQueue.value = "%value jmsSendQueue%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Publishing Document Type Name</td>
							<td class="evenrow-l" width="70%">
								<select name="publishDocType" style="width:400">
									<option value="">선택</option>
									%loop docTypeList%
										<option value="%value docTypeList%">%value docTypeList%</option>
									%endloop%
								</select>
								<script language="javascript">
									document.pform.publishDocType.value = "%value publishDocType%";
								</script>
							</td>
						</tr>						
						<tr>
							<td class="evenrow" width="30%">Listening Port</td>
							<td class="evenrow-l" width="70%">
								<select name="portNumber" style="width:90">
									<option value="">선택</option>									
									%loop portList%
										<option value="%value portList%">%value portList%</option>
									%endloop%
									<option value="MultiPort">Multi Port</option>
								</select>
								<script language="javascript">
									document.pform.portNumber.value = "%value portNumber%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Target System Name</td>
							<td class="evenrow-l" width="70%">
								<select name="targetSystemName" style="width:400">
									%loop SystemNameDescList%
										<option value="%value systemNameValue%">%value systemNameDisplay%</option>
									%endloop%
								</select>
								<script language="javascript">
									document.pform.targetSystemName.value = "%value targetSystemName%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Target Socket Name</td>
							<td class="evenrow-l" width="70%">
								<select name="targetSocketName" style="width:400">
									<option value="">선택</option>
									%loop SocketNameDescList%
										<option value="%value socketNameValue%">%value socketNameDisplay%</option>
									%endloop%
								</select>
								<script language="javascript">
									document.pform.targetSocketName.value = "%value targetSocketName%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Target Port Number</td>
							<td class="evenrow-l" width="70%">
								<select name="targetPortNumber" style="width:90">
									<option value="">선택</option>									
									%loop portList%
										<option value="%value portList%">%value portList%</option>
									%endloop%
								</select>
								<script language="javascript">
									document.pform.targetPortNumber.value = "%value targetPortNumber%";
								</script>
							</td>
						</tr>
						<!-- 현대제철 전용 -->
						%ifvar customerCode equals('HSC')%
						<tr>
							<td class="evenrow" width="30%">Target Service</td>
							<td class="evenrow-l" width="70%">
								<select name="targetServiceName" style="width:400">
									<option value="">선택</option>								
									%loop targetServiceList%
										<option value="%value targetServiceList%">%value targetServiceList%</option>
									%endloop%
								</select>
								<script language="javascript">
									document.pform.targetServiceName.value = "%value targetServiceName%";
								</script>&nbsp;&nbsp;&nbsp;&nbsp;Input Parameter Type&nbsp;
								<select name="inputParamType" style="width:100">
									<option value="">선택</option>
									<option value="JDTO">JDTO Record</option>
									<option value="String">String</option>
								</select>
								<script language="javascript">
									document.pform.inputParamType.value = "%value inputParamType%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Target Service System Name</td>
							<td class="evenrow-l" width="70%">
								<select name="targetServiceSystemName" style="width:400">
									<option value="">선택</option>								
									%loop EjbSystemNameDescList%
										<option value="%value systemNameValue%">%value systemNameDisplay%</option>
									%endloop%
								</select>
								<script language="javascript">
									document.pform.targetServiceSystemName.value = "%value targetServiceSystemName%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Multi Record Sequence Rule</td>
							<td class="evenrow-l" width="70%">
								Specified Number Apply&nbsp;
								<select name="sequenceRule1" onchange="javascript:setSpecifiedNumber(this.value)">
									<option value="No">No</option>
									<option value="Yes">Yes</option>
								</select>&nbsp;
								<input type="text" name="tmpSequenceRule2" value="NSN" disabled size="20" style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;
								<input type="hidden" name="sequenceRule2" value="NSN">
								Sequence Rule&nbsp;
								<select name="sequenceRule3"">
									<option value="NS">NS : No Sequence</option>
									<option value="IS">IS : Loop Index Sequence</option>
								</select>&nbsp;&nbsp;&nbsp;
								Sequence Length Apply&nbsp;
								<select name="sequenceRule4" onchange="javascript:setSequenceLength(this.value)">
									<option value="No">No</option>
									<option value="Yes">Yes</option>
								</select>&nbsp;
								<input type="text" name="tmpSequenceRule5" value="NSL" disabled size="20" style="font-size:10pt;width:40">&nbsp;&nbsp;&nbsp;
								<input type="hidden" name="sequenceRule5" value="NSL">
								Delimiter Character&nbsp;
								<select name="sequenceRule6" onchange="javascript:setDelimiterCharacter(this.value)">
									<option value="No">No</option>
									<option value="Yes">Yes</option>
								</select>&nbsp;
								<input type="text" name="sequenceRule7" value="" disabled size="20" style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;
								<input type="button" name="ADDVALUE" value="Add Value"  onclick="return addValue()"></input><br>
								<input type="text" name="arraySequenceRule" value="%value arraySequenceRule%" size="20" style="font-size:10pt;width:800">
							</td>
						</tr>
						%endifvar%
						<!-- 현대제철 전용 -->
						<tr>
							<td class="evenrow" width="30%">Multi Record Count Field Name</td>
							<td class="evenrow-l" width="70%"><input type="text" name="recCountFieldName" value="%value recCountFieldName%" size="20" style="font-size:10pt;width:400"> (여러 개의 Field Name 입력 필요 시에는 '/' 를 구분자로 해서 입력)</td>
						</tr>						
						<tr>
							<td class="evenrow" width="30%">Schema Define</td>
							<td class="evenrow-l" width="70%"><textarea name="schemaDefine" cols="100" rows="20"></textarea></td>
						</tr>						
						<tr>
							<td class="evenrow" width="30%">Schema Define File</td>
							<td class="evenrow-l" width="70%">
								<iframe id="uploadFileFrame" name="uploadFileForm" src="basic-docuploadiframe.dsp" style="width:600;height:40;border:0;display:;">
								</iframe>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Doc Length</td>
							<td class="evenrow-l" width="70%"><input type="text" name="docLength" value="%value docLength%" size="20" style="font-size:10pt;width:400">&nbsp;<input type="button" name="SUBMIT" value="Calculate Doc Length"  onclick="return doAction('caldoclength', '')"></input></td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Change Sending Doc Length</td>
							<td class="evenrow-l" width="70%">
								<select name="changeDocLength" style="width:100">
									<option value="">선택</option>
									<option value="HB">Header + Body</option>
									<option value="OB">Only Body</option>
								</select>
								<script language="javascript">
									document.pform.changeDocLength.value = "%value changeDocLength%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Schema Document Type Name</td>
							<td class="evenrow-l" width="70%"><input type="text" name="schemaDocType" value="%value schemaDocType%" size="20" style="font-size:10pt;width:400"></td>
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
							<td class="action" colspan="2">
								<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>
								<input type="hidden" name="sClassCode" value="%value sClassCode%">
								<input type="hidden" name="sDocName" value="%value sDocName%">
								<input type="hidden" name="schemaDefineFileName" value="">
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
					
					<!-- 전문 Schema 정의 엑셀파일 다운로드 시 필요 -->
					<input type="hidden" name="filePath" value="%value filePath%">
					<input type="hidden" name="fileName" value="">
					<input type="hidden" name="moveAction" value="/JSocketAdapter/basic-docinterfaceid.dsp">
						
					<table class="tableForm" width="100%">					
					<tr>
						<td class="heading" colspan=10>Local Server Socket Doc Information</td>
					</tr>
					<tr class="subheading2">
						<td>Seq</td>
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
					%ifvar -notempty DocInterfaceIDConfig/Items%
						%loop DocInterfaceIDConfig/Items%
							<tr>
								<td class="evenrowdata">
									<script language="javascript">
										document.write(seq);
										seq++;
									</script>
								</td>
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
						<tr><td colspan=10>No local server socket docs are currently registered.</td></tr>
					%endifvar%
				</table>
				%endifvar%
			%endifvar%
		%endifvar%
		%endifvar%
		</form>
		<iframe id="calDocLengthSumFrame" name="calDocLengthSumFrame" src="basic-doclengthiframe.dsp" style="display:none;">			
		</iframe>
	</body>
</html>

%endinvoke%