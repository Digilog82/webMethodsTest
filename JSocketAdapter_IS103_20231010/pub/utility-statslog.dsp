%invoke JSocketAdapter.ADMIN:adminStatsLog%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo) {
				if(todo == "download") {
					var frm = document.pform;
					var sysDate = frm.sysDate.value;
					var logDate = frm.logDate.value;
					
					if (logDate == "") {
						alert("Log Date를 입력하십시요.");
						return;
					}
					
					var fileName = "";
					
					if (sysDate == logDate) {
						fileName = "stats.log";
					} else {
						fileName = "stats" + logDate + "_235959.log";
					}
					
					frm.todo.value = todo;
					frm.fileName.value = fileName;
					
					//frm.action = "/web/JSocketAdapter/file-download.jsp";
					frm.action = "/invoke/JSocketAdapter.ADMIN/downloadFile";
					frm.submit();
				} else {
					// 실제 파일 다운로드가 실행될 경우 화면 이동이 없다. 그러므로 Download File 버튼 클릭 이후에는
					// action이 downloadFile로 바뀐 상태이기 때문에 아래 처리를 하지 않을 경우 모든 버튼 클릭 시
					// downloadFile로 submit 된다.
					document.pform.action = "";
					launchStatsLog();
				}
			}
			
			function launchStatsLog() {
      	window.open('/JSocketAdapter/stats/stats.html', 'statslog', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
      }
		</script>
	</head>
	<body>
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">
			<input type="hidden" name="todo" value="">
			<input type="hidden" name="moveAction" value="/JSocketAdapter/utility-statslog.dsp">
			<input type="hidden" name="sysDate" value="%value sysDate%">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Utility &gt;
						Stats Log Analysis
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Stats Log Properties</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Log Date</td>
				<td class="evenrow-l" width="70%">
					<input type="text" name="logDate" value="%value logDate%" style="font-size:10pt;width:100"> (Date Format : yyyyMMdd)
				</td>
			</tr>
			<tr>
				<td class="action" colspan="2">
					<input type="button" name="SUBMIT" value="Download File" onclick="return doAction('download')"></input>&nbsp;&nbsp;
					<input type="button" name="SUBMIT" value="Open Stats Log Analyzer" onclick="return doAction('openstatslog')"></input>
					<input type="hidden" name="filePath" value="%value filePath%">
					<input type="hidden" name="fileName" value="">
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>

%endinvoke%