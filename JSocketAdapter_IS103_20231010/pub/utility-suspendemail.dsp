%invoke JSocketAdapter.ADMIN:adminEmailNotification%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo){
				var frm = document.pform;
				frm.todo.value = todo;
				var sTime = frm.sTime.value;
				var eTime = frm.eTime.value;
				var sHour = sTime.substring(0, 2);
				var eHour = eTime.substring(0, 2);
				
				if (sHour == "24" || eHour == "24") {
					alert("밤 12시에 대한 표현은 24가 아니고 00으로 해야 합니다.");
					return;
				}
				
				frm.submit();
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
			<input type="hidden" name="todo" value="">
			<input type="hidden" name="soid" value="%value soid%">
			<input type="hidden" name="eoid" value="%value eoid%">
			<input type="hidden" name="alertMsg" value="%value alertMsg%">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Utility &gt;
						Suspend E-Mail Notification
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="3">E-Mail Notification Suspend Properties</td>
				</tr>
				<tr>
					<td class="evenrowdata" width="20%" rowspan="2">Email Notification Stop Schedule</td>
					<td class="evenrow" width="20%">Start Date</td>
					<td class="evenrow-l" width="60%">
						<input type="text" name="sDate" value="%value sDate%" style="font-size:10pt;width:100"> YYYY/MM/DD
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="20%">Start Time</td>
					<td class="evenrow-l" width="60%">
						<input type="text" name="sTime" value="%value sTime%" style="font-size:10pt;width:100"> HH:MM:SS
					</td>
				</tr>
				<tr>
					<td class="evenrowdata" width="20%" rowspan="2">Email Notification Start Schedule</td>
					<td class="evenrow" width="20%">Start Date</td>
					<td class="evenrow-l" width="60%">
						<input type="text" name="eDate" value="%value eDate%" style="font-size:10pt;width:100"> YYYY/MM/DD
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="20%">Start Time</td>
					<td class="evenrow-l" width="60%">
						<input type="text" name="eTime" value="%value eTime%" style="font-size:10pt;width:100"> HH:MM:SS
					</td>
				</tr>
				<tr>
					<td class="action" colspan="3">
						<input type="button" name="SUBMIT" value="%value buttonName% Schedule"  onclick="return doAction('create')"></input>
					</td>
				</tr>
		</table>
		
		<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="5">E-Mail Notification Suspend/Active Schedule</td>
				</tr>
				<tr class="subheading2">
          <td>ID</td>
          <td>Service</td>
          <td>Description</td>
          <td>Run Time</td>
          <td>Status</td>
        </tr>
        %ifvar -notempty onceTasks%
					%loop onceTasks%
						<tr>
							<td>%value oid%</td>
							<td>%value service%</td>
							<td>%value description%</td>
							<td>%value date% %value time%</td>
							<td>
								%ifvar scheStatus equals('Active')%
									<img src="%value ../designPath%images/green_check.png" border=0>%value scheStatus%
								%else%
									<font color="red">%value scheStatus%</font>
								%endifvar%
							</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan="5">No schedules are currently registered.</td></tr>
				%endifvar%				
			</table>				
		</form>		
	</body>
</html>

%endinvoke%