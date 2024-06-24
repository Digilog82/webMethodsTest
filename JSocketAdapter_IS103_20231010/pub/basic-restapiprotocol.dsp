%invoke JSocketAdapter.ADMIN:adminRestDocIDExtract%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script src="stats/js/jquery-3.6.0.min.js"></script>
		<script language="javascript">
			// 등록, 수정하기 전에 Service Full Name을 입력하는 필드에 대해서 입력한 Service가 실제로 존재하는지 먼저 체크한다.
			function checkServiceNode(aTodo) {
				$("#todo").val(aTodo);
				
				var chkHttpHeaders = "";
				
				for (var i = 0; i < $("#tempHttpHeaders option").length; i++) {
					// 참고) 특정 Option을 선택하기 : $("#tempHttpHeaders option:eq(" + i + ")").attr("selected", true);
					
					if (chkHttpHeaders == "") {
						chkHttpHeaders = $("#tempHttpHeaders option:eq(" + i + ")").val();
					} else {
						chkHttpHeaders = chkHttpHeaders + "^" + $("#tempHttpHeaders option:eq(" + i + ")").val();
					}
				}
				
				$("#checkHttpHeaders").val(chkHttpHeaders);
				
				$.ajax({
					type : "POST",
					url : "/invoke/JSocketAdapter.ADMIN/serviceNodeExists",
					cache : false,
					data : $("form").serialize(),
					dataType : "json",
					async : true,
					success : function(result) {
								if (result.exists == "true") {
									// Service가 실제로 존재하는 경우 등록 또는 수정처리를 계속 진행한다.
									doAction(aTodo, "");
								} else {
									alert(result.existsMsg);
								}
							  },
					error : function() {
								alert("Service Node 존재여부를 체크하는 중에 에러가 발생하였습니다 !!!");
					        }
				});
			};
			
			function doAction(todo, rName){
				var frm = document.pform;
				frm.todo.value = todo;
				
				if (rName != '') {
					frm.restName.value = rName;
				}
				
				if (todo == 'delete') {
					if(confirm("Do you really want to delete config of  " + rName)){
						frm.submit();
					}
				} else if (todo == 'add' || todo == 'update') {
					var systemName = frm.systemName.value;
					var businessName = frm.businessName.value;
					var tempDocIdPaths = frm.tempDocIdPaths;
					var tempHttpHeaders = frm.tempHttpHeaders;
					var dLength = tempDocIdPaths.options.length;
					var hLength = tempHttpHeaders.options.length;
					var internalClientID = frm.internalClientID.value;
					var internalClientSecret = frm.internalClientSecret.value;
					var authClientID = frm.authClientID.value;
					var authClientSecret = frm.authClientSecret.value;
					var targetClientID = frm.targetClientID.value;
					var targetClientSecret = frm.targetClientSecret.value;
					var ssNamePath = frm.ssNamePath.value;
					var tsNamePath = frm.tsNamePath.value;
					
					if (systemName == "") {
						alert("API System Name을 선택하십시요.");
						return;
					}
					
					if (businessName == "") {
						alert("API Business Name을 선택하십시요.");
						return;
					}										
					
					if (internalClientID != "") {
						if (internalClientSecret == "") {
							alert("Internal API Client Password를 입력하십시요.");
							return;
						}
					}
					
					if (authClientID != "") {
						if (authClientSecret == "") {
							alert("Access Token Client Password를 입력하십시요.");
							return;
						}
					}
					
					if (targetClientID != "") {
						if (targetClientSecret == "") {
							alert("Target API Client Password를 입력하십시요.");
							return;
						}
					}
										
					if (dLength == 0) {
					} else if (dLength == 1) {
						frm.docIdPath.value = tempDocIdPaths.options[0].value;
					} else {					
						// Doc ID Path List 전체를 선택한 것으로 처리
						for (var i = 0; i < dLength; i++) {
							tempDocIdPaths.options[i].selected = true;
						}
					}
					
					if (hLength == 0) {
					} else if (hLength == 1) {
						frm.httpHeader.value = tempHttpHeaders.options[0].value;
					} else {					
						// Http Header List 전체를 선택한 것으로 처리
						for (var i = 0; i < hLength; i++) {
							tempHttpHeaders.options[i].selected = true;
						}
					}
					
					if (ssNamePath == "RootDoc/") {
						frm.ssNamePath.value = "";
					}
					
					if (tsNamePath == "RootDoc/") {
						frm.tsNamePath.value = "";
					}
					
					frm.restName.value = systemName + "_" + businessName;
					
					frm.submit();
				} else {
					frm.submit();
				}
			}								
			
			function makeBusinessName(systemName) {
				var businessName = document.pform.businessName;
				var todo = "%value todo%";
				
				if (systemName == '') {
					// 기존의 Option 삭제
					while (businessName.options.length > 0) {
						businessName.options.remove(0);
					}
					
					businessName.options[0] = new Option("업무명", "");
				} else {				
					for (var i=0; i < document.pform.length; i++) {
						if (document.pform.elements[i].name == systemName) {
							var businessNames = document.pform.elements[i].value;
							var tockens = businessNames.split("/");
						  
							// 기존의 Option 삭제
							while (businessName.options.length > 0) {
								businessName.options.remove(0);
							}
						
							// 해당 System Name에 속한 Business Name Option 추가
							businessName.options[0] = new Option("업무명", "");
							for (var i = 0; i < tockens.length; i++) {
								businessName.options[i + 1] = new Option(tockens[i], tockens[i]);
							}
						
							break;
						}
					}
				}
				
				//makeRestName("systemName");
			}
			
			function makeRestName(type) {
				var frm = document.pform;
				var systemName = frm.systemName.value;
				var businessName = frm.businessName.value;
				
				if (type == "systemName") {
					if (systemName == "") {
						alert("API System Name을 선택하십시요.");
						frm.tempRestName.value = "";
						return;
					}
					
					if (businessName == "") {
						frm.tempRestName.value = "";
					} else {
						frm.tempRestName.value = systemName + "_" + businessName;
					}
				} else {
					if (systemName == "") {
						alert("API System Name을 선택하십시요.");
						frm.tempRestName.value = "";
						return;
					}
					
					if (businessName == "") {
						alert("API Business Name을 선택하십시요.");
						frm.tempRestName.value = "";
						return;
					}
				
					frm.tempRestName.value = systemName + "_" + businessName;
				}
			}
			
			function addDocIdPath() {
				var tempDocIdPaths = document.pform.tempDocIdPaths;
				var tempDocIdPath = document.pform.tempDocIdPath.value;
				
				if (tempDocIdPath == "") {
					alert("Doc ID Path를 입력하십시요.");
					document.pform.tempDocIdPath.value = "RootDoc/";
					return;
				} else if (tempDocIdPath == "RootDoc/") {
					alert("RootDoc/ 이후의 Path를 입력하십시요.");
					return;
				}
				
				if (tempDocIdPath.startsWith("RootDoc/")) {				
				} else {
					alert("Doc ID Path는 RootDoc/ 로 시작해야 합니다.");
					document.pform.tempDocIdPath.value = "RootDoc/";
					return;
				}
				
				// Doc ID Path 중복 체크
				var dIdLength = tempDocIdPaths.options.length;
				for (var i=0; i < dIdLength; i++) {
					var dID = tempDocIdPaths.options[i].value;
					
					if (tempDocIdPath == dID) {
						alert("Doc ID Path " + tempDocIdPath + "는 이미 추가되어 있습니다.");
						return;
					}
				}
				
				tempDocIdPaths.options[dIdLength] = new Option(tempDocIdPath, tempDocIdPath);
				document.pform.tempDocIdPath.value = "RootDoc/";
			}
			
			function deleteDocIdPath() {
				var tempDocIdPaths = document.pform.tempDocIdPaths;
				var dIdLength = tempDocIdPaths.options.length;
				
				var optionIndex = 0;
				var newValueLength;
				var selectYN = "false";
				
				for (var i = 0; i < dIdLength; i++) {
					if (tempDocIdPaths.options[optionIndex].selected) {
						document.pform.tempDocIdPath.value = "RootDoc/";
						tempDocIdPaths.options.remove(optionIndex);
						selectYN = "true";
					} else {
						optionIndex++;
					}
					
					newValueLength = tempDocIdPaths.options.length;
					
					if (optionIndex > (newValueLength-1)) {
						break;
					}
				}
				
				if (selectYN == "false") {
					alert("삭제할 Doc ID Path를 선택하십시요.");
					return;
				}
			}
			
			function updateDocIdPath() {
				var tempDocIdPaths = document.pform.tempDocIdPaths;
				var dIdLength = tempDocIdPaths.options.length;
				var tempDocIdPath = document.pform.tempDocIdPath.value;
				var optionIndex = 0;
				var selectYN = "false";
				
				if (tempDocIdPath == "") {
					alert("Doc ID Path를 입력하십시요.");
					document.pform.tempDocIdPath.value = "RootDoc/";
					return;
				} else if (tempDocIdPath == "RootDoc/") {
					alert("RootDoc/ 이후의 Path를 입력하십시요.");
					return;
				}
				
				if (tempDocIdPath.startsWith("RootDoc/")) {				
				} else {
					alert("Doc ID Path는 RootDoc/ 로 시작해야 합니다.");
					document.pform.tempDocIdPath.value = "RootDoc/";
					return;
				}
				
				// Doc ID Path 중복 체크
				for (var i=0; i < dIdLength; i++) {
					var dID = tempDocIdPaths.options[i].value;
					
					if (tempDocIdPath == dID) {
						alert("Doc ID Path " + tempDocIdPath + "는 이미 추가되어 있습니다.");
						return;
					}
				}
				
				for (var i = 0; i < dIdLength; i++) {
					if (tempDocIdPaths.options[optionIndex].selected) {
						tempDocIdPaths.options[optionIndex] = new Option(tempDocIdPath, tempDocIdPath);
						selectYN = "true";
						break;
					} else {
						optionIndex++;
					}
				}
				
				if (selectYN == "false") {
					alert("수정할 Doc ID Path를 먼저 선택하십시요.");
					return;
				}
				
				document.pform.tempDocIdPath.value = "RootDoc/";
			}
			
			function setUpdateDocIdPath(dMethod) {
				document.pform.tempDocIdPath.value = dMethod;
			}
			
			function addHttpHeader() {
				var tempHttpHeaders = document.pform.tempHttpHeaders;
				var tempHeaderName = document.pform.tempHeaderName.value;
				var tempHeaderValue = document.pform.tempHeaderValue.value;
				var tempHeaderService = document.pform.tempHeaderService.value;
				
				if (tempHeaderName == "") {
					alert("Http Header Name을 입력하십시요.");
					return;
				}
				
				if (tempHeaderValue == "" && tempHeaderService == "") {
					alert("Http Header Value, Service 중에서 하나를 입력하십시요.");
					return;
				}
				
				if (tempHeaderValue != "" && tempHeaderService != "") {
					alert("Http Header Value, Service 중에서 하나만 입력하십시요.");
					return;
				}
				
				if (tempHeaderValue == "") {
					tempHeaderValue = "NA";
				}
				
				if (tempHeaderService == "") {
					tempHeaderService = "NA";
				}
				
				var headerNV = tempHeaderName + "|" + tempHeaderValue + "|" + tempHeaderService;
				
				// Http Header Name 중복 체크
				var hNLength = tempHttpHeaders.options.length;
				for (var i=0; i < hNLength; i++) {
					var hNV = tempHttpHeaders.options[i].value;
					var hNVs = hNV.split("|");
					var hN = hNVs[0];
					
					if (tempHeaderName == hN) {
						alert("Http Header Name " + tempHeaderName + "는 이미 추가되어 있습니다.");
						return;
					}
				}
				
				tempHttpHeaders.options[hNLength] = new Option(headerNV, headerNV);
				document.pform.tempHeaderName.value = "";
				document.pform.tempHeaderValue.value = "";
				document.pform.tempHeaderService.value = "";
			}
			
			function deleteHttpHeader() {
				var tempHttpHeaders = document.pform.tempHttpHeaders;
				var hNLength = tempHttpHeaders.options.length;
				
				var optionIndex = 0;
				var newValueLength;
				var selectYN = "false";
				
				for (var i = 0; i < hNLength; i++) {
					if (tempHttpHeaders.options[optionIndex].selected) {
						document.pform.tempHeaderName.value = "";
						document.pform.tempHeaderValue.value = "";
						document.pform.tempHeaderService.value = "";
						tempHttpHeaders.options.remove(optionIndex);
						selectYN = "true";
					} else {
						optionIndex++;
					}
					
					newValueLength = tempHttpHeaders.options.length;
					
					if (optionIndex > (newValueLength-1)) {
						break;
					}
				}
				
				if (selectYN == "false") {
					alert("삭제할 Http Header Name:Value를 선택하십시요.");
					return;
				}
			}
			
			function updateHttpHeader() {
				var tempHttpHeaders = document.pform.tempHttpHeaders;
				var hNLength = tempHttpHeaders.options.length;
				var tempHeaderName = document.pform.tempHeaderName.value;
				var tempHeaderValue = document.pform.tempHeaderValue.value;
				var tempHeaderService = document.pform.tempHeaderService.value;
				var optionIndex = 0;
				var selectYN = "false";
				
				if (tempHeaderName == "") {
					alert("Http Header Name을 입력하십시요.");
					return;
				}
				
				if (tempHeaderValue == "" && tempHeaderService == "") {
					alert("Http Header Value, Service 중에서 하나를 입력하십시요.");
					return;
				}
				
				if (tempHeaderValue != "" && tempHeaderService != "") {
					alert("Http Header Value, Service 중에서 하나만 입력하십시요.");
					return;
				}
				
				if (tempHeaderValue == "") {
					tempHeaderValue = "NA";
				}
				
				if (tempHeaderService == "") {
					tempHeaderService = "NA";
				}
				
				var headerNV = tempHeaderName + "|" + tempHeaderValue + "|" + tempHeaderService;
				
				// Http Header Name 중복 체크
				for (var i=0; i < hNLength; i++) {
					var hNV = tempHttpHeaders.options[i].value;
					var hNVs = hNV.split("|");
					var hN = hNVs[0];
					
					if (tempHeaderName == hN) {
						if (confirm("Http Header Name " + tempHeaderName + "는 이미 추가되어 있습니다.\nValue 또는 Service만 수정하시겠습니까?")) {
							break;
						} else {
							return;
						}
					}
				}
								
				for (var i = 0; i < hNLength; i++) {
					if (tempHttpHeaders.options[optionIndex].selected) {
						tempHttpHeaders.options[optionIndex] = new Option(headerNV, headerNV);
						selectYN = "true";
						break;
					} else {
						optionIndex++;
					}
				}
				
				if (selectYN == "false") {
					alert("수정할 Http Header를 먼저 선택하십시요.");
					return;
				}
				
				document.pform.tempHeaderName.value = "";
				document.pform.tempHeaderValue.value = "";
				document.pform.tempHeaderService.value = "";
			}
			
			function setUpdateHttpHeader(hHeader) {
				var hNVs = hHeader.split("|");
				var tempHeaderName = hNVs[0];
				var tempHeaderValue = hNVs[1];
				var tempHeaderService = hNVs[2];
				
				if (tempHeaderValue == "NA") {
					tempHeaderValue = "";
				}
				
				if (tempHeaderService == "NA") {
					tempHeaderService = "";
				}
				
				document.pform.tempHeaderName.value = tempHeaderName;
				document.pform.tempHeaderValue.value = tempHeaderValue;
				document.pform.tempHeaderService.value = tempHeaderService;
			}
			
			function initBusinessName() {
				// 상세화면으로 이동 시 System Name에 대한 Business Name 셋팅하기
				var todo = "%value todo%";
				var businessName = "%value businessName%";
				
				if (todo == "read") {
					var systemName = document.pform.systemName.value;
					
					makeBusinessName(systemName);
					
					if (todo == "read" && businessName != "") {
						document.pform.businessName.value = businessName;
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
		</script>
	</head>
	<body onload="javascript:alertMsg(); initBusinessName()">
		
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
						REST API Protocol &gt;
						Create REST API Protocol
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						    REST API Protocol &gt;
							Edit REST API Protocol
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						    REST API Protocol
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		<input type="hidden" id="todo" name="todo" value="">
		<input type="hidden" name="oldRestName" value="%value restName%">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		
		%loop businessNameList%		
			<input type="hidden" name="%value systemName%" value="%value businessName%">			
		%endloop%
		
		%ifvar todo -notempty%
			<ul class="listitems">
				<li class="listitem"><a href="basic-restapiprotocol.dsp">Return to REST API Protocol Information</a></li>					
			</ul>			
		%else%
			<input type="hidden" name="restName" value="">
			<ul class="listitems">
				<li class="listitem"><a href="javascript:doAction('create', '')">Create New REST API Protocol</a></li>
			</ul>
		%endifvar%
		
		<table class="tableForm" width="100%">	
			%ifvar todo equals('create')%
				<tr>
					<td class="heading" colspan="2">REST API Protocol Properties</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Name</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="tempRestName" disabled size="20" style="font-size:10pt;width:200">
						<input type="hidden" name="restName" value="">
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">API System Name</td>
					<td class="evenrow-l" width="70%">
						<select name="systemName" style="width:100" onchange="javascript:makeBusinessName(this.value)">
							<option value="">시스템명</option>
							%loop systemNameList%
								<option value="%value systemNameList%">%value systemNameList%</option>
							%endloop%
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">API Business Name</td>
					<td class="evenrow-l" width="70%">
						<select name="businessName" style="width:100" onchange="javascript:makeRestName('businessName')">
							<option value="">업무명</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Description</td>
					<td class="evenrow-l" width="70%"><input type="text" name="description" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow">Conversion Encoding</td>
					<td class="evenrow-l">
						<select name="charSet" style="width:100">
							%loop charSetList%
								<option value="%value charSetList%">%value charSetList%</option>
							%endloop%
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Doc ID Path</td>
					<td class="evenrow-l" width="70%"><input type="text" name="tempDocIdPath" value="RootDoc/" size="20" style="font-size:10pt;width:400">&nbsp;
						                              <input type="button" name="ADDVALUE" value="Add Value"  onclick="return addDocIdPath()"></input>&nbsp;
							                          <input type="button" name="ADDVALUE" value="Update Value"  onclick="return updateDocIdPath()"></input>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Doc ID Path List</td>
					<td class="evenrow-l" width="70%">
						<select name="tempDocIdPaths" style="width:400" size=5 multiple onclick="setUpdateDocIdPath(this.value)">
						</select>&nbsp;
						<input type="button" name="DELETEVALUE" value="Delete Value"  onclick="return deleteDocIdPath()"></input>
						<input type="hidden" name="docIdPath" value="">
					</td>
				</tr>
				<tr>
					<td class="evenrow">Source System Name Path</td>
					<td class="evenrow-l"><input type="text" name="ssNamePath" value="RootDoc/" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow">Target System Name Path</td>
					<td class="evenrow-l"><input type="text" name="tsNamePath" value="RootDoc/" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Inbound Error Response Service</td>
					<td class="evenrow-l" width="70%"><input type="text" name="inErrorResService" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Internal API URL</td>
					<td class="evenrow-l" width="70%"><input type="text" name="internalApiUrl" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Internal API Client ID</td>
					<td class="evenrow-l" width="70%"><input type="text" name="internalClientID" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Internal API Client Password</td>
					<td class="evenrow-l" width="70%"><input type="text" name="internalClientSecret" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Access Token API URL</td>
					<td class="evenrow-l" width="70%"><input type="text" name="accessTokenUrl" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Access Token Client ID</td>
					<td class="evenrow-l" width="70%"><input type="text" name="authClientID" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Access Token Client Password</td>
					<td class="evenrow-l" width="70%"><input type="text" name="authClientSecret" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Unlimited Access Token</td>
					<td class="evenrow-l" width="70%"><input type="text" name="unlimitedAccessToken" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Access Token Extract Service</td>
					<td class="evenrow-l" width="70%"><input type="text" name="atExtractService" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Target API URL</td>
					<td class="evenrow-l" width="70%"><input type="text" name="targetApiUrl" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Target Service Method</td>
					<td class="evenrow-l" width="70%">
						<select name="serviceMethod" style="width:100">
							<option value="">선택</option>
							<option value="post">post</option>
							<option value="get">get</option>
							<option value="put">put</option>
							<option value="delete">delete</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Target API Client ID</td>
					<td class="evenrow-l" width="70%"><input type="text" name="targetClientID" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Target API Client Password</td>
					<td class="evenrow-l" width="70%"><input type="text" name="targetClientSecret" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Http Header</td>
					<td class="evenrow-l" width="70%">Name <input type="text" name="tempHeaderName" size="20" style="font-size:10pt;width:160">&nbsp;&nbsp;
						                              Value <input type="text" name="tempHeaderValue" size="20" style="font-size:10pt;width:170"><br><br>
													  Service <input type="text" name="tempHeaderService" size="20" style="font-size:10pt;width:360">&nbsp;
						                              <input type="button" name="ADDVALUE" value="Add Value"  onclick="return addHttpHeader()"></input>&nbsp;
							                          <input type="button" name="ADDVALUE" value="Update Value"  onclick="return updateHttpHeader()"></input>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Http Header List</td>
					<td class="evenrow-l" width="70%">
						<select id="tempHttpHeaders" name="tempHttpHeaders" style="width:400" size=5 multiple onclick="setUpdateHttpHeader(this.value)">
						</select>&nbsp;
						<input type="button" name="DELETEVALUE" value="Delete Value"  onclick="return deleteHttpHeader()"></input>
						<input type="hidden" name="httpHeader" value="">
						<input type="hidden" id="checkHttpHeaders" name="checkHttpHeaders" value="">
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Outbound Error Response Service</td>
					<td class="evenrow-l" width="70%"><input type="text" name="outErrorResService" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<!--<input type="button" name="SUBMIT" value="Create REST API Protocol"  onclick="return doAction('add', '')"></input>-->
						<input type="button" name="SUBMIT" value="Create REST API Protocol" onclick="checkServiceNode('add')"></input>
					</td>
				</tr>
			%else%
				%ifvar todo equals('read')%
					<tr>
						<td class="heading" colspan="2">REST API Protocol Properties</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Name</td>
						<td class="evenrow-l" width="70%">
							<input type="text" name="tempRestName" value="%value restName%" disabled size="20" style="font-size:10pt;width:200">
							<input type="hidden" name="restName" value="%value restName%">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">API System Name</td>
						<td class="evenrow-l" width="70%">
							<select name="systemName" style="width:100" onchange="javascript:makeBusinessName(this.value)">
								<option value="">시스템명</option>
								%loop systemNameList%
									<option value="%value systemNameList%">%value systemNameList%</option>
								%endloop%
							</select>
							<script language="javascript">
								document.pform.systemName.value = "%value systemName%";
							</script>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">API Business Name</td>
						<td class="evenrow-l" width="70%">
							<select name="businessName" style="width:100" onchange="javascript:makeRestName('businessName')">
								<option value="">업무명</option>
							</select>
							<input type="hidden" name="oldBusinessName" value="%value businessName%">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Description</td>
						<td class="evenrow-l" width="70%"><input type="text" name="description" value="%value description%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow">Conversion Encoding</td>
						<td class="evenrow-l">
							<select name="charSet" style="width:100">
								%loop charSetList%
									<option value="%value charSetList%">%value charSetList%</option>
								%endloop%
							</select>
							<script language="javascript">
								document.pform.charSet.value = "%value charSet%";
							</script>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Doc ID Path</td>
						<td class="evenrow-l" width="70%"><input type="text" name="tempDocIdPath" value="RootDoc/" size="20" style="font-size:10pt;width:400">&nbsp;
						                                  <input type="button" name="ADDVALUE" value="Add Value"  onclick="return addDocIdPath()"></input>&nbsp;
							                              <input type="button" name="ADDVALUE" value="Update Value"  onclick="return updateDocIdPath()"></input>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Doc ID Path List</td>
						<td class="evenrow-l" width="70%">
							<select name="tempDocIdPaths" style="width:400" size=5 multiple onclick="setUpdateDocIdPath(this.value)">
								%loop docIdPaths%
									<option value="%value docIdPaths%">%value docIdPaths%</option>
								%endloop%
							</select>&nbsp;
							<input type="button" name="DELETEVALUE" value="Delete Value"  onclick="return deleteDocIdPath()"></input>
							<input type="hidden" name="docIdPath" value="">
						</td>
					</tr>
					
					%ifvar ssNamePath -notempty%
					<tr>
						<td class="evenrow">Source System Name Path</td>
						<td class="evenrow-l"><input type="text" name="ssNamePath" value="%value ssNamePath%" size="20" style="font-size:10pt;width:400"></td>
					</tr>						
					%else%
					<tr>
						<td class="evenrow">Source System Name Path</td>
						<td class="evenrow-l"><input type="text" name="ssNamePath" value="RootDoc/" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					%endifvar%
					
					%ifvar tsNamePath -notempty%
					<tr>
						<td class="evenrow">Target System Name Path</td>
						<td class="evenrow-l"><input type="text" name="tsNamePath" value="%value tsNamePath%" size="20" style="font-size:10pt;width:400"></td>
					</tr>						
					%else%
					<tr>
						<td class="evenrow">Target System Name Path</td>
						<td class="evenrow-l"><input type="text" name="tsNamePath" value="RootDoc/" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					%endifvar%
					
					<tr>
						<td class="evenrow" width="30%">Inbound Error Response Service</td>
						<td class="evenrow-l" width="70%"><input type="text" name="inErrorResService" value="%value inErrorResService%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Internal API URL</td>
						<td class="evenrow-l" width="70%"><input type="text" name="internalApiUrl" value="%value internalApiUrl%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Internal API Client ID</td>
						<td class="evenrow-l" width="70%"><input type="text" name="internalClientID" value="%value internalClientID%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Internal API Client Password</td>
						<td class="evenrow-l" width="70%"><input type="text" name="internalClientSecret" value="%value internalClientSecret%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Access Token API URL</td>
						<td class="evenrow-l" width="70%"><input type="text" name="accessTokenUrl" value="%value accessTokenUrl%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Access Token Client ID</td>
						<td class="evenrow-l" width="70%"><input type="text" name="authClientID" value="%value authClientID%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Access Token Client Password</td>
						<td class="evenrow-l" width="70%"><input type="text" name="authClientSecret" value="%value authClientSecret%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Unlimited Access Token</td>
						<td class="evenrow-l" width="70%"><input type="text" name="unlimitedAccessToken" value="%value unlimitedAccessToken%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Access Token Extract Service</td>
						<td class="evenrow-l" width="70%"><input type="text" name="atExtractService" value="%value atExtractService%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Target API URL</td>
						<td class="evenrow-l" width="70%"><input type="text" name="targetApiUrl" value="%value targetApiUrl%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Target Service Method</td>
						<td class="evenrow-l" width="70%">
							<select name="serviceMethod" style="width:100">
								<option value="">선택</option>
								<option value="post">post</option>
								<option value="get">get</option>
								<option value="put">put</option>
								<option value="delete">delete</option>
							</select>
							<script language="javascript">
								document.pform.serviceMethod.value = "%value serviceMethod%";
							</script>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Target API Client ID</td>
						<td class="evenrow-l" width="70%"><input type="text" name="targetClientID" value="%value targetClientID%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Target API Client Password</td>
						<td class="evenrow-l" width="70%"><input type="text" name="targetClientSecret" value="%value targetClientSecret%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Http Header</td>
						<td class="evenrow-l" width="70%">Name <input type="text" name="tempHeaderName" size="20" style="font-size:10pt;width:160">&nbsp;&nbsp;
														  Value <input type="text" name="tempHeaderValue" size="20" style="font-size:10pt;width:170"><br><br>
													      Service <input type="text" name="tempHeaderService" size="20" style="font-size:10pt;width:360">&nbsp;
														  <input type="button" name="ADDVALUE" value="Add Value"  onclick="return addHttpHeader()"></input>&nbsp;
														  <input type="button" name="ADDVALUE" value="Update Value"  onclick="return updateHttpHeader()"></input>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Http Header List</td>
						<td class="evenrow-l" width="70%">
							<select id="tempHttpHeaders" name="tempHttpHeaders" style="width:400" size=5 multiple onclick="setUpdateHttpHeader(this.value)">
								%loop httpHeaders%
									<option value="%value httpHeaders%">%value httpHeaders%</option>
								%endloop%
							</select>&nbsp;
							<input type="button" name="DELETEVALUE" value="Delete Value"  onclick="return deleteHttpHeader()"></input>
							<input type="hidden" name="httpHeader" value="">
							<input type="hidden" id="checkHttpHeaders" name="checkHttpHeaders" value="">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Outbound Error Response Service</td>
						<td class="evenrow-l" width="70%"><input type="text" name="outErrorResService" value="%value outErrorResService%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="action" colspan="2">
							<!--<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>-->
							<input type="button" name="SUBMIT" value="Save Properties" onclick="checkServiceNode('update')"></input>
						</td>
					</tr>
				%else%
					</table>
					
					<table class="tableForm" width="100%">					
					<tr>
						<td class="heading" colspan=6>REST API Protocol Information</td>
					</tr>
					<tr class="subheading2">
						<td>Name</td>
						<td>API System Name</td>
						<td>API Business Name</td>
						<td>Description</td>
						<td>Edit</td>
						<td>Delete</td>
					</tr>
					%ifvar -notempty RestDocIDExtractConfig/Items%
						%loop RestDocIDExtractConfig/Items%
							<tr>
								<td>%value restName%</td>
								<td>%value systemName%</td>
								<td>%value businessName%</td>
								<td>%value description%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('read', '%value restName%')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
								</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value restName%')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=6>No rest api protocols are currently registered.</td></tr>
					%endifvar%
				</table>
				%endifvar%
			%endifvar%
		%endifvar%

		</form>
	</body>
</html>

%endinvoke%