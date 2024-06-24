%invoke JSocketAdapter.ADMIN:adminServerResourcesWarning%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction() {
				var frm = document.pform;
				var refreshTypeA;
				var refreshInterval = frm.refreshInterval.value;
				
				if (document.getElementById("refreshTypeA").checked) {
					refreshTypeA = true;
				} else {
					refreshTypeA = false;
				}
				
				if (refreshTypeA == true && refreshInterval == "") {
				  alert("Refresh Type이 Auto일 경우 Refresh Interval을 입력해야 합니다.");
				  return;
				}
				
				frm.submit();
			}
			
			function refreshPage() {
			  window.location.href = "utility-serverresourcewarning.dsp?refreshType=%value refreshType%&refreshInterval=%value refreshInterval%";
			}
			
			function alertWarning() {
				var warningStatus = "%value warningStatus%";
				var warningCount = %value warningCount%;
				var warningInterval = %value warningInterval%;
				var refreshType = "%value refreshType%";
				var refreshInterval = %value refreshInterval%;
				
				if (warningStatus == "true") {
					if (warningCount == 0) {
						// 0으로 설정되어 있으면 경고음으로 알리지 않는다.
					} else {
						var audioObj = new Audio('media/system_warning.mp3');
						
						for (var i = 0; i < warningCount; i++) {
							setTimeout(function() {audioObj.play();}, i * warningInterval * 1000);
						}
					}
				}
				
				if (refreshType == "auto") {
					setTimeout(function() {refreshPage();}, refreshInterval * 1000);
				}
			}
		</script>
	</head>
	
	<!-- onload 이벤트를 이용해서 alertWarning() 함수를 호출할 경우 화면이 정상적으로 Display 되지 않음. body 태그 끝난 후에 script를 이용해서 alertWarning() 함수를 호출한다. -->
	<body>
	
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Utility &gt;
						Server Resources Warning
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="4">Server Resources Display Properties</td>
			</tr>
			<tr>
				<td class="evenrow" width="15%">Refresh Type</td>
				<td class="evenrow-l" width="15%">
				  <input type="radio" id="refreshTypeA" name="refreshType" value="auto" %ifvar refreshType equals('auto')% checked %endifvar%>&nbsp;Auto&nbsp;
				  <input type="radio" id="refreshTypeM" name="refreshType" value="manual" %ifvar refreshType equals('manual')% checked %endifvar%>&nbsp;Manual					  
				<td class="evenrow" width="15%">Auto Refresh Interval</td>
				<td class="evenrow-l" width="55%">
				  <input type="text" name="refreshInterval" value="%value refreshInterval%" size="20" style="font-size:10pt;width:50">&nbsp;seconds&nbsp;
				  <input type="button" name="SUBMIT" value="Refresh"  onclick="return doAction()">
				</td>
			</tr>
		</table>
				
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="6">Server Resources</td>
			</tr>
			<tr class="subheading2">
				<td>Server Alias</td>
				<td>Server IP</td>
				<td>Resource Item</td>
				<td>Threshold</td>
				<td>Current Value</td>
				<td>Status</td>
			</tr>
			%ifvar -notempty ServerResourcesWarningInfoList%
				%loop ServerResourcesWarningInfoList%
					<tr>
						<td rowspan="%value itemCount%">%value alias%</td>
						<td rowspan="%value itemCount%">%value ip%</td>
						%loop ResourceItems -$index%
							%ifvar $index equals('0')%
							%else%
							<tr>
							%endifvar%
								<td>%ifvar safe equals('false')%<font color="red">%endifvar%%value class%%ifvar safe equals('false')%</font>%endifvar%</td>
								<td>%ifvar safe equals('false')%<font color="red">%endifvar%%value threshold%%ifvar safe equals('false')%</font>%endifvar%</td>
								<td>
									%ifvar safe equals('false')%<font color="red">%endifvar%
									%ifvar transactionIDList -notempty%
										%loop transactionIDList%
											%value transactionIDList%<br>
										%endloop%
									%else%
										%ifvar umConnectMsg -notempty%
											%loop umConnectMsg%
												%value umConnectMsg%<br>
											%endloop%
										%else%
											%ifvar dupSocketNameList -notempty%
												%loop dupSocketNameList%
													%value dupSocketNameList%<br>
												%endloop%
											%else%
												%value currentValue%
											%endifvar%
										%endifvar%
									%endifvar%
									%ifvar safe equals('false')%</font>%endifvar%
								</td>
								<td class="evenrowdata">
									%ifvar safe equals('true')%
										<img src="%value ../../designPath%images/enable_icon_16.png" alt="safe" border="0">
									%else%
										<img src="%value ../../designPath%images/disable_icon_16.png" alt="warning" border="0">
									%endifvar%
								</td>
							</tr>
						%endloop%
				%endloop%
			%else%
				<tr><td colspan=6>No server resource infos are currently.</td></tr>
			%endifvar%
		</table>
		</form>
	</body>
	<script>
		alertWarning();
	</script>
</html>

%endinvoke%