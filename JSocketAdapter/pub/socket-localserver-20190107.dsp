%invoke JSocketAdapter.ADMIN:adminLocalServer%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, pnum){
				var frm = document.pform;
				frm.todo.value = todo;
				if(pnum != '')
					frm.portNumber.value = pnum;
				if(todo == 'delete') {
					if(confirm("Do you really want to delete listener for port " + pnum)) {
						frm.submit()
					}
				} else if (todo == 'runningYes') {
					frm.todo.value = 'running';
					frm.runvalue.value = 'Yes';
					frm.submit();
				} else if (todo == 'runningNo') {
					frm.todo.value = 'running';
					frm.runvalue.value = 'No';
					frm.submit();
				} else if (todo == 'add' || todo == "update") {
					var online = frm.online.value;
					var sessionCount = frm.tempSessionCount.value;
					var direction = frm.direction.value;
					var outPortNumber = frm.outPortNumber.value;
					var threadPool = frm.threadPool.value;
					var poolSize = frm.poolSize.value;
					
					if (online == "No") {
						if (threadPool == "true" && (poolSize == "" || poolSize == "0")) {
							alert("Thread Pool을 사용하는 경우에는 Max Pool Size를 0보다 큰 값을 입력해야 합니다.");
							return;
						}
						
						frm.allowedSessionCount.value = "";
						frm.submit();
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
							frm.submit();
						}
					}
				} else {
					frm.submit();
				}
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
					document.pform.direction.disabled = false;
					document.pform.outPortNumber.disabled = false;
				} else {
					document.pform.tempSessionCount.value = "";
					document.pform.allowedSessionCount.value = "";
					document.pform.direction.value = "IN";
					document.pform.outPortNumber.value = "";
					document.pform.tempSessionCount.disabled = true;
					document.pform.direction.disabled = true;
					document.pform.outPortNumber.disabled = true;
				}
			}
			
			function enableOutPort(direction) {
				if (direction == "IN") {
					document.pform.outPortNumber.disabled = false;
				} else {
					document.pform.outPortNumber.value = "";
					document.pform.outPortNumber.disabled = true;
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
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="oldPort" value="%value portNumber%">
		<input type="hidden" name="runvalue" value="">
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
		%ifvar todo -notempty%
			<ul class="listitems">
				<li class="listitem"><a href="socket-localserver.dsp">Return to Local Server Socket Information</a></li>
			</ul>
		%else%
			<input type="hidden" name="portNumber" value="">
				<ul class="listitems">
					<li class="listitem"><a href="javascript:doAction('create', '')">Create New Local Server Socket</a></li>	
				</ul>
		%endifvar%
		<table class="tableForm" width="100%">	
			%ifvar todo equals('create')%
				<tr>
					<td class="heading" colspan="2">Local Server Socket Properties</td>
				</tr>
				<tr>
					<tr>
						<td class="evenrow" width="30%">Opened</td>
						<td class="evenrow-l" width="70%">Closed</td>
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
						<td class="evenrow-l"><input type="text" name="servicePath" size="20" style="font-size:10pt;width:400"></td>
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
						<td class="evenrow">First Reading Length</td>
						<td class="evenrow-l"><input type="text" name="firstReadingLength" size="6" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow">Length Field Start Index</td>
						<td class="evenrow-l"><input type="text" name="lengthStartOffset" size="6" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow">Length Field Length</td>
						<td class="evenrow-l"><input type="text" name="lengthCount" size="6" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow">Common Header Length</td>
						<td class="evenrow-l"><input type="text" name="commonHeaderLength" size="6" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Asynch Online YN</td>
						<td class="evenrow-l" width="70%">
							<select name="online" style="width:100" onchange="javascript:enableSessionCount(this.value)">
								<option value="No">No</option>
								<option value="Yes">Yes</option>
							</select>&nbsp;&nbsp;&nbsp;&nbsp;
							Allowed Session Count&nbsp;<input type="text" name="tempSessionCount" disabled style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="hidden" name="allowedSessionCount" value="">
							Direction&nbsp;
							<select name="direction" disabled style="width:100" onchange="javascript:enableOutPort(this.value)">
								<option value="IN">수신전용</option>
								<option value="INOUT">송수신겸용</option>
							</select>&nbsp;&nbsp;&nbsp;&nbsp;송신전용 Port Number&nbsp;<input type="text" name="outPortNumber" disabled style="font-size:10pt;width:50">
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
							<input type="button" name="SUBMIT" value="Create Local Server"  onclick="return doAction('add', '')"></input>
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
							<td class="evenrow" width="30%">Opened</td>
							<td class="evenrow-l" width="70%">Closed</td>
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
							<td class="evenrow-l"><input type="text" name="servicePath" value="%value servicePath%" size="20" style="font-size:9pt;width:400"></td>
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
							<td class="evenrow">First Reading Length</td>
							<td class="evenrow-l"><input type="text" name="firstReadingLength" value="%value firstReadingLength%" size="6" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow">Length Field Start Index</td>
							<td class="evenrow-l"><input type="text" name="lengthStartOffset" value="%value lengthStartOffset%" size="6" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow">Length Field Length</td>
							<td class="evenrow-l"><input type="text" name="lengthCount" value="%value lengthCount%" size="6" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow">Common Header Length</td>
							<td class="evenrow-l"><input type="text" name="commonHeaderLength" value="%value commonHeaderLength%" size="6" style="font-size:10pt;width:400"></td>
						</tr>
						<tr>
							<td class="evenrow">Asynch Online YN</td>
							<td class="evenrow-l">
								<select name="online" style="width:100" onchange="javascript:enableSessionCount(this.value)">
									<option value="No">No</option>
									<option value="Yes">Yes</option>
								</select>
								<script language="javascript">
									document.pform.online.value = "%value online%";
								</script>&nbsp;&nbsp;&nbsp;&nbsp;
								Allowed Session Count&nbsp;
								%ifvar online equals('No')%
									<input type="text" name="tempSessionCount" disabled style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="hidden" name="allowedSessionCount" value="">
									Direction&nbsp;
									<select name="direction" disabled style="width:100" onchange="javascript:enableOutPort(this.value)">
										<option value="IN">수신전용</option>
										<option value="INOUT">송수신겸용</option>
									</select>&nbsp;&nbsp;&nbsp;&nbsp;송신전용 Port Number&nbsp;<input type="text" name="outPortNumber" disabled style="font-size:10pt;width:50">
								%else%
									<input type="text" name="tempSessionCount" value="%value allowedSessionCount%" style="font-size:10pt;width:50">&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="hidden" name="allowedSessionCount" value="%value allowedSessionCount%">
									Direction&nbsp;
									<select name="direction" style="width:100" onchange="javascript:enableOutPort(this.value)">
										<option value="IN">수신전용</option>
										<option value="INOUT">송수신겸용</option>
									</select>
									<script language="javascript">
										document.pform.direction.value = "%value direction%";
									</script>&nbsp;&nbsp;&nbsp;&nbsp;
									%ifvar direction equals('IN')%
										송신전용 Port Number&nbsp;<input type="text" name="outPortNumber" value="%value outPortNumber%" style="font-size:10pt;width:50">
									%else%
										송신전용 Port Number&nbsp;<input type="text" name="outPortNumber" disabled style="font-size:10pt;width:50">
									%endifvar%
								%endifvar%
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
								<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>
							</td>
						</tr>
					</tr>
				%else%
					%ifvar -notempty ServerPortConfig/Ports%
						<tr>
							<td class="action" colspan=11>
								<input type="button" name="SUBMIT" value="All Port Open"  onclick="return doAction('runAll', '')"></input>&nbsp;&nbsp;
								<input type="button" name="SUBMIT" value="All Port Close"  onclick="return doAction('downAll', '')"></input>&nbsp;&nbsp;
							</td>
						</tr>
					%endifvar%
					<tr>
						<td class="heading" colspan=11>Local Server Socket Information</td>
					</tr>
					<tr class="subheading2">
						<td>Opened</td>
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
						%loop ServerPortConfig/Ports%
							<tr>
								<td class="evenrowdata">
									%ifvar enabled equals('true')%
										<img src="%value ../../designPath%images/enable_icon_16.png" alt="enabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('runningYes', '%value portNumber%')">Yes</a>
									%else%
										<img src="%value ../../designPath%images/disable_icon_16.png" alt="disabled" border="0">&nbsp;&nbsp;&nbsp;<a href="javascript:doAction('runningNo', '%value portNumber%')">No</a>
									%endifvar%
								</td>
								<td class="evenrowdata">%value portNumber%
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
										<img src="%value ../../designPath%icons/tmpldot.gif" alt="disabled Edit" border="0"></a>	
									%else%									
										<a href="javascript:doAction('read', '%value portNumber%')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
									%endifvar%								
								</td>
								<td class="evenrowdata">
									%ifvar enabled equals('true')%
										<img src="%value ../../designPath%icons/delete_disabled.png" alt="Disable Local Server Socket to Delete" border=0>
									%else%
										<a href="javascript:doAction('delete', '%value portNumber%')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
									%endifvar%
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=11>No local server sockets are currently registered.</td></tr>
					%endifvar%
				%endifvar%
			%endifvar%
		%endifvar%
		</table>
		</form>
		<iframe id="createKeyIvFrame" name="createKeyIvForm" src="socket-iframe.dsp" style="display:none;">			
		</iframe>
	</body>
</html>

%endinvoke%