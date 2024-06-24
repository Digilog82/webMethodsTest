%invoke JSocketAdapter.ADMIN:adminRemoteServer%

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
									doAction(aTodo, "", "");
								} else {
									alert(result.existsMsg);
								}
							  },
					error : function() {
								alert("Service Node 존재여부를 체크하는 중에 에러가 발생하였습니다 !!!");
					        }
				});
			};
			
			function doAction(todo, pname, onlineYN) {
				var frm = document.pform;
				frm.todo.value = todo;
				
				if(pname != '') {
					frm.name.value = pname;
				}
				
				if(todo == 'delete'){
					if(confirm("Do you really want to delete config of  " + pname)){
						frm.submit();
					}
				} else if (todo == 'deleteNotAvailable') {
					alert("Online Socket Client가 현재 서버에서 Running 중이므로 Socket 정보를 삭제할 수 없습니다.");
					return;
				} else if (todo == 'deleteNotAvailableOther') {
					alert("Online Socket Client가 다른 서버에서 Running 중이므로 Socket 정보를 삭제할 수 없습니다.");
					return;
				} else if (todo == 'readNotAvailable') {
					alert("Online Socket Client가 현재 서버에서 Running 중이므로 Socket 정보 조회만 가능하고 정보를 수정할 수 없습니다.");
					frm.todo.value = 'read';
					frm.updateAvailable.value = 'false';
					frm.submit();
				} else if (todo == 'readNotAvailableOther') {
					alert("Online Socket Client가 다른 서버에서 Running 중이므로 Socket 정보 조회만 가능하고 정보를 수정할 수 없습니다.");
					frm.todo.value = 'read';
					frm.updateAvailable.value = 'falseOther';
					frm.submit();
				} else if (todo == 'add' || todo == "update") {
					var updateAvailable = frm.updateAvailable.value;
					var online = frm.online.value;
					var sessionCount = frm.tempSessionCount.value;
					var clientAllConn = frm.tempClientAllConn.value;
					var conDuplexing = frm.tempConDuplexing.value;
					var reconInterval = frm.tempReconInterval.value;
					var startupConnection = frm.tempStartupConnection.value;					
					var healthCheckServicePath = frm.healthCheckServicePath.value;
					var healthCheckInterval = frm.healthCheckInterval.value;
					var tempUniqueKeyInfos = frm.tempUniqueKeyInfos;
					var hLength = tempUniqueKeyInfos.options.length;
					var lengthStartOffset = frm.lengthStartOffset.value;
					var lengthCount = frm.lengthCount.value;
					var docIDStartOffset = frm.docIDStartOffset.value;
					var docIDCount = frm.docIDCount.value;
					var ssNameStartOffset = frm.ssNameStartOffset.value;
					var ssNameCount = frm.ssNameCount.value;
					var tsNameStartOffset = frm.tsNameStartOffset.value;
					var tsNameCount = frm.tsNameCount.value;
					
					if (updateAvailable == "false") {
						alert("Online Socket Client가 현재 서버에서 Running 중이므로 Socket 정보 조회만 가능하고 정보를 수정할 수 없습니다.");
						return;
					} else if (updateAvailable == "falseOther") {
						alert("Online Socket Client가 다른 서버에서 Running 중이므로 Socket 정보 조회만 가능하고 정보를 수정할 수 없습니다.");
						return;
					}
					
					if (healthCheckServicePath != "" && healthCheckInterval == "") {
						alert("Health Check Service를 입력한 경우에는 Health Check Interval을 반드시 입력해야 합니다.");
						return;
					}
					
					if (online == "No") {
						frm.allowedSessionCount.value = "";
						frm.conDuplexing.value = "No";
					} else {
						// Asynch Online이라 하더라도 허용된 연결갯수를 모를 수 있기 때문에 필수 입력값은 아니다.
						frm.allowedSessionCount.value = sessionCount;
						frm.clientAllConn.value = clientAllConn;
						frm.conDuplexing.value = conDuplexing;
						frm.reconInterval.value = reconInterval;
						frm.startupConnection.value = startupConnection;						
					}
					
					if (lengthStartOffset != "" && lengthCount == "") {
						alert("DOC Length Field의 Length를 입력하십시요 !!!");
						return;
					}
					
					if (docIDStartOffset != "" && docIDCount == "") {
						alert("Doc ID Field의 Length를 입력하십시요 !!!");
						return;
					}
					
					if (ssNameStartOffset != "" && ssNameCount == "") {
						alert("Source System Name Field의 Length를 입력하십시요 !!!");
						return;
					}
					
					if (tsNameStartOffset != "" && tsNameCount == "") {
						alert("Target System Name Field의 Length를 입력하십시요 !!!");
						return;
					}
					
					if (hLength == 0) {
					} else if (hLength == 1) {
						frm.uniqueKeyInfo.value = tempUniqueKeyInfos.options[0].value;
					} else {					
						// Doc Unique Key Extract List 전체를 선택한 것으로 처리
						for (var i = 0; i < hLength; i++) {
							tempUniqueKeyInfos.options[i].selected = true;
						}
					}
					
					frm.submit();
				} else if (todo == 'usingYes') {
					frm.todo.value = 'using';
					frm.usevalue.value = 'Yes';
					frm.submit();
				} else if (todo == 'usingNo') {
					frm.todo.value = 'using';
					frm.usevalue.value = 'No';
					frm.submit();
				} else if (todo == 'notAvailable') {
					alert("Online Socket Client가 현재 서버에서 Running 중이므로 Disable 처리를 할 수 없습니다.");
					return;
				} else if (todo == 'notAvailableOther') {
					alert("Online Socket Client가 다른 서버에서 Running 중이므로 Disable 처리를 할 수 없습니다.");
					return;
				} else if (todo == 'connectTest') {
					if (onlineYN == 'Yes') {
						if (confirm(pname + "은 Asynch Online Socket 입니다.\nSocket Server에서 Session을 하나만 허용하는 경우에는 기존의 Online Connection이 Close 될 수 있습니다.\n계속 진행하시겠습니까?")) {
							frm.submit();
						}
					} else {
						frm.submit();
					}
				} else {
					frm.submit();
				}
			}
			
			function moveDocList(socketName) {				
				document.pform.todo.value = "docSearch";
				document.pform.sTargetSocketName.value = socketName;
				document.pform.fromRemoteServer.value = "true";
				document.pform.action = "basic-docinterfaceid.dsp";
				document.pform.submit();
			}
						
			function makeSocketName(nameSeq) {
				var frm = document.pform;
				var socketName1 = frm.socketName1.value;
				var socketName2 = frm.socketName2.value;
				var socketName3 = frm.socketName3.value;
				var socketName4 = frm.socketName4.value;
				var socketName = "";
				
				if (socketName1 != "") {
					socketName = socketName1;
				}
				
				if (socketName2 != "") {
					if (socketName != "") {
						socketName = socketName + "_" + socketName2;
					} else {
						socketName = socketName2;
					}
				}
				
				if (socketName3 != "") {
					if (socketName != "") {
						socketName = socketName + "_" + socketName3;
					} else {
						socketName = socketName3;
					}
					
					if (nameSeq == "3") {
						var online = frm.online.value;
					
						if (socketName3 == "RE" || socketName3 == "BA") {
							if (online == "Yes") {
								frm.online.value = "No";
								enableSessionCount("No");
							}
						} else if (socketName3 == "ON") {
							if (online == "No") {
								frm.online.value = "Yes";
								enableSessionCount("Yes");
							}
						}
					}
				}
				
				if (socketName4 != "") {
					if (socketName != "") {
						socketName = socketName + "_" + socketName4;
					} else {
						socketName = socketName4;
					}
				}
				
				frm.tempRemoteSystemName.value = socketName1;
				frm.remoteSystemName.value = socketName1;
				frm.tempBusinessName.value = socketName2;
				frm.businessName.value = socketName2;
				frm.tempName.value = socketName;
				frm.name.value = socketName;
			}
			
			function setKeyIv() {
				var frm = document.pform;
				var alg = frm.algorithm.value;
				
				if (alg == "DES") {
					document.all.aesKeyLength.style.display="none";
					frm.secretKey.value = frm.secretKeyDES.value;
					frm.initialVector.value = frm.initialVectorDES.value;
					frm.secretKeyLen.value = "Key Length : 8 bytes";
					frm.initialVectorLen.value = "IV Length : 8 bytes";
				} else if (alg == "DESede") {
					document.all.aesKeyLength.style.display="none";
					frm.secretKey.value = frm.secretKeyDESede.value;
					frm.initialVector.value = frm.initialVectorDESede.value;
					frm.secretKeyLen.value = "Key Length : 24 bytes";
					frm.initialVectorLen.value = "IV Length : 8 bytes";
				} else if (alg == "AES") {
					document.all.aesKeyLength.style.display="";
					var keyLength = frm.aesKeyLen.value;
					
					if (keyLength == "16") {
						frm.secretKey.value = frm.secretKeyAES.value;
						frm.secretKeyLen.value = "Key Length : 16 bytes";
					} else if (keyLength == "24") {
						frm.secretKey.value = frm.secretKeyAES24.value;
						frm.secretKeyLen.value = "Key Length : 24 bytes";
					} else if (keyLength == "32") {
						frm.secretKey.value = frm.secretKeyAES32.value;
						frm.secretKeyLen.value = "Key Length : 32 bytes";
					}
					
					frm.initialVector.value = frm.initialVectorAES.value;
					frm.initialVectorLen.value = "IV Length : 16 bytes";
				} else {
					document.all.aesKeyLength.style.display="none";
					frm.secretKey.value = "";
					frm.initialVector.value = "";
					frm.secretKeyLen.value = "";
					frm.initialVectorLen.value = "";
				}
			}
			
			function setAesKey() {
				var frm = document.pform;
				var keyLength = frm.aesKeyLen.value;
				
				if (keyLength == "16") {
					frm.secretKey.value = frm.secretKeyAES.value;
					frm.secretKeyLen.value = "Key Length : 16 bytes";
				} else if (keyLength == "24") {
					frm.secretKey.value = frm.secretKeyAES24.value;
					frm.secretKeyLen.value = "Key Length : 24 bytes";
				} else if (keyLength == "32") {
					frm.secretKey.value = frm.secretKeyAES32.value;
					frm.secretKeyLen.value = "Key Length : 32 bytes";
				}
			}
			
			function setChangedKeyIv(sk, sk24, sk32, iv) {
				var frm = document.pform;
				var alg = frm.algorithm.value;
				
				if (alg == "DES") {
					frm.secretKey.value = sk;
					frm.initialVector.value = iv;
					frm.secretKeyDES.value = sk;
					frm.initialVectorDES.value = iv;
				} else if (alg == "DESede") {
					frm.secretKey.value = sk;
					frm.initialVector.value = iv;
					frm.secretKeyDESede.value = sk;
					frm.initialVectorDESede.value = iv;
				} else if (alg == "AES") {
					var keyLength = frm.aesKeyLen.value;
					
					if (keyLength == "16") {
						frm.secretKey.value = sk;
					} else if (keyLength == "24") {
						frm.secretKey.value = sk24;
					} else if (keyLength == "32") {
						frm.secretKey.value = sk32;
					}
					
					frm.initialVector.value = iv;
					
					frm.secretKeyAES.value = sk;
					frm.secretKeyAES24.value = sk24;
					frm.secretKeyAES32.value = sk32;
					frm.initialVectorAES.value = iv;
				}
			}				
			
			function changeKeyIv() {
				var frm = document.pform;
				var alg = frm.algorithm.value;
				
				if (alg != '') {
					document.frames["createKeyIvForm"].document.kform.alg.value = alg;
					document.frames["createKeyIvForm"].document.kform.submit();
				}
			}
			
			function alertMsg() {
				var frm = document.pform;
				var msg = frm.alertMsg.value;
				
				if (msg != "") {
					alert(msg);
					frm.alertMsg.value = ""; // 다른 화면으로 이동 시 영향을 주기 때문에 alertMsg 를 공백처리 한다.
				}
				
				var todo = "%value todo%";
				
				if (todo == "read") {
					var alg = frm.algorithm.value;
					
					if (alg == "AES") {
						document.all.aesKeyLength.style.display="";
					} else {
						document.all.aesKeyLength.style.display="none";
					}
					
					var systemName = frm.socketName1.value;
					var businessName = frm.socketName2.value;
					makeBusinessName(systemName);
					
					// 업무명 Business Name Set.
					frm.socketName2.value = businessName;
				}
			}
			
			function makeBusinessName(systemName) {
				var businessName = document.pform.socketName2;
				
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
			}
			
			function enableSessionCount(aOnline) {
				if (aOnline == "Yes") {
					document.pform.tempSessionCount.disabled = false;
					document.pform.tempClientAllConn.disabled = false;
					document.pform.tempConDuplexing.disabled = false;
					document.pform.tempStartupConnection.disabled = false;
					document.pform.tempReconInterval.disabled = false;
				} else {
					document.pform.tempSessionCount.value = "";
					document.pform.allowedSessionCount.value = "";
					document.pform.tempSessionCount.disabled = true;
					document.pform.tempClientAllConn.value = "No";
					document.pform.clientAllConn.value = "No";
					document.pform.tempClientAllConn.disabled = true;
					document.pform.tempConDuplexing.value = "No";
					document.pform.conDuplexing.value = "No";
					document.pform.tempConDuplexing.disabled = true;
					document.pform.tempStartupConnection.value = "No";
					document.pform.startupConnection.value = "No";
					document.pform.tempStartupConnection.disabled = true;
					document.pform.tempReconInterval.value = "";
					document.pform.reconInterval.value = "";
					document.pform.tempReconInterval.disabled = true;
				}
			}
			
			function addDocUniqueKey() {
				var tempUniqueKeyInfos = document.pform.tempUniqueKeyInfos;
				var tempKeyLocation = document.pform.tempKeyLocation.value;
				var tempKeyLength = document.pform.tempKeyLength.value;
				
				if (tempKeyLocation == "") {
					alert("Key Location을 입력하십시요.");
					return;
				} else {
					if (isNaN(tempKeyLocation)) {
						alert("Key Location은 숫자만 입력하십시요.");
						return;
					}
				}
				
				if (tempKeyLength == "") {
					alert("Key Length를 입력하십시요.");
					return;
				} else {
					if (isNaN(tempKeyLength)) {
						alert("Key Length는 숫자만 입력하십시요.");
						return;
					}
				}
								
				var keyInfo = tempKeyLocation + "/" + tempKeyLength;
				
				// Doc Unique Key Extract 중복 체크
				var hNLength = tempUniqueKeyInfos.options.length;
				for (var i=0; i < hNLength; i++) {
					var hNV = tempUniqueKeyInfos.options[i].value;
					var hNVs = hNV.split("/");
					var hN = hNVs[0];
					
					if (tempKeyLocation == hN) {
						alert("Key Location " + tempKeyLocation + "는(은) 이미 추가되어 있습니다.");
						return;
					}
				}
				
				tempUniqueKeyInfos.options[hNLength] = new Option(keyInfo, keyInfo);
				document.pform.tempKeyLocation.value = "";
				document.pform.tempKeyLength.value = "";
			}
			
			function deleteDocUniqueKey() {
				var tempUniqueKeyInfos = document.pform.tempUniqueKeyInfos;
				var hNLength = tempUniqueKeyInfos.options.length;
				
				var optionIndex = 0;
				var newValueLength;
				var selectYN = "false";
				
				for (var i = 0; i < hNLength; i++) {
					if (tempUniqueKeyInfos.options[optionIndex].selected) {
						document.pform.tempKeyLocation.value = "";
						document.pform.tempKeyLength.value = "";
						tempUniqueKeyInfos.options.remove(optionIndex);
						selectYN = "true";
					} else {
						optionIndex++;
					}
					
					newValueLength = tempUniqueKeyInfos.options.length;
					
					if (optionIndex > (newValueLength-1)) {
						break;
					}
				}
				
				if (selectYN == "false") {
					alert("삭제할 Key Location/Key Length를 선택하십시요.");
					return;
				}
			}
			
			function updateDocUniqueKey() {
				var tempUniqueKeyInfos = document.pform.tempUniqueKeyInfos;
				var hNLength = tempUniqueKeyInfos.options.length;
				var tempKeyLocation = document.pform.tempKeyLocation.value;
				var tempKeyLength = document.pform.tempKeyLength.value;
				var optionIndex = 0;
				var selectYN = "false";
				
				if (tempKeyLocation == "") {
					alert("Key Location을 입력하십시요.");
					return;
				} else {
					if (isNaN(tempKeyLocation)) {
						alert("Key Location은 숫자만 입력하십시요.");
						return;
					}
				}
				
				if (tempKeyLength == "") {
					alert("Key Length를 입력하십시요.");
					return;
				} else {
					if (isNaN(tempKeyLength)) {
						alert("Key Length는 숫자만 입력하십시요.");
						return;
					}
				}
				
				var keyInfo = tempKeyLocation + "/" + tempKeyLength;
				
				// Doc Unique Key Extract 중복 체크
				for (var i=0; i < hNLength; i++) {
					var hNV = tempUniqueKeyInfos.options[i].value;
					var hNVs = hNV.split("/");
					var hN = hNVs[0];
					
					if (tempKeyLocation == hN) {
						if (confirm("Key Location " + tempKeyLocation + "는(은) 이미 추가되어 있습니다.\nKey Length만 수정하시겠습니까?")) {
							break;
						} else {
							return;
						}
					}
				}
								
				for (var i = 0; i < hNLength; i++) {
					if (tempUniqueKeyInfos.options[optionIndex].selected) {
						tempUniqueKeyInfos.options[optionIndex] = new Option(keyInfo, keyInfo);
						selectYN = "true";
						break;
					} else {
						optionIndex++;
					}
				}
				
				if (selectYN == "false") {
					alert("수정할 Key Location/Key Length를 먼저 선택하십시요.");
					return;
				}
				
				document.pform.tempKeyLocation.value = "";
				document.pform.tempKeyLength.value = "";
			}
			
			function setUpdateDocUniqueKey(keyInfo) {
				var hNVs = keyInfo.split("/");
				var tempKeyLocation = hNVs[0];
				var tempKeyLength = hNVs[1];
								
				document.pform.tempKeyLocation.value = tempKeyLocation;
				document.pform.tempKeyLength.value = tempKeyLength;
			}
		</script>
	</head>
	<body onload="javascript:alertMsg()">
		
		%ifvar changed equals('true')%
			<form name="dform" method="post">
				<input type="hidden" name="todo" value="remoteSearch">
				<input type="hidden" name="alertMsg" value="%value alertMsg%">
				<input type="hidden" name="sSystemName" value="%value sSystemName%">
				<input type="hidden" name="sOnline" value="%value sOnline%">
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
						Server Socket &gt;
						Remote Server Socket &gt;
						Create Remote Server Socket
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Server Socket &gt;
							Remote Server Socket &gt;
							Edit Remote Server Socket
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Server Socket &gt;
							Remote Server Socket
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		<input type="hidden" id="todo" name="todo" value="">
		<input type="hidden" name="oldName" value="%value name%">
		<input type="hidden" name="usevalue" value="">
		<input type="hidden" name="updateAvailable" value="%value updateAvailable%">
		<input type="hidden" name="secretKeyDES" value="%value secretKeyDES%">
		<input type="hidden" name="initialVectorDES" value="%value initialVectorDES%">
		<input type="hidden" name="secretKeyDESede" value="%value secretKeyDESede%">
		<input type="hidden" name="initialVectorDESede" value="%value initialVectorDESede%">
		<input type="hidden" name="secretKeyAES" value="%value secretKeyAES%">
		<input type="hidden" name="secretKeyAES24" value="%value secretKeyAES24%">
		<input type="hidden" name="secretKeyAES32" value="%value secretKeyAES32%">
		<input type="hidden" name="initialVectorAES" value="%value initialVectorAES%">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		<input type="hidden" name="sTargetSocketName" value="">
		<input type="hidden" name="fromRemoteServer" value="">
		
		%loop businessNameList%		
			<input type="hidden" name="%value systemName%" value="%value businessName%">			
		%endloop%
			
		%ifvar todo equals('connectTest')%
			<input type="hidden" name="name" value="">		
			<ul class="listitems">
				<li class="listitem"><a href="javascript:doAction('create', '', '')">Create New Remote Server Socket</a></li>	
			</ul>
		%else%
			%ifvar todo equals('remoteSearch')%
				<input type="hidden" name="name" value="">		
				<ul class="listitems">
					<li class="listitem"><a href="javascript:doAction('create', '', '')">Create New Remote Server Socket</a></li>	
				</ul>
			%else%			
				<ul class="listitems">
					<li class="listitem"><a href="socket-remoteserver.dsp?todo=remoteSearch&sSystemName=%value sSystemName%&sOnline=%value sOnline%">Return to Remote Server Socket Information</a></li>
				</ul>
			%endifvar%
		%endifvar%
		
		%ifvar ConnectionTest -notempty%
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan=3>Remote Server Socket Connection Test</td>
				</tr>
				<tr class="subheading2">
					<td>Socket Name</td>
					<td>Test Result</td>
					<td>Socket Log</td>
				</tr>
				<tr>
					<td>%value ConnectionTest/socketName%</td>
					<td>%value ConnectionTest/connectFlag%</td>
					<td>
						%loop ConnectionTest/socketLogList%
							%value ConnectionTest/socketLogList%<br>
						%endloop%
					</td>
				</tr>
			</table>
		%endifvar%
		
		<table class="tableForm" width="100%">	
			%ifvar todo equals('create')%
				<tr>
					<td class="heading" colspan="2">Remote Server Socket Properties</td>
				</tr>
				<tr>
					<tr>
						<td class="evenrow" width="30%">Enabled</td>
						<td class="evenrow-l" width="70%">
							<select name="enabled" style="width:90">
								<option value="enabled">Enabled</option>
								<option value="disabled">Disabled</option>								
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Provider System Name</td>
						<td class="evenrow-l" width="70%">
							<input type="text" name="tempRemoteSystemName" disabled size="20" style="font-size:10pt;width:90">
							<input type="hidden" name="remoteSystemName" value="">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Business Name</td>
						<td class="evenrow-l" width="70%">
							<input type="text" name="tempBusinessName" disabled size="20" style="font-size:10pt;width:90">
							<input type="hidden" name="businessName" value="">
						</td>
					</tr>
					<tr>
						<td class="evenrow">Socket Name</td>
						<td class="evenrow-l">
							<select name="socketName1" style="width:90" onchange="javascript:makeSocketName('1');makeBusinessName(this.value)">
								<option value="">시스템명</option>
								%loop systemNameList%
									<option value="%value systemNameList%">%value systemNameList%</option>
								%endloop%
							</select>
							<select name="socketName2" style="width:90" onchange="javascript:makeSocketName('2')">
								<option value="">업무명</option>
							</select>
							<select name="socketName3" style="width:110" onchange="javascript:makeSocketName('3')">
								<option value="">통신방식</option>
								<option value="RE">Synch Realtime</option>
								<option value="ON">Asynch Online</option>
								<option value="BA">Batch</option>
							</select>
							<select name="socketName4" style="width:90" onchange="javascript:makeSocketName('4')">
								<option value="">방향</option>
								<option value="OUT">Outbound</option>
								<option value="IN">Inbound</option>
							</select>&nbsp;&nbsp;&nbsp;
							<input type="text" name="tempName" disabled size="20" style="font-size:10pt;width:300">
							<input type="hidden" name="name" value="">
						</td>
					</tr>
					<tr>
						<td class="evenrow">Description</td>
						<td class="evenrow-l"><input type="text" name="description" size="6" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow">IP</td>
						<td class="evenrow-l"><input type="text" name="ip" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow">Port Number</td>
						<td class="evenrow-l"><input type="text" name="port" size="6" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow">Read Timeout</td>
						<td class="evenrow-l"><input type="text" name="readTimeout" size="6" style="font-size:10pt;width:400"> (ms)</td>
					</tr>
					<tr>
						<td class="evenrow">Read Timeout Error YN</td>
						<td class="evenrow-l">
							<select name="readTimeoutErrorYN" style="width:100">
								<option value="">선택</option>
								<option value="No">No</option>
								<option value="Yes">Yes</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow">Character Set</td>
						<td class="evenrow-l">
							<select name="charSet" style="width:100">
								%loop charSetList%
									<option value="%value charSetList%">%value charSetList%</option>
								%endloop%
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Asynch Online YN</td>
						<td class="evenrow-l" width="70%">
							<select name="online" style="width:100" onchange="javascript:enableSessionCount(this.value)">
								<option value="Yes">Yes</option>
								<option value="No">No</option>								
							</select>&nbsp;&nbsp;&nbsp;&nbsp;
							Allowed Session Count&nbsp;<input type="text" name="tempSessionCount" style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="hidden" name="allowedSessionCount" value="">
							Connect All&nbsp;
							<select name="tempClientAllConn" style="width:60">
								<option value="No">No</option>
								<option value="Yes">Yes</option>
							</select>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="hidden" name="clientAllConn" value="No">
							Multi-Connection YN&nbsp;
							<select name="tempConDuplexing" style="width:60">
								<option value="No">No</option>
								<option value="Yes">Yes</option>
							</select>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="hidden" name="conDuplexing" value="No">
							Reconnect Interval&nbsp;<input type="text" name="tempReconInterval" style="font-size:10pt;width:50"> (second)
							<input type="hidden" name="reconInterval" value="">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Connection on IS Startup</td>
						<td class="evenrow-l" width="70%">
							<select name="tempStartupConnection" style="width:90">
								<option value="No">No</option>
								<option value="Yes">Yes</option>								
							</select>
							<input type="hidden" name="startupConnection" value="No">
						</td>
					</tr>
					<tr>
						<td class="evenrow">Listener Service</td>
						<td class="evenrow-l">
							%ifvar customerCode equals('HSC')%
								<!-- 현대제철 전용 -->
								<select name="servicePath" style="width:400">
									<option value="">선택</option>
									%loop listenerServiceList%
										<option value="%value listenerServiceList%">%value listenerServiceList%</option>
									%endloop%
								</select>
								<!-- 현대제철 전용 -->
							%else%
								<input type="text" name="servicePath" size="20" style="font-size:10pt;width:400">
							%endifvar%
							&nbsp;(Asynch Online 데이터 수신이 있는 경우 입력)
						</td>
					</tr>
					<tr>
						<td class="evenrow">Distributer Service</td>
						<td class="evenrow-l">														
							<input type="text" name="disServicePath" size="20" style="font-size:10pt;width:400">&nbsp;&nbsp;(Asynch Online 데이터 수신이 있는 경우 입력)
						</td>
					</tr>
					<tr>
						<td class="evenrow">Health Check Service</td>
						<td class="evenrow-l">														
							<input type="text" name="healthCheckServicePath" size="20" style="font-size:10pt;width:400">&nbsp
							Health Check Interval&nbsp;<input type="text" name="healthCheckInterval" size="20" style="font-size:10pt;width:50"> (second)
						</td>
					</tr>
					<tr>
						<td class="evenrow">Common Header Length</td>
						<td class="evenrow-l"><input type="text" name="commonHeaderLength" size="6" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow">First Reading Length</td>
						<td class="evenrow-l"><input type="text" name="firstReadingLength" size="6" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow">DOC Length Field</td>
						<td class="evenrow-l">Start Index <input type="text" name="lengthStartOffset" size="6" style="font-size:10pt;width:150">&nbsp;
						                      Length <input type="text" name="lengthCount" size="6" style="font-size:10pt;width:150">
						</td>
					</tr>
					<tr>
						<td class="evenrow">Doc ID Field</td>
						<td class="evenrow-l">Start Index <input type="text" name="docIDStartOffset" size="6" style="font-size:10pt;width:150">&nbsp;
						                      Length <input type="text" name="docIDCount" size="6" style="font-size:10pt;width:150">
						</td>
					</tr>
					<tr>
						<td class="evenrow">Source System Name Field</td>
						<td class="evenrow-l">Start Index <input type="text" name="ssNameStartOffset" size="6" style="font-size:10pt;width:150">&nbsp;
						                      Length <input type="text" name="ssNameCount" size="6" style="font-size:10pt;width:150">
						</td>
					</tr>
					<tr>
						<td class="evenrow">Target System Name Field</td>
						<td class="evenrow-l">Start Index <input type="text" name="tsNameStartOffset" size="6" style="font-size:10pt;width:150">&nbsp;
						                      Length <input type="text" name="tsNameCount" size="6" style="font-size:10pt;width:150">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Doc Unique Key Field</td>
						<td class="evenrow-l" width="70%">Start Index <input type="text" name="tempKeyLocation" size="20" style="font-size:10pt;width:150">&nbsp;
							                              Length <input type="text" name="tempKeyLength" size="20" style="font-size:10pt;width:150">&nbsp;
							                              <input type="button" name="ADDVALUE" value="Add Value"  onclick="return addDocUniqueKey()"></input>&nbsp;
								                          <input type="button" name="ADDVALUE" value="Update Value"  onclick="return updateDocUniqueKey()"></input>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Doc Unique Key Field List</td>
						<td class="evenrow-l" width="70%">
							<select name="tempUniqueKeyInfos" style="width:400" size=5 multiple onclick="setUpdateDocUniqueKey(this.value)">
							</select>&nbsp;
							<input type="button" name="DELETEVALUE" value="Delete Value"  onclick="return deleteDocUniqueKey()"></input>
							<input type="hidden" name="uniqueKeyInfo" value="">
						</td>
					</tr>					
					<tr>
						<td class="evenrow" width="30%">Nagle Algorithm Usage YN</td>
						<td class="evenrow-l" width="70%">
							<select name="nagleAlg" style="width:100">
								<option value="No">No</option>
								<option value="Yes">Yes</option>								
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Fixed Connecting Client IP</td>
						<td class="evenrow-l" width="70%"><input type="text" name="fixedConnectingIP" size="6" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Byte Order Conversion</td>
						<td class="evenrow-l" width="70%">
							<select name="byteOrder" style="width:100">
								<option value="">선택</option>
								<option value="LITTLE">Little Endian</option>
								<option value="BIG">Big Endian</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Doc Send Interval</td>
						<td class="evenrow-l"><input type="text" name="docSendInterval" size="6" style="font-size:10pt;width:400"> (ms)</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Encrypt Algorithm</td>
						<td class="evenrow-l" width="70%">
							<select name="algorithm" style="width:100" onchange="javascript:setKeyIv()">
								<option value="">암호알고리즘</option>
								<option value="DES">DES</option>
								<option value="DESede">3DES</option>
								<option value="AES">AES</option>
							</select>&nbsp;<input type="button" value="Change Key & IV"  onclick="return changeKeyIv()"></input>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Encrypt Mode</td>
						<td class="evenrow-l" width="70%">
							<select name="mode" style="width:100">
								<option value="">암호모드</option>
								<option value="CBC">CBC</option>
								<option value="ECB">ECB</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Encrypt Padding</td>
						<td class="evenrow-l" width="70%">
							<select name="padding" style="width:100">
								<option value="">암호패딩</option>
								<option value="NoPadding">NoPadding</option>
								<option value="PKCS5Padding">PKCS5Padding</option>
								<option value="PKCS7Padding">PKCS7Padding</option>
							</select>
						</td>
					</tr>
					<tr id="aesKeyLength" style="display:none">
						<td class="evenrow" width="30%">Encrypt Key Length</td>
						<td class="evenrow-l" width="70%">
							<select name="aesKeyLen" style="width:100" onchange="javascript:setAesKey()">
								<option value="16">16 bytes</option>
								<option value="24">24 bytes</option>
								<option value="32">32 bytes</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow">Encrypt Key</td>
						<td class="evenrow-l"><input type="text" id="secretKey" name="secretKey" size="20" style="font-size:10pt;width:400">&nbsp;<input type="text" name="secretKeyLen" disabled size="20" style="font-size:10pt;width:200;background-color:transparent;border:0">
						</td>
					</tr>
					<tr>
						<td class="evenrow">Encrypt Initial Vector</td>
						<td class="evenrow-l"><input type="text" id="initialVector" name="initialVector" size="20" style="font-size:10pt;width:400">&nbsp;<input type="text" name="initialVectorLen" disabled size="20" style="font-size:10pt;width:200;background-color:transparent;border:0">
						</td>
					</tr>
					<tr>
						<td class="action" colspan="2">
							<!--<input type="button" name="SUBMIT" value="Create Remote Server"  onclick="return doAction('add', '', '')"></input>-->
							<input type="button" name="SUBMIT" value="Create Remote Server" onclick="checkServiceNode('add')"></input>
						</td>
					</tr>
				</tr>
			%else%
				%ifvar todo equals('read')%
					<tr>
						<td class="heading" colspan="2">Remote Server Socket Properties</td>
					</tr>
					<tr>
						<tr>
							<td class="evenrow" width="30%">Enabled</td>
							<td class="evenrow-l" width="70%">
								%ifvar enabled equals('enabled')%
									Enabled
								%else%
									Disabled
								%endifvar%
								<input type="hidden" name="enabled" value="%value enabled%">
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Provider System Name</td>
							<td class="evenrow-l" width="70%">
								<input type="text" name="tempRemoteSystemName" value="%value remoteSystemName%" disabled size="20" style="font-size:10pt;width:90">
								<input type="hidden" name="remoteSystemName" value="%value remoteSystemName%">
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Business Name</td>
							<td class="evenrow-l" width="70%">
								<input type="text" name="tempBusinessName" value="%value businessName%" disabled size="20" style="font-size:10pt;width:90">
								<input type="hidden" name="businessName" value="%value businessName%">
							</td>
						</tr>
						<tr>
							<td class="evenrow">Socket Name</td>
							<td class="evenrow-l">
								<select name="socketName1" style="width:90" onchange="javascript:makeSocketName('1');makeBusinessName(this.value)">
									<option value="">시스템명</option>
									%loop systemNameList%
										<option value="%value systemNameList%">%value systemNameList%</option>
									%endloop%
								</select>
								<script language="javascript">
									document.pform.socketName1.value = "%value socketName1%";
								</script>
								<select name="socketName2" style="width:90" onchange="javascript:makeSocketName('2')">
									<option value="">업무명</option>
									<option value="%value socketName2%">%value socketName2%</option>
								</select>
								<script language="javascript">
									document.pform.socketName2.value = "%value socketName2%";
								</script>
								<select name="socketName3" style="width:110" onchange="javascript:makeSocketName('3')">
									<option value="">통신방식</option>
									<option value="RE">Synch Realtime</option>
									<option value="ON">Asynch Online</option>
									<option value="BA">Batch</option>
								</select>
								<script language="javascript">
									document.pform.socketName3.value = "%value socketName3%";
								</script>
								<select name="socketName4" style="width:90" onchange="javascript:makeSocketName('4')">
									<option value="">방향</option>
									<option value="OUT">Outbound</option>
									<option value="IN">Inbound</option>
								</select>&nbsp;&nbsp;&nbsp;
								<script language="javascript">
									document.pform.socketName4.value = "%value socketName4%";
								</script>
								<input type="text" name="tempName" value="%value name%" disabled size="20" style="font-size:9pt;width:300">
								<input type="hidden" name="name" value="%value name%">
							</td>
						</tr>
						<tr>
							<td class="evenrow">Description</td>
							<td class="evenrow-l"><input type="text" name="description" value="%value description%" size="6" style="font-size:9pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow">IP</td>
							<td class="evenrow-l"><input type="text" name="ip" value="%value ip%" size="20" style="font-size:9pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow">Port Number</td>
							<td class="evenrow-l"><input type="text" name="port" value="%value port%" size="6" style="font-size:9pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow">Read Timeout</td>
							<td class="evenrow-l"><input type="text" name="readTimeout" value="%value readTimeout%" size="6" style="font-size:9pt;width:400"> (ms)</td>
						</tr>
						<tr>
							<td class="evenrow">Read Timeout Error YN</td>
							<td class="evenrow-l">
								<select name="readTimeoutErrorYN" style="width:100">
									<option value="">선택</option>
									<option value="No">No</option>
									<option value="Yes">Yes</option>
								</select>
								<script language="javascript">
									document.pform.readTimeoutErrorYN.value = "%value readTimeoutErrorYN%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow">Character Set</td>
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
							<td class="evenrow" width="30%">Asynch Online YN</td>
							<td class="evenrow-l" width="70%">
								<select name="online" style="width:100" onchange="javascript:enableSessionCount(this.value)">
									<option value="Yes">Yes</option>
									<option value="No">No</option>									
								</select>
								<script language="javascript">
									document.pform.online.value = "%value online%";
								</script>&nbsp;&nbsp;&nbsp;&nbsp;
								
								%ifvar online equals('No')%
									Allowed Session Count&nbsp;
									<input type="text" name="tempSessionCount" disabled style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="hidden" name="allowedSessionCount" value="">
									Connect All&nbsp;
									<select name="tempClientAllConn" disabled style="width:60">
										<option value="No">No</option>
										<option value="Yes">Yes</option>
									</select>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="hidden" name="clientAllConn" value="No">
									Multi-Connection YN&nbsp;
									<select name="tempConDuplexing" disabled style="width:60">
										<option value="No">No</option>
										<option value="Yes">Yes</option>
									</select>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="hidden" name="conDuplexing" value="No">
									Reconnect Interval&nbsp;<input type="text" name="tempReconInterval" disabled style="font-size:10pt;width:50"> (second)
									<input type="hidden" name="reconInterval" value="">
								%else%
									Allowed Session Count&nbsp;
									<input type="text" name="tempSessionCount" value="%value allowedSessionCount%" style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="hidden" name="allowedSessionCount" value="%value allowedSessionCount%">
									Connect All&nbsp;
									<select name="tempClientAllConn" style="width:60">
										<option value="No">No</option>
										<option value="Yes">Yes</option>
									</select>&nbsp;&nbsp;&nbsp;&nbsp;
									<script language="javascript">
										document.pform.tempClientAllConn.value = "%value clientAllConn%";
									</script>
									<input type="hidden" name="clientAllConn" value="%value clientAllConn%">
									Multi-Connection YN&nbsp;
									<select name="tempConDuplexing" style="width:60">
										<option value="No">No</option>
										<option value="Yes">Yes</option>
									</select>&nbsp;&nbsp;&nbsp;&nbsp;
									<script language="javascript">
										document.pform.tempConDuplexing.value = "%value conDuplexing%";
									</script>
									<input type="hidden" name="conDuplexing" value="%value conDuplexing%">
									Reconnect Interval&nbsp;<input type="text" name="tempReconInterval" value="%value reconInterval%" style="font-size:10pt;width:50"> (second)
									<input type="hidden" name="reconInterval" value="%value reconInterval%">
								%endifvar%
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Connection on IS Startup</td>
							<td class="evenrow-l" width="70%">
								%ifvar online equals('No')%
									<select name="tempStartupConnection" disabled style="width:90">
										<option value="No">No</option>
										<option value="Yes">Yes</option>
									</select>
									<input type="hidden" name="startupConnection" value="No">
								%else%
									<select name="tempStartupConnection" style="width:90">
										<option value="No">No</option>
										<option value="Yes">Yes</option>								
									</select>
									<script language="javascript">
										document.pform.tempStartupConnection.value = "%value startupConnection%";
									</script>
									<input type="hidden" name="startupConnection" value="%value startupConnection%">
								%endifvar%
							</td>
						</tr>
						<tr>
							<td class="evenrow">Listener Service</td>
							<td class="evenrow-l">
								%ifvar customerCode equals('HSC')%
									<!-- 현대제철 전용 -->
									<select name="servicePath" style="width:400">
										<option value="">선택</option>
										%loop listenerServiceList%
											<option value="%value listenerServiceList%">%value listenerServiceList%</option>
										%endloop%
									</select>
									<script language="javascript">
										document.pform.servicePath.value = "%value servicePath%";
									</script>
									<!-- 현대제철 전용 -->
								%else%
									<input type="text" name="servicePath" value="%value servicePath%" size="20" style="font-size:10pt;width:400">
								%endifvar%
								&nbsp;(Asynch Online 데이터 수신이 있는 경우 입력)
							</td>
						</tr>
						<tr>
							<td class="evenrow">Distributer Service</td>
							<td class="evenrow-l">														
								<input type="text" name="disServicePath" value="%value disServicePath%" size="20" style="font-size:10pt;width:400">&nbsp;&nbsp;(Asynch Online 데이터 수신이 있는 경우 입력)
							</td>
						</tr>
						<tr>
							<td class="evenrow">Health Check Service</td>
							<td class="evenrow-l">														
								<input type="text" name="healthCheckServicePath" value="%value healthCheckServicePath%" size="20" style="font-size:10pt;width:400">&nbsp;
								Health Check Interval&nbsp;<input type="text" name="healthCheckInterval" value="%value healthCheckInterval%" size="20" style="font-size:10pt;width:50"> (second)
							</td>
						</tr>
						<tr>
							<td class="evenrow">Common Header Length</td>
							<td class="evenrow-l"><input type="text" name="commonHeaderLength" value="%value commonHeaderLength%" size="6" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow">First Reading Length</td>
							<td class="evenrow-l"><input type="text" name="firstReadingLength" value="%value firstReadingLength%" size="6" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow">DOC Length Field</td>
							<td class="evenrow-l">Start Index <input type="text" name="lengthStartOffset" value="%value lengthStartOffset%" size="6" style="font-size:10pt;width:150">&nbsp;
												Length <input type="text" name="lengthCount" value="%value lengthCount%" size="6" style="font-size:10pt;width:150">
							</td>
						</tr>
						<tr>
							<td class="evenrow">Doc ID Field</td>
							<td class="evenrow-l">Start Index <input type="text" name="docIDStartOffset" value="%value docIDStartOffset%" size="6" style="font-size:10pt;width:150">&nbsp;
												Length <input type="text" name="docIDCount" value="%value docIDCount%" size="6" style="font-size:10pt;width:150">
							</td>
						</tr>
						<tr>
							<td class="evenrow">Source System Name Field</td>
							<td class="evenrow-l">Start Index <input type="text" name="ssNameStartOffset" value="%value ssNameStartOffset%" size="6" style="font-size:10pt;width:150">&nbsp;
												Length <input type="text" name="ssNameCount" value="%value ssNameCount%" size="6" style="font-size:10pt;width:150">
							</td>
						</tr>
						<tr>
							<td class="evenrow">Target System Name Field</td>
							<td class="evenrow-l">Start Index <input type="text" name="tsNameStartOffset" value="%value tsNameStartOffset%" size="6" style="font-size:10pt;width:150">&nbsp;
												Length <input type="text" name="tsNameCount" value="%value tsNameCount%" size="6" style="font-size:10pt;width:150">
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Doc Unique Key Field</td>
							<td class="evenrow-l" width="70%">Start Index <input type="text" name="tempKeyLocation" size="20" style="font-size:10pt;width:150">&nbsp;
															Length <input type="text" name="tempKeyLength" size="20" style="font-size:10pt;width:150">&nbsp;
															<input type="button" name="ADDVALUE" value="Add Value"  onclick="return addDocUniqueKey()"></input>&nbsp;
															<input type="button" name="ADDVALUE" value="Update Value"  onclick="return updateDocUniqueKey()"></input>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Doc Unique Key Field List</td>
							<td class="evenrow-l" width="70%">
								<select name="tempUniqueKeyInfos" style="width:400" size=5 multiple onclick="setUpdateDocUniqueKey(this.value)">
									%loop uniqueKeyInfos%
										<option value="%value uniqueKeyInfos%">%value uniqueKeyInfos%</option>
									%endloop%
								</select>&nbsp;
								<input type="button" name="DELETEVALUE" value="Delete Value"  onclick="return deleteDocUniqueKey()"></input>
								<input type="hidden" name="uniqueKeyInfo" value="">
							</td>
						</tr>						
						<tr>
							<td class="evenrow" width="30%">Nagle Algorithm Usage YN</td>
							<td class="evenrow-l" width="70%">
								<select name="nagleAlg" style="width:100">
									<option value="No">No</option>
									<option value="Yes">Yes</option>									
								</select>
								<script language="javascript">
									document.pform.nagleAlg.value = "%value nagleAlg%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Fixed Connecting Client IP</td>
							<td class="evenrow-l" width="70%"><input type="text" name="fixedConnectingIP" value="%value fixedConnectingIP%" size="6" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Byte Order Conversion</td>
								<td class="evenrow-l" width="70%">
									<select name="byteOrder" style="width:100">
										<option value="">선택</option>
										<option value="LITTLE">Little Endian</option>
										<option value="BIG">Big Endian</option>
									</select>
								</td>
								<script language="javascript">
									document.pform.byteOrder.value = "%value byteOrder%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Doc Send Interval</td>
							<td class="evenrow-l"><input type="text" name="docSendInterval" value="%value docSendInterval%" size="6" style="font-size:10pt;width:400"> (ms)</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Encrypt Algorithm</td>
							<td class="evenrow-l" width="70%">
								<select name="algorithm" style="width:100" onchange="javascript:setKeyIv()">
									<option value="">암호알고리즘</option>
									<option value="DES">DES</option>
									<option value="DESede">3DES</option>
									<option value="AES">AES</option>
								</select>&nbsp;<input type="button" value="Change Key & IV"  onclick="return changeKeyIv()"></input>
								<script language="javascript">
									document.pform.algorithm.value = "%value algorithm%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Encrypt Mode</td>
							<td class="evenrow-l" width="70%">
								<select name="mode" style="width:100">
									<option value="">암호모드</option>
									<option value="CBC">CBC</option>
									<option value="ECB">ECB</option>
								</select>
								<script language="javascript">
									document.pform.mode.value = "%value mode%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Encrypt Padding</td>
							<td class="evenrow-l" width="70%">
								<select name="padding" style="width:100">
									<option value="">암호패딩</option>
									<option value="NoPadding">NoPadding</option>
									<option value="PKCS5Padding">PKCS5Padding</option>
									<option value="PKCS7Padding">PKCS7Padding</option>
								</select>
								<script language="javascript">
									document.pform.padding.value = "%value padding%";
								</script>
							</td>
						</tr>
						<tr id="aesKeyLength">
							<td class="evenrow" width="30%">Encrypt Key Length</td>
							<td class="evenrow-l" width="70%">
								<select name="aesKeyLen" style="width:100" onchange="javascript:setAesKey()">
									<option value="16">16 bytes</option>
									<option value="24">24 bytes</option>
									<option value="32">32 bytes</option>
								</select>
								<script language="javascript">
									document.pform.aesKeyLen.value = "%value aesKeyLength%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow">Encrypt Key</td>
							<td class="evenrow-l"><input type="text" name="secretKey" value="%value secretKey%" size="20" style="font-size:10pt;width:400">&nbsp;<input type="text" name="secretKeyLen" value="%value secretKeyLen%" disabled size="20" style="font-size:10pt;width:200;background-color:transparent;border:0">
							</td>
						</tr>
						<tr>
							<td class="evenrow">Encrypt Initial Vector</td>
							<td class="evenrow-l"><input type="text" name="initialVector" value="%value initialVector%" size="20" style="font-size:10pt;width:400">&nbsp;<input type="text" name="initialVectorLen" value="%value initialVectorLen%" disabled size="20" style="font-size:10pt;width:200;background-color:transparent;border:0">
							</td>
						</tr>
						<tr>
							<td class="action" colspan="2">
								<!--<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '', '')"></input>-->
								<input type="button" name="SUBMIT" value="Save Properties" onclick="checkServiceNode('update')"></input>
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
								<td class="evenrow" width="30%">Target System Name</td>
								<td class="evenrow-l" width="70%">
									<select name="sSystemName" style="width:300">
										<option value="">ALL</option>
										%loop SystemNameDescList%
											<option value="%value systemNameValue%">%value systemNameDisplay%</option>
										%endloop%
									</select>
									<script language="javascript">
										document.pform.sSystemName.value = "%value sSystemName%";
									</script>
								</td>
							</tr>
							<tr>
								<td class="evenrow" width="30%">Asynch Online YN</td>
								<td class="evenrow-l" width="70%">
									<select name="sOnline" style="width:300">
										<option value="">ALL</option>
										<option value="Yes">Yes</option>
										<option value="No">No</option>
									</select>
									<script language="javascript">
										document.pform.sOnline.value = "%value sOnline%";
									</script>
								</td>
							</tr>
							<tr>
								<td class="action" colspan="2">
									<input type="button" name="SUBMIT" value="Search"  onclick="return doAction('remoteSearch', '', '')"></input>
								</td>
							</tr>
						</tr>			
					</table>
					
					<table class="tableForm" width="100%">
					<tr>
						<td class="heading" colspan=11>Remote Server Socket Information</td>
					</tr>
					<tr class="subheading2">
						<td>Enabled</td>
						<td>Provider System Name</td>
						<td>Socket Name</td>
						<td>Description</td>
						<td>IP</td>
						<td>Port Number</td>
						<td>Read Timeout</td>
						<td>Asynch Online YN</td>
						<td>Listener Service</td>
						<!--<td>Test</td>-->
						<td>Edit</td>
						<td>Delete</td>
					</tr>
					%ifvar -notempty ClientPortConfig/Ports%
						%loop ClientPortConfig/Ports%
							<tr>
								<td class="evenrowdata">
									%ifvar enabled equals('enabled')%
										%ifvar online equals('Yes')%
											%ifvar updateAvailable equals('true')%
												<img src="%value ../../designPath%images/enabled.gif" alt="enabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('usingYes', '%value name%', '')">Yes</a>
											%else%
												%ifvar updateAvailable equals('false')%
													<img src="%value ../../designPath%images/enabled.gif" alt="enabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('notAvailable', '%value name%', '')">Yes</a>
												%else%
													<img src="%value ../../designPath%images/enabled.gif" alt="enabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('notAvailableOther', '%value name%', '')">Yes</a>
												%endifvar%
											%endifvar%
										%else%
											<img src="%value ../../designPath%images/enabled.gif" alt="enabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('usingYes', '%value name%', '')">Yes</a>
										%endifvar%
									%else%
										<img src="%value ../../designPath%images/close.gif" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('usingNo', '%value name%', '')">No</a>
									%endifvar%
								</td>
								<td>%value systemName%</td>
								<td><a href="javascript:moveDocList('%value name%')">%value name%</a></td>
								<td>%value description%</td>
								<td>%value ip%</td>
								<td class="evenrowdata">%value port%</td>
								<td class="evenrowdata">%value readTimeout%</td>
								<td class="evenrowdata">%value online%</td>
								<td class="evenrowdata">%value servicePath%</td>
								<!--<td class="evenrowdata">
									<a href="javascript:doAction('connectTest', '%value name%', '%value online%')"><img src="%value ../../designPath%icons/checkdot.png" alt="Test" border="0"></a>
								</td>-->
								<td class="evenrowdata">
									%ifvar online equals('Yes')%
										%ifvar updateAvailable equals('true')%
											<a href="javascript:doAction('read', '%value name%', '')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
										%else%
											%ifvar updateAvailable equals('false')%
												<a href="javascript:doAction('readNotAvailable', '%value name%', '')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
											%else%
												<a href="javascript:doAction('readNotAvailableOther', '%value name%', '')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
											%endifvar%
										%endifvar%
									%else%
										<a href="javascript:doAction('read', '%value name%', '')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
									%endifvar%
								</td>
								<td class="evenrowdata">
									%ifvar online equals('Yes')%
										%ifvar updateAvailable equals('true')%
											<a href="javascript:doAction('delete', '%value name%', '')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
										%else%
											%ifvar updateAvailable equals('false')%
												<a href="javascript:doAction('deleteNotAvailable', '%value name%', '')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
											%else%
												<a href="javascript:doAction('deleteNotAvailableOther', '%value name%', '')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
											%endifvar%
										%endifvar%
									%else%
										<a href="javascript:doAction('delete', '%value name%', '')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
									%endifvar%
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=11>No remote server sockets are currently registered.</td></tr>
					%endifvar%
				</table>
				%endifvar%
			%endifvar%
		%endifvar%

		</form>
		<iframe id="createKeyIvFrame" name="createKeyIvForm" src="socket-iframe.dsp" style="display:none;">			
		</iframe>
	</body>
</html>

%endinvoke%