%invoke JSocketAdapter.ADMIN:adminDeployDocSchemaDef%

<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<SCRIPT SRC="%value designPath%webMethods.js.txt"></SCRIPT>

		<script language="javascript">
			function doAction(aDeploying) {
				if (aDeploying == 'search') {
					/* 2022.08.07 수정. 전문 정보는 이미 Deploy 한 상태에서 Schema Define만 수정된 건만 조회 대상이 되는 것이 기본 조건으로 적용되기 때문에 무조건 조회를 하는 것으로 변경됨.
					var sClassCode = document.pform.sClassCode.value;
					var sDocName = document.pform.sDocName.value;
					
					if (sClassCode == "" && sDocName == "") {
						alert("Doc Class Code, Doc Name 조회조건 중에서 적어도 하나 입력해야 합니다.");
						return;
					}
					*/
					
					document.pform.todo.value = "search";
					document.pform.submit();
				} else {
					if (aDeploying == 'remote') {
						document.pform.todo.value = "remote";
					} else if (aDeploying == 'reserve') { // Deploy를 예약시간에 수행하도록 함.
						var sDate = document.pform.sDate.value;
						var sTime = document.pform.sTime.value;
						
						if (sDate == "") {
							alert("예약 날짜를 입력하십시요.");
							return;
						}
						
						if (sTime == "") {
							alert("예약 시간을 입력하십시요.");
							return;
						}
												
						document.pform.todo.value = "reserve";
					}
					
					var targetServerLength = document.pform.targetServer.options.length;
					var remoteAliasList = "";
					
					for (var i = 0; i < targetServerLength; i++) {
						if (document.pform.targetServer.options[i].selected) {
							if (remoteAliasList == "") {
								remoteAliasList = document.pform.targetServer.options[i].value;
							} else {
								remoteAliasList = remoteAliasList + "/" + document.pform.targetServer.options[i].value;
							}
						}
					}
					
					if (remoteAliasList == "") {
						alert("Target Server를 선택하십시요!!!");
						return;
					}
					
					document.pform.targetServers.value = remoteAliasList;
					
					for (var i=0; i < document.pform.length; i++) {
						if (document.pform.elements[i].checked) {
							if (document.pform.selectedList.value == "") {
								document.pform.selectedList.value = document.pform.elements[i].value;
							} else {
								document.pform.selectedList.value = document.pform.selectedList.value + "/" + document.pform.elements[i].value;
							}
						}
					}
				
					if (document.pform.selectedList.value == "") {
						alert("Deploy 할 Doc Name을 선택하십시요.");
						return;
					}
					
					if (aDeploying == 'reserve') {
						// Deploy를 예약하는 경우 예약처리 후 Deploy Config > Doc Schema Reservation 화면으로 이동하고 Deploy Config > Doc Schema Reservation 메뉴에 포커스가 간다.
						parent.menu.menuSelect("ideploy-schemadeployreservation.dsp", "deploy-schemadeployreservation.dsp");
					}
					
					document.pform.submit();
				}
			}
			
			function allChecked() {
				var checkMode = document.pform.checkMode.value;
				var eleName;
				
				if (checkMode == "uncheck") { // All Checked
					for (var i=0; i < document.pform.length; i++) {
						eleName = document.pform.elements[i].name;
						
						if (eleName.indexOf("selectedList") >= 0) {
							if (!document.pform.elements[i].checked) {
								document.pform.elements[i].checked = true;
							}
						}
					}
					
					document.pform.checkMode.value = "check";
				} else { // All Unchecked
					for (var i=0; i < document.pform.length; i++) {
						eleName = document.pform.elements[i].name;
						
						if (eleName.indexOf("selectedList") >= 0) {
							if (document.pform.elements[i].checked) {
								document.pform.elements[i].checked = false;
							}
						}
					}
					
					document.pform.checkMode.value = "uncheck";
				}
			}
			
			function schemaView(docName, comSchemaService, schemaService) {
				var docType = "%value sDocType%";
				
				if (docType == "local") {
					window.open('/JSocketAdapter/basic-docschemadetail.dsp?todo=schemaView&docName=' + docName + '&commSchemaDefineService=' + comSchemaService + '&schemaDefineService=' + schemaService, 'schemaView', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
				} else {
					window.open('/JSocketAdapter/basic-bifdocschemadetail.dsp?todo=schemaView&docName=' + docName + '&commSchemaDefineService=' + comSchemaService + '&schemaDefineService=' + schemaService, 'schemaView', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
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
		%ifvar todo equals('reserve')%
			<!-- Deploy를 예약하는 경우 예약처리 후 Deploy Config > Doc Schema Reservation 화면으로 이동하고 Deploy Config > Doc Schema Reservation 메뉴에 포커스가 간다. -->
			<form name="dform" action="deploy-schemadeployreservation.dsp" method="post">
				<input type="hidden" name="alertMsg" value="%value deployMsg%">
			</form>
			<script langauge='javascript'>
				document.dform.submit();
			</script>
		%endifvar%
		
		%ifvar todo equals('remote')%
		%else%
		<div class="message">이미 Deploy 한 전문 중에서 Schema Define 정보만 수정된 전문들을 조회하고 Schema Define 정보만 다시 Deploy 합니다.</div>
		%endifvar%
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%

		<form name="pform" method="post" target="_self">
			<input type="hidden" name="todo" value="">
			<input type="hidden" name="selectedList" value="">
			<input type="hidden" name="targetServers" value="">
			<input type="hidden" name="remoteInvoke" value="true">
			<input type="hidden" name="checkMode" value="uncheck">
			<input type="hidden" name="alertMsg" value="%value deployMsg%">
			
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					Deploy Config &gt;
					Doc Schema Define
				</td>
			</tr>
		</table>
		
		%ifvar todo equals('remote')%			
			<ul class="listitems">
				<li class="listitem"><a href="deploy-docschemadef.dsp">Return to Doc Schema Define Deployment Information</a></li>
			</ul>
			
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Doc Schema Define Deployment Result</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			
			%ifvar DeployResult -notempty%			
				<table class="tableView" width=100%>
					<tr>
						<td class="heading" colspan=5>Doc Schema Define Information</td>
					</tr>
					<tr class="subheading2">
						<td>Seq</td>
						<td>Target Server</td>
						<td>Doc Name</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>
					</tr>        	
				%loop DeployResult%        	
					<tr>
						<td>%value deployNum%</td>
						<td>%value targetServer%</td>
						<td>%value keyValue%</td>
						<td>%value schemaDefineDeployYN%</td>
						<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
						</td>
					</tr>        		
				%endloop%        	
				</table>        
			%endifvar%			
		%else%
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Doc Schema Define Deployment</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Target Server</td>
					<td class="evenrow-l" width="70%">
						<!-- 하나만 선택한 경우에는 targetServer 라는 이름으로 선택한 값이 flow service에 전달되고
							두 개 이상을 선택한 경우에는 targetServer 라는 이름으로 첫번째 선택한 값과
							targetServerList 라는 이름으로(자동으로 생성됨) 선택한 모든 값이 StringList 형태로
							flow service에 전달된다. -->
						<select name="targetServer" style="width:90" size=3 multiple>
							%loop remoteServerList%
								<option value="%value remoteServerList%">%value remoteServerList%</option>
							%endloop%
						</select>
					</td>
				</tr>
				<!-- 2022.08.07 수정. Basic Info > Interface Doc 메뉴에서 관리하는 Schema Define 정보만 Deploy 하는 것으로 변경
				<tr>
					<td class="evenrow" width="30%">Doc Type</td>
					<td class="evenrow-l" width="70%">
						<select name="sDocType" style="width:200">
							<option value="local">Interface Doc</option>
							<option value="remote">Business Doc</option>
						</select>
						<script language="javascript">
							document.pform.sDocType.value = "%value sDocType%";
						</script></td>
					</td>
				</tr>
				-->
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
					<td class="evenrow" width="30%">Reservation Time</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="sDate" value="%value sDate%" size="5" style="font-size:10pt;width:100">&nbsp;YYYY/MM/DD&nbsp;
						<input type="text" name="sTime" value="%value sTime%" size="5" style="font-size:10pt;width:100">&nbsp;HH:MM:SS
					</td>
				</tr>
				<tr>
					<td class="action" colspan="2">						
						<input type="button" name="SUBMIT" value="Search Doc"  onclick="return doAction('search')"></input>&nbsp;&nbsp;
						<input type="button" name="SUBMIT" value="Deploy Doc Schema"  onclick="return doAction('remote')"></input></input>&nbsp;&nbsp;
						<input type="button" name="SUBMIT" value="Reserve Deployment"  onclick="return doAction('reserve')"></input>
					</td>
				</tr>
			</table>
	
			<table class="tableView" width=100%>
				<tr>
					<td class="heading" colspan=7>Doc Schema Define Infos Changed</td>
				</tr>
				<tr class="subheading2">
					<td>Select <a href="javascript:allChecked()">All</a></td>
					<td>Doc Name</td>
					<td>Doc Class Code (전문종별코드)</td>
					<td>Doc Business Code (전문업무구분코드)</td>
					<td>Interface ID</td>
					<td>Description</td>
					<td>Schema</td>
				</tr>
				%ifvar -notempty DocInterfaceIDInfoList%
					%loop DocInterfaceIDInfoList -$index%
						<tr>
							<td class="evenrowdata"><input type="checkbox" name="selectedList%value $index%" value="%value docName%">
							<td>%value docName%</td>
							<td>%value classCode%</td>
							<td>%value businessCode%</td>
							<td>%value interfaceID%</td>
							<td>%value description%</td>
							<td class="evenrowdata">
								<a href="javascript:schemaView('%value docName%', '%value commSchemaDefineService%', '')"><img src="%value ../../designPath%icons/file.gif" alt="View" border="0"></a>
							</td>
						</tr>					
					%endloop%
				%else%
					<tr><td colspan=7>No doc schema defines are currently registered.</td></tr>
				%endifvar%
			</table>
		%endifvar%
		</form>
	</body>
</html>

%endinvoke%