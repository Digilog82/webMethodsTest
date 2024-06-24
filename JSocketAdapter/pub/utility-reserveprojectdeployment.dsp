%invoke JSocketAdapter.ADMIN:adminReserveProjectDeployment%

<html>
<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<title>Deploy Schedule</title>
<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
<SCRIPT SRC="%value designPath%webMethods.js.txt"></SCRIPT>

		<script language="javascript">
			function doAction() {
				var sDate = document.pform.sDate.value;
				var sTime = document.pform.sTime.value;
					
				if (sDate == "") {
					alert("예약 날짜를 입력하십시요.");
					return;
				}
				
				if (sTime == "") {
					alert("예약 시간을 입력하십시요.");
					return;
				}
				
				for (var i=0; i < document.pform.length; i++) {
					if (document.pform.elements[i].checked) {
						if (document.pform.selectedList.value == "") {
							document.pform.selectedList.value = document.pform.elements[i].value;
						} else {
							document.pform.selectedList.value = document.pform.selectedList.value + "|" + document.pform.elements[i].value;
						}
					}
				}
				
				if (document.pform.selectedList.value == "") {
					alert("Project Name을 선택하십시요.");
					return;
				}
				
				document.pform.submit();
			}
			
			function alertMsg() {
				var msg = document.pform.alertMsg.value;
				
				if (msg != "") {
					alert(msg);
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
		</script>
		
</head>

<body onload="javascript:alertMsg()">

		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%

		<form name="pform" method="post" target="_self">
			<input type="hidden" name="todo" value="reserve">
			<input type="hidden" name="selectedList" value="">
			<input type="hidden" name="checkMode" value="uncheck">
			<input type="hidden" name="alertMsg" value="%value alertMsg%">
		
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					Utility &gt;
					Reserve Project Deployment
				</td>
			</tr>
		</table>
				
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Project Deployment Reservation</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Reservation Date</td>
				<td class="evenrow-l" width="70%">
					<input type="text" name="sDate" size="5" style="font-size:10pt;width:100">&nbsp;YYYY/MM/DD&nbsp;
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Reservation Time</td>
				<td class="evenrow-l" width="70%">
					<input type="text" name="sTime" size="5" style="font-size:10pt;width:100">&nbsp;HH:MM:SS
				</td>
			</tr>
			<tr>
				<td class="action" colspan="2">
					<input type="button" name="SUBMIT" value="Reserve Project Deployment"  onclick="return doAction()"></input>
				</td>
			</tr>
		</table>
		
		<table class="tableView" width=100%>
      <tr><td class="heading" colspan=4>Projects</td></tr>
      <tr class="subheading2">
				<td>Select <a href="javascript:allChecked()">All</a></td>
        <td>Project Name</td>
				<td>Project Type</td>
				<td>Description</td>
      </tr>
			%ifvar projects -notempty%
      %loop projects -$index%
			<tr>
				<td class="evenrowdata"><input type="checkbox" name="selectedList%value $index%" value="%value projectName%/%value projectType%">
				<td>%value projectName%</td>
				<td>%value projectType%</td>
				<td>%value description%</td>
			</tr>
			%endloop%
			%else%
			<tr><td colspan=4>No projects are currently registered.</td></tr>
      %endif%
		</table>
   </form>   
	</body>
</html>

%endinvoke%