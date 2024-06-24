%invoke JSocketAdapter.ADMIN:adminDQLReconnectSchedule%

<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
<SCRIPT SRC="%value designPath%webMethods.js.txt"></SCRIPT>

		<script language="javascript">
			function doAction(enable){
				document.pform.enable.value = enable;
				document.pform.submit();
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
			<input type="hidden" name="enable" value="">
			<input type="hidden" name="alertMsg" value="%value alertMsg%">
		
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					AS/400 &gt;
					Reconnect Listener
				</td>
			</tr>
		</table>

      <table class="tableView" width=100%>
        <tr><td class="heading" colspan=4>AS400 Data Q Listeners Reconnect Schedule Create/Active/Suspend</td></tr>
        <tr class="subheading2">
          <td>ID</td>
          <td>Service</td>
          <td>Interval (sec)</td>
          <td>Status</td>
        </tr>
				<tr class="evenrowdata-l">
					<td>%value oid%</td>
					<td>%value service%</td>
					<td>
						%ifvar scheStatus equals('Active')%
							%value interval% seconds
						%else%
							<input type="text" name="interval" value="%value interval%"> seconds
						%endifvar%
					</td>
					<td>
						%ifvar scheStatus equals('Active')%
							<img src="%value designPath%images/green_check.gif" border=0>%value scheStatus%
						%else%
							<font color="red">%value scheStatus%</font>
						%endifvar%
					</td>
				</tr>
			
			<input type="hidden" name="oid" value="%value oid%">
			<input type="hidden" name="service" value="%value service%">
			<input type="hidden" name="oldInterval" value="%value interval%">
			
				<tr>
					<td class="action" colspan="4">
					
						%switch scheStatus%
							%case 'None'%
								<input type="button" name="SUBMIT" value="Create Schedule"  onclick="return doAction('create')"></input>
							%case 'Suspended'%
								<input type="button" name="SUBMIT" value="Active Schedule"  onclick="return doAction('true')"></input>
							%case 'Active'%
								<input type="button" name="SUBMIT" value="Suspend Schedule"  onclick="return doAction('false')"></input>
						%endswitch%
					</td>
				</tr>
			
    </table>
   </form>
</body>
</html>

%endinvoke%