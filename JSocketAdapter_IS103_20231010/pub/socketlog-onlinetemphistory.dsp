%invoke JSocketAdapter.ADMIN:adminClientOnlineTempHistoryLog%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo){
				var frm = document.pform;
				var socketUnitName = frm.socketUnitName.value;
				var logDate = frm.logDate.value;
				
				if (socketUnitName == "") {
					alert("Provider SystemName_BusinessName을 선택하십시요.");
					return;
				}
				
				if (logDate == "") {
					alert("Log Date를 입력하십시요.");
					return;
				}
				
				var fileName = "OnlineTempDataHistory_" + socketUnitName + "_" + logDate + ".log";
				frm.todo.value = todo;
				frm.fileName.value = fileName;
				
				if(todo == 'download') {
					//frm.action = "/web/JSocketAdapter/file-download.jsp";
					frm.action = "/invoke/JSocketAdapter.ADMIN/downloadFile";
				} else {
					// 실제 파일 다운로드가 실행될 경우 화면 이동이 없다. 그러므로 Download File 버튼 클릭 이후에는
					// action이 downloadFile로 바뀐 상태이기 때문에 아래 처리를 하지 않을 경우 모든 버튼 클릭 시
					// downloadFile로 submit 된다.
					frm.action = "";
				}
				frm.submit();
			}
			
			function alertMsg() {
				var frm = document.pform;
				var msg = frm.alertMsg.value;
				var autoDownload = frm.autoDownload.value;
				
				if (msg != "") {
					alert(msg);
				}
				
				// 파일 사이즈가 큰 경우 자동으로 다운로드 하도록 한다.
				if (autoDownload == "true") {
					frm.alertMsg.value = "";
					frm.autoDownload.value = "";
					doAction('download');
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
			<input type="hidden" name="moveAction" value="/JSocketAdapter/socketlog-onlinetemphistory.dsp">
			<input type="hidden" name="autoDownload" value="%value autoDownload%">
			<input type="hidden" name="alertMsg" value="%value alertMsg%">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Socket Log &gt;
						Remote Online Temp History Log
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Search Condition</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Download Threshold</td>
				<td class="evenrow-l" width="70%">
					<select name="downloadThreshold" style="width:70">
						<option value="3">3MB</option>
						<option value="5">5MB</option>
						<option value="7">7MB</option>
						<option value="10">10MB</option>
					</select>
					<script language="javascript">
						document.pform.downloadThreshold.value = "%value downloadThreshold%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Provider SystemName_BusinessName</td>
				<td class="evenrow-l" width="70%">
					<select name="socketUnitName">
						%loop OnlineSystemBusinessList%
							<option value="%value onlineSystemBusinessValue%">%value onlineSystemBusinessDisplay%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.socketUnitName.value = "%value socketUnitName%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Log Date</td>
				<td class="evenrow-l" width="70%">
					<input type="text" name="logDate" value="%value logDate%" style="font-size:10pt;width:100"> (Date Format : yyyyMMdd)
				</td>
			</tr>
			<tr>
				<td class="action" colspan="2">
					<input type="button" name="SUBMIT" value="Search Logs"  onclick="return doAction('search')"></input>&nbsp;&nbsp;
					<input type="button" name="SUBMIT" value="Download File"  onclick="return doAction('download')"></input>
					<input type="hidden" name="filePath" value="%value filePath%">
					<input type="hidden" name="fileName" value="">
				</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading">Online Temp History Log</td>
			</tr>
			
			%loop onlineTempHistoryLogList%
				<tr>
					<td>%value onlineTempHistoryLogList%</td>
				</tr>
			%endloop%

		</table>				
		</form>		
	</body>
</html>

%endinvoke%