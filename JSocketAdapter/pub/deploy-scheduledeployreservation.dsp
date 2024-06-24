%invoke JSocketAdapter.ADMIN:adminScheduleDeploymentReservation%

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
				
				if(pname != '') {
					frm.soid.value = pname;
				}
				
				if(todo == 'delete'){
					if(confirm("Do you really want to delete config of  " + pname)){
						frm.submit();
					}
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
				%ifvar todo equals('read')%
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Deploy Config &gt;
						Schedule Reservation &gt;
						Edit Schedule Reservation
					</td>
				%else%
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Deploy Config &gt;
						Schedule Reservation
					</td>
				%endifvar%
			</tr>
		</table>
		
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		
		%ifvar todo -notempty%
			<ul class="listitems">
				<li class="listitem"><a href="deploy-scheduledeployreservation.dsp">Return to Schedule Deployment Reservation Schedule Information</a></li>
			</ul>
		%else%
			<input type="hidden" name="soid" value="">		
		%endifvar%
		
		<table class="tableForm" width="100%">	
			%ifvar todo equals('read')%
				<tr>
					<td class="heading" colspan="2">Schedule Deployment Reservation Schedule Properties</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Start Date</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="sDate" value="%value sDate%" style="font-size:10pt;width:100"> YYYY/MM/DD
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Start Time</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="sTime" value="%value sTime%" style="font-size:10pt;width:100"> HH:MM:SS
						<input type="hidden" name="soid" value="%value soid%">
					</td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>
					</td>
				</tr>
			%else%
				<tr>
					<td class="heading" colspan=6>Schedule Deployment Reservation Schedule Information</td>
				</tr>
				<tr class="subheading2">						
					<td>Deploy Schedule Service</td>
					<td>Run Time</td>
					<td>Status</td>
					<td>Target Node</td>
					<td>Edit</td>
					<td>Delete</td>
				</tr>
				%ifvar -notempty onceTasks%
					%loop onceTasks%
						<tr>
							<td>
								%loop serviceList%
									%value serviceList%<br>
								%endloop%
							</td>
							<td>%value date% %value time%</td>
							<td>
								%ifvar scheStatus equals('Active')%
									<img src="%value ../designPath%images/green_check.gif" border=0>%value scheStatus%
								%else%
									<font color="red">%value scheStatus%</font>
								%endifvar%
							</td>
							<td>%value inputs/targetNode%</td>
							<td class="evenrowdata">
								<a href="javascript:doAction('read', '%value oid%')"><img src="%value ../designPath%icons/copy.gif" alt="Edit" border="0"></a>
							</td>
							<td class="evenrowdata">
								<a href="javascript:doAction('delete', '%value oid%')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a>
							</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan="6">No reservation schedules are currently registered.</td></tr>
				%endifvar%
			%endifvar%
		</table>
		</form>
		%endinvoke%
	</body>
</html>