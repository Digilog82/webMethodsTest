%invoke JSocketAdapter.ADMIN:adminLocalServer%

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
			
			function doAction(todo, pnum){
				var frm = document.pform;
				frm.todo.value = todo;
				var devProdType = "%value devProdType%";
				var serverDuplexing = "%value serverDuplexing%";
				var serverType = "";
				
				if (devProdType.indexOf("DEV") >= 0) {
					serverType = "개발";
				} else if (devProdType.indexOf("UAT") >= 0) {
					serverType = "UAT";
				} else if (devProdType.indexOf("PROD") >= 0) {
					serverType = "운영";
				}
				
				if(pnum != '') {
					frm.portNumber.value = pnum;
				}
				
				if (todo == 'localSearch') {
					frm.portStatusCheck.value = 'true';
				} else {
					frm.portStatusCheck.value = 'false';
				}
				
				if (todo == 'delete') {
					if(confirm("Do you really want to delete listener for port " + pnum)) {
						frm.submit()
					}
				} else if (todo == 'deleteNotAvailable') {
					alert("한 쪽 서버에서만 Running 하는 Port 입니다.\n다른 운영서버에서 Running 중이므로 Port 정보를 삭제할 수 없습니다.");
					return;
				} else if (todo == 'readNotAvailable') {
					alert("한 쪽 서버에서만 Running 하는 Port 입니다.\n다른 운영서버에서 Running 중이므로 Port 정보 조회만 가능하고 정보를 수정할 수 없습니다.");
					frm.todo.value = 'read';
					frm.updateAvailable.value = 'false';
					frm.submit();
				} else if (todo == 'readNotAvailable2') {
					alert("Port가 Running 중이므로 Port 정보 조회만 가능하고 정보를 수정할 수 없습니다.");
					frm.todo.value = 'read';
					frm.updateAvailable.value = 'false2';
					frm.submit();
				} else if (todo == 'runningYes') {
					/*
					// 다른 서버의 Port를 Down 시키지 않을 경우 Online Client 연결 갯수 동기화 등의 문제가 생기므로 아래 기능은 사용하지 않는다.
					if (serverDuplexing == "true") {
						// Clustering을 구성하는 서버가 두 대 이상인 경우 ==> 다른 서버의 Port도 Down 시킬 것인지 확인한다.
						if(confirm("Port Number " + pnum + "이 다른 " + serverType + "서버에서도 Running 중이라면 다른 " + serverType + "서버의 Port도 Down 시키시겠습니까?")) {
						} else {
							// 다른 서버의 Port는 Down 시키지 않는다.
							frm.remoteInvoke.value = 'skip';
						}
					}
					*/
					
					frm.todo.value = 'running';
					frm.runvalue.value = 'Yes';
					frm.submit();
				} else if (todo == 'runningNo') {
					frm.todo.value = 'running';
					frm.runvalue.value = 'No';
					frm.submit();
				} else if (todo == 'notAvailable') {
					alert("한 쪽 서버에서만 Running 하는 Port 입니다.\n다른 운영서버에서 Running 중이므로 현재 서버에서는 Running 할 수 없습니다.");
					return;
				} else if (todo == 'runAll' || todo == 'downAll') {
					var openClose = "";
					
					if (todo == 'runAll') {
						openClose = "open";
					} else {
						openClose = "close";
					}
					
					/*
					// 다른 서버의 Port를 Down 시키지 않을 경우 Online Client 연결 갯수 동기화 등의 문제가 생기므로 아래 기능은 사용하지 않는다.
					if (openClose == "close") {
						if (serverDuplexing == "true") {
							// Clustering을 구성하는 서버가 두 대 이상인 경우 ==> 다른 서버의 Port도 Down 시킬 것인지 확인한다.
							if(confirm("다른 " + serverType + "서버에서도 Running 중인 Port가 있는 경우 다른 " + serverType + "서버의 Port도 Down 시키시겠습니까?")) {
							} else {
								// 다른 서버의 Port는 Down 시키지 않는다.
								frm.remoteInvoke.value = 'skip';
							}
						}
					}
					*/
					
					for (var i=0; i < frm.length; i++) {
						if (frm.elements[i].checked) {
							if (frm.selectedList.value == "") {
								frm.selectedList.value = frm.elements[i].value;
							} else {
								frm.selectedList.value = frm.selectedList.value + "/" + frm.elements[i].value;
							}
						}
					}
					
					if (frm.selectedList.value == "") {
						if(confirm("Do you really want to " + openClose + " below all local server sockets?")) {
							for (var i=0; i < frm.length; i++) {
								var eleName = frm.elements[i].name;
								var nameIndex = eleName.indexOf("selectedList");
								
								if (nameIndex >= 0) {
									if (frm.selectedList.value == "") {
										frm.selectedList.value = frm.elements[i].value;
									} else {
										frm.selectedList.value = frm.selectedList.value + "/" + frm.elements[i].value;
									}
								}
							}
							
							frm.submit();
						}
					} else {
						frm.submit();
					}
				} else if (todo == 'add' || todo == "update") {
					var updateAvailable = frm.updateAvailable.value;
					var online = frm.online.value;
					var sessionCount = frm.tempSessionCount.value;
					var direction = frm.direction.value;
					var outPortNumber = frm.outPortNumber.value;
					var threadPool = frm.threadPool.value;
					var poolSize = frm.poolSize.value;
					var portDuplexing = frm.portDuplexing.value;
					var serialProcessing = frm.serialProcessing.value;
					var servicePath = frm.servicePath.value;
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
						alert("한 쪽 서버에서만 Running 하는 Port 입니다.\n다른 운영서버에서 Running 중이므로 Port 정보 조회만 가능하고 정보를 수정할 수 없습니다.");
						return;
					} else if (updateAvailable == "false2") {
						alert("Port가 Running 중이므로 Port 정보 조회만 가능하고 정보를 수정할 수 없습니다.");
						return;
					}
					
					if (servicePath == "") {
						/*
						// Asynch Online Socket Object 동기화는 현재 사용하지 않는 기능
						if (confirm("Listener Service를 입력하지 않았습니다.\nAsynch Online Socket Object를 동기화 처리하기 위한 Port 등록 시에만 Listener Service를 입력하지 않아도 됩니다.\nAsynch Online Socket Object 동기화 Port를 등록하는 것입니까?")) {
							if (threadPool == "true") {
								alert("Asynch Online Socket Object 동기화 Port를 등록하는 경우에는 Thread Pool Usage는 No를 선택 하십시요.");
								return;
							}
							
							if (online == "Yes") {
								alert("Asynch Online Socket Object 동기화 Port를 등록하는 경우에는 Asynch Online YN은 No를 선택 하십시요.");
								return;
							}
						} else {
							return;
						}
						*/
						
						if (confirm("Listener Service를 입력하지 않았습니다.\nListener Service가 없는 것이 맞습니까?")) {
						} else {
							return;
						}
					}
					
					if (serialProcessing == "Yes") {
						if (portDuplexing == "Yes") {
							if (online == "No") {
								//alert("Asynch Online이 아닌 Port에 대해서 순차처리를 해야 하는 경우에는 Port 이중화를 할 수 없습니다.");
								//return;
							} else {
								if (sessionCount > 1) {
									//alert("Asynch Online Port를 이중화 해서 순차처리를 해야 하는 경우에는 Allowed Session Count를 1로 해야 합니다.");
									//return;
								}
							}
						} else {
							if (online == "Yes") {
								if (sessionCount > 1) {
									//alert("Asynch Online Port에 대해서 순차처리를 해야 하는 경우에는 Allowed Session Count를 1로 해야 합니다.");
									//return;
								}
							}
						}
						
						if (threadPool == "true") {
							alert("순차처리를 해야 하는 경우에는 Thread Pool을 사용할 수 없습니다.");
							return;
						}
					}
					
					if (online == "No") {
						if (threadPool == "true" && (poolSize == "" || poolSize == "0")) {
							alert("Thread Pool을 사용하는 경우에는 Max Pool Size를 0보다 큰 값을 입력해야 합니다.");
							return;
						}
						
						frm.allowedSessionCount.value = "";
						//frm.submit();
					} else {
						if (threadPool == "true") {
							alert("Asynch Online Server인 경우에는 Thread Pool을 사용할 수 없습니다.");
							return;
						}
						
						if (sessionCount == "" || sessionCount == "0") {
							alert("Asynch Online Server인 경우에는 Allowed Session Count를 0보다 큰 값을 입력해야 합니다.");
							return;
						} else {
							if (direction == "IN" && outPortNumber == "") {
								alert("Asynch Online Server 수신전용 Port에 대한 송신전용 Port Number를 입력해야 합니다.");
								return;
							}
							
							frm.allowedSessionCount.value = sessionCount;
							//frm.submit();
						}
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
				} else {
					frm.submit();
				}
			}
			
			function moveDocList(portNumber) {				
				document.pform.todo.value = "docSearch";
				document.pform.sListeningPort.value = portNumber;
				document.pform.fromLocalServer.value = "true";
				document.pform.action = "basic-docinterfaceid.dsp";
				document.pform.submit();
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
			
			function enableSessionCount(aOnline) {
				if (aOnline == "Yes") {
					document.pform.tempSessionCount.disabled = false;
					document.pform.realSessionCount.disabled = false;
					document.pform.direction.disabled = false;
					document.pform.outPortNumber.disabled = false;
					document.pform.outListenYN.disabled = false;
				} else {
					document.pform.tempSessionCount.value = "";
					document.pform.allowedSessionCount.value = "";
					document.pform.realSessionCount.value = "";
					document.pform.direction.value = "IN";
					document.pform.outPortNumber.value = "";
					document.pform.tempSessionCount.disabled = true;
					document.pform.realSessionCount.disabled = true;
					document.pform.direction.disabled = true;
					document.pform.outPortNumber.disabled = true;
					document.pform.outListenYN.disabled = true;
				}
			}
			
			function enableOutPort(direction) {
				if (direction == "IN") {
					document.pform.outPortNumber.disabled = false;
					document.pform.outListenYN.disabled = false;
				} else {
					document.pform.outPortNumber.value = "";
					document.pform.outPortNumber.disabled = true;
					document.pform.outListenYN.disabled = true;
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
			
			function alertMsg() {
				var frm = document.pform;
				var msg = frm.alertMsg.value;
				var alertMsgCount = "%value alertMsgCount%";
				
				if (alertMsgCount.length >= 2) {
					window.open('/JSocketAdapter/socket-alertmsg.dsp?alertMsg=' + msg, '', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
					frm.alertMsg.value = ""; // 다른 화면으로 이동 시 영향을 주기 때문에 alertMsg 를 공백처리 한다.
				} else {
					if (msg != "") {
						alert(msg);
						frm.alertMsg.value = ""; // 다른 화면으로 이동 시 영향을 주기 때문에 alertMsg 를 공백처리 한다.
					}
				}
				
				var todo = "%value todo%";
				
				if (todo == "read") {
					var alg = frm.algorithm.value;
					
					if (alg == "AES") {
						document.all.aesKeyLength.style.display="";
					} else {
						document.all.aesKeyLength.style.display="none";
					}
				}
			}
		</script>
	</head>
	<body onload="javascript:alertMsg()">
		
		%ifvar changed equals('true')%
			<form name="dform" method="post">
				<input type="hidden" name="todo" value="localSearch">
				<input type="hidden" name="portStatusCheck" value="true">
				<input type="hidden" name="alertMsg" value="%value alertMsg%">
				<input type="hidden" name="alertMsgCount" value="%value alertMsgCount%">
				<input type="hidden" name="sPortNumber" value="%value sPortNumber%">
				<input type="hidden" name="sEnabled" value="%value sEnabled%">
				<input type="hidden" name="sOnline" value="%value sOnline%">
			</form>
			<script langauge='javascript'>
				document.dform.submit();
			</script>
		%endifvar%
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		%invoke wm.server.access:userList%
		%endinvoke%
		<form name="pform" method="post" target="_self">
		<table width="100%">
			<tr>
				%ifvar todo equals('create')%
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Server Socket &gt;
						Local Server Socket &gt;
						Create Local Server Socket
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Server Socket &gt;
							Local Server Socket &gt;
							Edit Local Server Socket
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Server Socket &gt;
							Local Server Socket
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		<input type="hidden" id="todo" name="todo" value="">
		<input type="hidden" name="oldPort" value="%value portNumber%">
		<input type="hidden" name="runvalue" value="">
		<input type="hidden" name="updateAvailable" value="%value updateAvailable%">
		<input type="hidden" name="checkMode" value="uncheck">
		<input type="hidden" name="selectedList" value="">
		<input type="hidden" name="secretKeyDES" value="%value secretKeyDES%">
		<input type="hidden" name="initialVectorDES" value="%value initialVectorDES%">
		<input type="hidden" name="secretKeyDESede" value="%value secretKeyDESede%">
		<input type="hidden" name="initialVectorDESede" value="%value initialVectorDESede%">
		<input type="hidden" name="secretKeyAES" value="%value secretKeyAES%">
		<input type="hidden" name="secretKeyAES24" value="%value secretKeyAES24%">
		<input type="hidden" name="secretKeyAES32" value="%value secretKeyAES32%">
		<input type="hidden" name="initialVectorAES" value="%value initialVectorAES%">
		<input type="hidden" name="portStatusCheck" value="true">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		<input type="hidden" name="sListeningPort" value="">
		<input type="hidden" name="fromLocalServer" value="">
		%ifvar todo equals('localSearch')%
			<input type="hidden" name="portNumber" value="">
			<ul class="listitems">
				<li class="listitem"><a href="javascript:doAction('create', '')">Create New Local Server Socket</a></li>	
			</ul>			
		%else%
			<ul class="listitems">
				<li class="listitem"><a href="socket-localserver.dsp?todo=localSearch&portStatusCheck=true&sPortNumber=%value sPortNumber%&sEnabled=%value sEnabled%&sOnline=%value sOnline%">Return to Local Server Socket Information</a></li>
			</ul>
		%endifvar%
		<table class="tableForm" width="100%">	
			%ifvar todo equals('create')%
				<tr>
					<td class="heading" colspan="2">Local Server Socket Properties</td>
				</tr>
				<tr>
					<tr>
						<td class="evenrow" width="30%">Enabled</td>
						<td class="evenrow-l" width="70%">No</td>
					</tr>
					<tr>
						<td class="evenrow">Port Number</td>
						<td class="evenrow-l"><input type="text" name="portNumber" size="6" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow">Description</td>
						<td class="evenrow-l"><input type="text" name="description" size="6" style="font-size:10pt;width:400"></td>
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
						</td>
					</tr>
					<tr>
						<td class="evenrow">Distributer Service</td>
						<td class="evenrow-l">														
							<input type="text" name="disServicePath" size="20" style="font-size:10pt;width:400">
						</td>
					</tr>
					<tr>
						<td class="evenrow">Health Check Response Service</td>
						<td class="evenrow-l">														
							<input type="text" name="healthCheckResServicePath" size="20" style="font-size:10pt;width:400">
						</td>
					</tr>
					<tr>
						<td class="evenrow">Run As</td>
						<td class="evenrow-l">
							<select name="runAs" style="width:100">
								%loop users%
									<option value="%value name%">%value name%</option>
								%endloop%
							</select>
						</td>
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
							Client's Real Session Count&nbsp;<input type="text" name="realSessionCount" style="font-size:10pt;width:50"><br><br>
							Direction&nbsp;
							<select name="direction" style="width:100" onchange="javascript:enableOutPort(this.value)">
								<option value="IN">수신전용</option>
								<option value="INOUT">송수신겸용</option>
							</select>&nbsp;&nbsp;&nbsp;&nbsp;
							송신전용 Port Number&nbsp;<input type="text" name="outPortNumber" style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;&nbsp;
							송신전용 Port Listen YN&nbsp;
							<select name="outListenYN" style="width:100">
								<option value="No">No</option>
								<option value="Yes">Yes</option>
							</select>
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
						<td class="evenrow" width="30%">Thread Pool Usage</td>
						<td class="evenrow-l" width="70%">
							<select name="threadPool" style="width:100">
								<option value="false">No</option>
								<option value="true">Yes</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow">Max Pool Size</td>
						<td class="evenrow-l"><input type="text" name="poolSize" size="6" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Port Multi-Opening YN</td>
						<td class="evenrow-l" width="70%">
							<select name="portDuplexing" style="width:100">
								<option value="Yes">Yes</option>
								<option value="No">No</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Serial Processing YN</td>
						<td class="evenrow-l" width="70%">
							%ifvar customerCode equals('HSC')%
								<!-- 현대제철 전용 -->
								<select name="serialProcessing" style="width:100">
									<option value="Yes">Yes</option>
									<option value="No">No</option>								
								</select>
								<!-- 현대제철 전용 -->
							%else%
								<select name="serialProcessing" style="width:100">
									<option value="No">No</option>
									<option value="Yes">Yes</option>																	
								</select>
							%endifvar%
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
						<td class="evenrow-l"><input type="text" name="secretKey" size="20" style="font-size:10pt;width:400">&nbsp;<input type="text" name="secretKeyLen" disabled size="20" style="font-size:10pt;width:200;background-color:transparent;border:0">
						</td>
					</tr>
					<tr>
						<td class="evenrow">Encrypt Initial Vector</td>
						<td class="evenrow-l"><input type="text" name="initialVector" size="20" style="font-size:10pt;width:400">&nbsp;<input type="text" name="initialVectorLen" disabled size="20" style="font-size:10pt;width:200;background-color:transparent;border:0">
						</td>
					</tr>
					<tr>
						<td class="action" colspan="2">
							<!--<input type="button" name="SUBMIT" value="Create Local Server"  onclick="return doAction('add', '')"></input>-->
							<input type="button" name="SUBMIT" value="Create Local Server" onclick="checkServiceNode('add')"></input>
						</td>
					</tr>
				</tr>
			%else%
				%ifvar todo equals('read')%
					<tr>
						<td class="heading" colspan="2">Local Server Socket Properties</td>
					</tr>
					<tr>
						<tr>
							<td class="evenrow" width="30%">Enabled</td>
							<td class="evenrow-l" width="70%">
								%ifvar enabled equals('true')%
									Yes
								%else%
									No
								%endifvar%
							</td>
						</tr>
						<tr>
							<td class="evenrow">Port Number</td>
							<td class="evenrow-l"><input type="text" name="portNumber" value="%value portNumber%" size="6" style="font-size:9pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow">Description</td>
							<td class="evenrow-l"><input type="text" name="description" value="%value description%" size="6" style="font-size:9pt;width:400"></td>
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
									<input type="text" name="servicePath" value="%value servicePath%" size="20" style="font-size:9pt;width:400">
								%endifvar%
							</td>
						</tr>
						
						<tr>
							<td class="evenrow">Distributer Service</td>
							<td class="evenrow-l">														
								<input type="text" name="disServicePath" value="%value disServicePath%" size="20" style="font-size:10pt;width:400">
							</td>
						</tr>
						
						<tr>
							<td class="evenrow">Health Check Response Service</td>
							<td class="evenrow-l">														
								<input type="text" name="healthCheckResServicePath" value="%value healthCheckResServicePath%" size="20" style="font-size:10pt;width:400">
							</td>
						</tr>
						
						<tr>
							<td class="evenrow">Run As</td>
							<td class="evenrow-l">
								<select name="runAs" style="width:100">
									%loop users%
										<option value="%value name%">%value name%</option>
									%endloop%
								</select>
								<script language="javascript">
									document.pform.runAs.value = "%value runAs%";
								</script>
							</td>
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
							<td class="evenrow">Asynch Online YN</td>
							<td class="evenrow-l">
								<select name="online" style="width:100" onchange="javascript:enableSessionCount(this.value)">
									<option value="Yes">Yes</option>
									<option value="No">No</option>									
								</select>
								<script language="javascript">
									document.pform.online.value = "%value online%";
								</script>&nbsp;&nbsp;&nbsp;&nbsp;
								Allowed Session Count&nbsp;
								%ifvar online equals('No')%
									<input type="text" name="tempSessionCount" disabled style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="hidden" name="allowedSessionCount" value="">
									Client's Real Session Count&nbsp;<input type="text" name="realSessionCount" value="" disabled style="font-size:10pt;width:50"><br><br>
									Direction&nbsp;
									<select name="direction" disabled style="width:100" onchange="javascript:enableOutPort(this.value)">
										<option value="IN">수신전용</option>
										<option value="INOUT">송수신겸용</option>
									</select>&nbsp;&nbsp;&nbsp;&nbsp;
									송신전용 Port Number&nbsp;<input type="text" name="outPortNumber" disabled style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;&nbsp;
									송신전용 Port Listen YN&nbsp;
									<select name="outListenYN" disabled style="width:100">
										<option value="No">No</option>
										<option value="Yes">Yes</option>
									</select>
								%else%
									<input type="text" name="tempSessionCount" value="%value allowedSessionCount%" style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="hidden" name="allowedSessionCount" value="%value allowedSessionCount%">
									Client's Real Session Count&nbsp;<input type="text" name="realSessionCount" value="%value realSessionCount%" style="font-size:10pt;width:50"><br><br>
									Direction&nbsp;
									<select name="direction" style="width:100" onchange="javascript:enableOutPort(this.value)">
										<option value="IN">수신전용</option>
										<option value="INOUT">송수신겸용</option>
									</select>
									<script language="javascript">
										document.pform.direction.value = "%value direction%";
									</script>&nbsp;&nbsp;&nbsp;&nbsp;
									%ifvar direction equals('IN')%
										송신전용 Port Number&nbsp;<input type="text" name="outPortNumber" value="%value outPortNumber%" style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;&nbsp;
										송신전용 Port Listen YN&nbsp;
										<select name="outListenYN" style="width:100">
											<option value="No">No</option>
											<option value="Yes">Yes</option>
										</select>
										<script language="javascript">
											document.pform.outListenYN.value = "%value outListenYN%";
										</script>
									%else%
										송신전용 Port Number&nbsp;<input type="text" name="outPortNumber" disabled style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;&nbsp;
										송신전용 Port Listen YN&nbsp;
										<select name="outListenYN" disabled style="width:100">
											<option value="No">No</option>
											<option value="Yes">Yes</option>
										</select>
									%endifvar%
								%endifvar%
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
							<td class="evenrow" width="30%">Thread Pool Usage</td>
							<td class="evenrow-l" width="70%">
								<select name="threadPool" style="width:100">
									<option value="false">No</option>
									<option value="true">Yes</option>
								</select>
								<script language="javascript">
									document.pform.threadPool.value = "%value threadPool%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow">Max Pool Size</td>
							<td class="evenrow-l"><input type="text" name="poolSize" value="%value poolSize%" size="6" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Port Multi-Opening YN</td>
							<td class="evenrow-l" width="70%">
								<select name="portDuplexing" style="width:100">
									<option value="Yes">Yes</option>
									<option value="No">No</option>
								</select>
								<script language="javascript">
									document.pform.portDuplexing.value = "%value portDuplexing%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Serial Processing YN</td>
							<td class="evenrow-l" width="70%">
								%ifvar customerCode equals('HSC')%
									<!-- 현대제철 전용 -->
									<select name="serialProcessing" style="width:100">
										<option value="Yes">Yes</option>
										<option value="No">No</option>								
									</select>
									<!-- 현대제철 전용 -->
								%else%
									<select name="serialProcessing" style="width:100">
										<option value="No">No</option>
										<option value="Yes">Yes</option>																	
									</select>
								%endifvar%
								<script language="javascript">
									document.pform.serialProcessing.value = "%value serialProcessing%";
								</script>
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
								<!--<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>-->
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
								<td class="evenrow" width="30%">Port Number</td>
								<td class="evenrow-l" width="70%">
									<select name="sPortNumber" style="width:300">
										<option value="">ALL</option>
										%loop LocalPortNumberList%
											<option value="%value portNumberValue%">%value portNumberDisplay%</option>
										%endloop%
									</select>
									<script language="javascript">
										document.pform.sPortNumber.value = "%value sPortNumber%";
									</script>
								</td>
							</tr>
							<tr>
								<td class="evenrow" width="30%">Port Enabled Status</td>
								<td class="evenrow-l" width="70%">
									<select name="sEnabled" style="width:300">
										<option value="">ALL</option>
										<option value="true">Yes</option>
										<option value="false">No</option>
									</select>
									<script language="javascript">
										document.pform.sEnabled.value = "%value sEnabled%";
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
									<input type="button" name="SUBMIT" value="Search"  onclick="return doAction('localSearch', '')"></input>
								</td>
							</tr>
						</tr>			
					</table>
					
					<table class="tableForm" width="100%">
					%ifvar -notempty ServerPortConfig/Ports%
						<tr>
							<td class="action" colspan=11>
								<input type="button" name="SUBMIT" value="Port Enable"  onclick="return doAction('runAll', '')"></input>&nbsp;&nbsp;
								<input type="button" name="SUBMIT" value="Port Disable"  onclick="return doAction('downAll', '')"></input>&nbsp;&nbsp;
							</td>
						</tr>
					%endifvar%
					<tr>
						<td class="heading" colspan=12>Local Server Socket Information</td>
					</tr>
					<tr class="subheading2">
						<td>Select <a href="javascript:allChecked()">All</a></td>
						<td>Enabled</td>
						<td>Port Number</td>
						<td>Description</td>
						<td>Listener Service</td>						
						<td>Connected Session Count</td>
						<td>Asynch Online YN</td>
						<td>Thread Pool Usage</td>
						<td>Max Pool Size</td>
						<td>Created Pool Count</td>
						<td>Edit</td>
						<td>Delete</td>
					</tr>
					%ifvar -notempty ServerPortConfig/Ports%
						%loop ServerPortConfig/Ports -$index%
							<tr>
								<td class="evenrowdata"><input type="checkbox" name="selectedList%value $index%" value="%value portNumber%">
								<td class="evenrowdata">
									%ifvar enabled equals('true')%
										<img src="%value ../../designPath%images/enable_icon_16.png" alt="enabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('runningYes', '%value portNumber%')">Yes</a>
									%else%
										%ifvar portDuplexing equals('No')%
											%ifvar updateAvailable equals('true')%
												<img src="%value ../../designPath%images/disable_icon_16.png" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('runningNo', '%value portNumber%')">No</a>
											%else%
												<img src="%value ../../designPath%images/disable_icon_16.png" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('notAvailable', '%value portNumber%')">No</a>
											%endifvar%
										%else%
											<img src="%value ../../designPath%images/disable_icon_16.png" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('runningNo', '%value portNumber%')">No</a>
										%endifvar%
									%endifvar%
								</td>
								<td class="evenrowdata"><a href="javascript:moveDocList('%value portNumber%')">%value portNumber%</a>
									%ifvar outPortNumber -notempty%
										(%value outPortNumber%)
									%endifvar%
								</td>
								<td>%value description%</td>
								<td>%value servicePath%</td>								
								<td class="evenrowdata">%value connectCount%</td>
								<td class="evenrowdata">%value online%</td>
								<td class="evenrowdata">
									%ifvar threadPool equals('true')%
										Yes
									%else%
										No
									%endifvar%
								</td>
								<td class="evenrowdata">%value poolSize%</td>
								<td class="evenrowdata">%value createdPoolCount%</td>
								<td class="evenrowdata">
									%ifvar enabled equals('true')%
										<!--<img src="%value ../../designPath%icons/tmpldot.gif" alt="disabled Edit" border="0">-->
										<a href="javascript:doAction('readNotAvailable2', '%value portNumber%')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
									%else%
										%ifvar portDuplexing equals('No')%
											%ifvar updateAvailable equals('true')%
												<a href="javascript:doAction('read', '%value portNumber%')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
											%else%
												<a href="javascript:doAction('readNotAvailable', '%value portNumber%')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
											%endifvar%
										%else%
											<a href="javascript:doAction('read', '%value portNumber%')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
										%endifvar%
									%endifvar%								
								</td>
								<td class="evenrowdata">
									%ifvar enabled equals('true')%
										<img src="%value ../../designPath%icons/delete_disabled.png" alt="Disable Local Server Socket to Delete" border=0>
									%else%
										%ifvar portDuplexing equals('No')%
											%ifvar updateAvailable equals('true')%
												<a href="javascript:doAction('delete', '%value portNumber%')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
											%else%
												<a href="javascript:doAction('deleteNotAvailable', '%value portNumber%')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
											%endifvar%
										%else%
											<a href="javascript:doAction('delete', '%value portNumber%')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
										%endifvar%
									%endifvar%
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=12>No local server sockets are currently registered.</td></tr>
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