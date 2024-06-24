%invoke JSocketAdapter.ADMIN:adminSwitchSocketOperation%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">

			function doSubmit(aswitch, aBusiness) {
				var frm = document.pform;
				frm.switching.value = aswitch;
				frm.businessName.value = aBusiness;
				
				var msg = "";
				var businessName = "";
				
				if (aBusiness == '') {
					businessName = "All Business";
				} else {
					businessName = aBusiness;
				}

				if (aswitch == "disable") {
					msg = "Are you sure you want to be disable " + businessName + " socket operation on this server?";
				} else if (aswitch == "enable") {
					msg = "Are you sure you want to be enable " + businessName + " socket operation on this server?";
				} else if (aswitch == "disableAndEnable") {
					msg = "Are you sure you want to be disable socket operation on this server and be enable socket operation on other server?";
				}

				if (confirm(msg)) {
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
			}
		</script>
	</head>
		<body onload="javascript:alertMsg()">
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					%value systemName% Online Client &gt;
					Switch Socket Operation
				</td>
			</tr>
		</table>
		<input type="hidden" name="switching" value="">
		<input type="hidden" name="systemName" value="%value systemName%">
		<input type="hidden" name="businessName" value="">
		<input type="hidden" name="deleteFirstConnFile" value="true">
		<input type="hidden" name="connectOrderer" value="Administrator">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		
		%ifvar multiClusterAliasList -notempty%
			<table class="tableForm" width="100%">
				<tr>
					<td class="evenrow" width="30%">Switching Target Server</td>
					<td class="evenrow-l" width="70%">
						<select name="targetRemoteAlias">
							%loop multiClusterAliasList%
								<option value="%value multiClusterAliasList%">%value multiClusterAliasList%</option>
							%endloop%
						</select>
					</td>
				</tr>
			</table>
		%endifvar%
		
		<table class="tableForm" width="100%">				
			<tr>
				<td class="heading" colspan="4">%value systemName% Socket Operation Switching</td>
			</tr>
			<tr class="subheading2">
				<td>Business Name</td>
				<td>Description</td>
				<td>Status</td>
				<td>To Do</td>
			</tr>
			
			%loop OnlineBusinessInfoList%
				<tr>
					<td>%value name%</td>
					<td>%value description%</td>
					<td class="evenrowdata">
						%ifvar enabled equals('true')%
							<img src="%value ../designPath%images/enable_icon_16.png" alt="Enabled" border="0">
						%else%
							<img src="%value ../designPath%images/disable_icon_16.png" alt="Disabled" border="0">
						%endifvar%
					</td>
					<td class="evenrowdata">
						%ifvar enabled equals('true')%
							<a href="javascript:doSubmit('disable', '%value name%')">Enabled</a> -> Disabled
						%else%
							<a href="javascript:doSubmit('enable', '%value name%')">Disabled</a> -> Enabled
						%endifvar%
					</td>
				</tr>
			%endloop%
			
			<tr>
				<td class="action" colspan="4">
					<input type="button" name="SUBMIT" value="All Business Enable"  onclick="return doSubmit('enable', '')"></input>&nbsp;&nbsp;
					<input type="button" name="SUBMIT" value="All Business Disable"  onclick="return doSubmit('disable', '')"></input>
					%ifvar otherServer -notempty%
						&nbsp;&nbsp;<input type="button" name="SUBMIT" value="Socket Operation Switching"  onclick="return doSubmit('disableAndEnable', '')"></input>
					%endifvar%
				</td>
			</tr>			
		</table>
		</form>
	</body>
</html>

%endinvoke%