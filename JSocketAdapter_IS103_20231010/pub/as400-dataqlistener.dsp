%invoke JSocketAdapter.ADMIN:adminDataQListener%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, pname){
				var frm = document.pform;
				frm.todo.value = todo;
				
				if (pname != '') {
					frm.notificationNodeName.value = pname;
				}
				
				if (todo == 'delete') {
					if(confirm("Do you really want to delete config of  " + pname)){
						frm.submit();
					}
				} else if (todo == 'add' || todo == 'update') {
					var nodeNames = frm.listenerNodeName.value;
					var nodeList = nodeNames.split('/');
					var nodeName = nodeList[0];
					var conAlias = nodeList[1];
					frm.notificationNodeName.value = nodeName;
					frm.connectionAlias.value = conAlias;
					frm.submit();
				} else {
					frm.submit();
				}
			}
			
			function alertMsg() {
				var frm = document.pform;
				var msg = frm.alertMsg.value;
				
				if (msg != "") {
					alert(msg);
					frm.alertMsg.value = ""; // 다른 화면으로 이동 시 영향을 주기 때문에 alertMsg 를 공백처리 한다.
				}
				
				var todo = frm.todo.value;
				
				if (todo == "create") {
					var systemName = frm.systemName.value;
					makeBusinessName(systemName);
					var businessName = frm.businessName.value;
					
					// Asynch Online Socket YN Set
					setAsynchOnlineSocket(businessName);					
				} else if (todo == "read") {
					var systemName = frm.systemName.value;
					var businessName = frm.businessName.value;
					makeBusinessName(systemName);
					
					// 업무명 Business Name Set.
					frm.businessName.value = businessName;
				}
			}
			
			function makeBusinessName(systemName) {
				var businessName = document.pform.businessName;
								
				for (var i=0; i < document.pform.length; i++) {
					if (document.pform.elements[i].name == systemName) {
						var businessNames = document.pform.elements[i].value;
						var tockens = businessNames.split("/");
					  
						// 기존의 Option 삭제
						while (businessName.options.length > 0) {
							businessName.options.remove(0);
						}
					
						// 해당 System Name에 속한 Business Name Option 추가
						for (var i = 0; i < tockens.length; i++) {
							businessName.options[i] = new Option(tockens[i], tockens[i]);
						}
					
						break;
					}
				}
			}
			
			function setAsynchOnlineSocket(businessName) {
				if (businessName == '') {
					businessName = document.pform.businessName.value;
				}
				
				for (var i=0; i < document.pform.length; i++) {
					if (document.pform.elements[i].name == businessName) {
						document.pform.tempOnline.value = document.pform.elements[i].value;
						document.pform.online.value = document.pform.elements[i].value;					
						break;
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
		
		<div class="message">IS Administrator > Adapters > AS/400 Adapter > Data Queue Listeners 메뉴에서 등록한 Listeners를 등록, 관리하는 메뉴입니다.</div>
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">
		<table width="100%">
			<tr>
				%ifvar todo equals('create')%
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						AS/400 &gt;
						Data Q Listener &gt;
						Register Data Q Listener
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							AS/400 &gt;
						  Data Q Listener &gt;
							Edit Data Q Listener
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							AS/400 &gt;
						  Data Q Listener
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		<input type="hidden" name="todo" value="%value todo%">
		<input type="hidden" name="oldNotificationNodeName" value="%value notificationNodeName%">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		
		%loop businessNameList%		
			<input type="hidden" name="%value systemName%" value="%value businessName%">			
		%endloop%
		
		%loop businessAsynchOnlineList%		
			<input type="hidden" name="%value businessName%" value="%value online%">			
		%endloop%
		
		%ifvar todo -notempty%
			<ul class="listitems">
				<li class="listitem"><a href="as400-dataqlistener.dsp">Return to Data Q Listener Information</a></li>
			</ul>
		%else%
			<input type="hidden" name="notificationNodeName" value="">		
				<ul class="listitems">
					<li class="listitem"><a href="javascript:doAction('create', '')">Register New Data Q Listener</a></li>
				</ul>
		%endifvar%
		
		<table class="tableForm" width="100%">	
			%ifvar todo equals('create')%
				<tr>
					<td class="heading" colspan="2">Data Q Listener Properties</td>
				</tr>
				<tr>
					<tr>
						<td class="evenrow" width="30%">Listener Node Name</td>
						<td class="evenrow-l" width="70%">
							<select name="listenerNodeName">
								%loop dataQueueListeners%
									<option value="%value notificationNodeName%/%value connectionAlias%">%value notificationNodeName%</option>
								%endloop%
							</select>
							<input type="hidden" name="notificationNodeName" value="">
							<input type="hidden" name="connectionAlias" value="">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Provider System Name</td>
						<td class="evenrow-l" width="70%">
							<select name="systemName" style="width:90" onchange="javascript:makeBusinessName(this.value);setAsynchOnlineSocket('')">
								%loop systemNameList%
									<option value="%value systemNameList%">%value systemNameList%</option>
								%endloop%
							</select>						
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Business Name</td>
						<td class="evenrow-l" width="70%">
							<select name="businessName" style="width:90" onchange="javascript:setAsynchOnlineSocket(this.value)">
							</select>						
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Asynch Online Socket YN</td>
						<td class="evenrow-l" width="70%">
							<!--
							<select name="online" style="width:90">
								<option value="No">No</option>
								<option value="Yes">Yes</option>								
							</select>
							-->
							<input type="text" name="tempOnline" disabled size="20" style="font-size:10pt;width:90">
							<input type="hidden" name="online" value="">
						</td>
					</tr>
					<tr>
						<td class="action" colspan="2">
							<input type="button" name="SUBMIT" value="Register Data Q Listener"  onclick="return doAction('add', '')"></input>
						</td>
					</tr>
				</tr>	
			%else%
				%ifvar todo equals('read')%
					<tr>
						<td class="heading" colspan="2">Data Q Listener Properties</td>
					</tr>
					<tr>
						<tr>
							<td class="evenrow" width="30%">Listener Node Name</td>
							<td class="evenrow-l" width="70%">
								<select name="listenerNodeName">
									%loop dataQueueListeners%
										<option value="%value notificationNodeName%/%value connectionAlias%">%value notificationNodeName%</option>
									%endloop%
								</select>						
								<script language="javascript">
									document.pform.listenerNodeName.value = "%value notificationNodeName%/%value connectionAlias%";
								</script>
								<input type="hidden" name="notificationNodeName" value="">
								<input type="hidden" name="connectionAlias" value="">
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Provider System Name</td>
							<td class="evenrow-l" width="70%">
								<select name="systemName" style="width:90" onchange="javascript:makeBusinessName(this.value);setAsynchOnlineSocket('')">
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
							<td class="evenrow" width="30%">Business Name</td>
							<td class="evenrow-l" width="70%">
								<select name="businessName" style="width:90" onchange="javascript:setAsynchOnlineSocket(this.value)">
									<option value="%value businessName%">%value businessName%</option>
								</select>						
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Asynch Online Socket YN</td>
							<td class="evenrow-l" width="70%">
								<!--
								<select name="online" style="width:90">
									<option value="No">No</option>
									<option value="Yes">Yes</option>								
								</select>
								<script language="javascript">
									document.pform.online.value = "%value online%";
								</script>
								-->
								<input type="text" name="tempOnline" value="%value online%" disabled size="20" style="font-size:10pt;width:90">
								<input type="hidden" name="online" value="%value online%">
							</td>
						</tr>
						<tr>
							<td class="action" colspan="2">
								<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>
							</td>
						</tr>
					</tr>
				%else%
					<tr>
						<td class="heading" colspan=7>Data Q Listener Information</td>
					</tr>
					<tr class="subheading2">
						<td>Listener Node Name</td>
						<td>Connection Alias</td>
						<td>Provider System Name</td>
						<td>Business Name</td>
						<td>Asynch Online Socket YN</td>
						<td>Edit</td>
						<td>Delete</td>
					</tr>
					%ifvar -notempty DataQListenerConfig/Items%
						%loop DataQListenerConfig/Items%
							<tr>
								<td>%value notificationNodeName%</td>
								<td>%value connectionAlias%</td>
								<td>%value systemName%</td>
								<td>%value businessName%</td>
								<td>%value online%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('read', '%value notificationNodeName%')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
								</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value notificationNodeName%')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan=7>No data q listeners are currently registered.</td></tr>
					%endifvar%
				%endifvar%
			%endifvar%
		%endifvar%
		</table>
		</form>
	</body>
</html>

%endinvoke%