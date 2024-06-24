%invoke JSocketAdapter.ADMIN:adminDownloadFile%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			var suffix = 0;
			function doDownloadAction(todo, fileName) {
				if (todo == "download") {
					document.pform.action = "/invoke/JSocketAdapter.ADMIN/downloadFile";
					document.pform.fileName.value = fileName;
					document.pform.submit();
				} else if (todo == "downloadFiles") {
					if (suffix == 0) {
						var chkCnt = 0;
						
						for (var i=0; i < document.pform.length; i++) {
							if (document.pform.elements[i].checked) {
								chkCnt++;
							}
						}
						
						if (chkCnt == 0) {
							alert("다운로드할 파일을 선택하십시요.");
							return;
						}
					}
					
					var chkObj = document.pform.elements["selectedList" + (suffix++)];
					
					if (chkObj) {
						if (chkObj.checked) {
							document.pform.action = "/invoke/JSocketAdapter.ADMIN/downloadFile";
							document.pform.fileName.value = chkObj.value;
							document.pform.submit();
							
							// 1초 후에 다른 파일 다운로드
							setTimeout(function() {
								doDownloadAction(todo, '')
							}, 1000);
						} else {
							doDownloadAction(todo, '');
						}
					} else {
						// 마지막 체크박스 이후에 한 번 더 호출이 된다. 이 때는 체크박스 Object가 존재하지 않아서 doDownloadAction 함수 재귀 호출이 중지된다.
						// suffix 변수를 초기화 해준다.
						suffix = 0;
					}
				}
			}
			
			function doAction(todo, fileName) {
				if (todo == "delete") {
					if(confirm("Do you really want to delete file " + fileName + "?")) {						
					} else {
						return;
					}
				} else if (todo == "deleteFiles") {
					for (var i=0; i < document.pform.length; i++) {
						if (document.pform.elements[i].checked) {
							if (document.pform.deleteFileNameList.value == "") {
								document.pform.deleteFileNameList.value = document.pform.elements[i].value;
							} else {
								document.pform.deleteFileNameList.value = document.pform.deleteFileNameList.value + "|" + document.pform.elements[i].value;
							}
						}
					}
					
					if (document.pform.deleteFileNameList.value == "") {
						alert("삭제할 파일을 선택하십시요.");
						return;
					} else {
						if(confirm("Do you really want to delete selected files?")) {						
						} else {
							document.pform.deleteFileNameList.value = "";
							return;
						}
					}
				} else if (todo == "search") {
					if (document.pform.downloadPath.value == "") {
						alert("Download Path를 입력하십시요.");
						return;
					}
				}
				
				document.pform.action = "";
				document.pform.todo.value = todo;
				document.pform.deleteFileName.value = fileName;
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
		
		<form name="pform" method="post" target="_self">
			<input type="hidden" name="todo" value="">
			<input type="hidden" name="deleteFileName" value="">
			<input type="hidden" name="deleteFileNameList" value="">
			<input type="hidden" name="filePath" value="%value downloadPath%">
			<input type="hidden" name="fileName" value="">
			<input type="hidden" name="moveAction" value="/JSocketAdapter/utility-filedownload.dsp">
			<input type="hidden" name="alertMsg" value="%value alertMsg%">
			<input type="hidden" name="checkMode" value="uncheck">
		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Utility &gt;
						Download File
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">File Properties</td>
				</tr>				
				<tr>
					<td class="evenrow" width="30%">Download Path</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="downloadPath" value="%value downloadPath%" size="20" style="font-size:10pt;width:600">
					</td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Search File"  onclick="return doAction('search', '')"></input>&nbsp;&nbsp;
						<input type="button" name="DOWNLOAD" value="Download Files"  onclick="return doDownloadAction('downloadFiles', '')"></input>&nbsp;&nbsp;
						<input type="button" name="DELETE" value="Delete Files"  onclick="return doAction('deleteFiles', '')"></input>
					</td>
				</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="4">File Name Infomation</td>
			</tr>
			<tr class="subheading2">
				<td>Select <a href="javascript:allChecked()">All</a></td>
				<td>File Name</td>
				<td>Download</td>
				<td>Delete</td>
			</tr>
			%ifvar -notempty fileNameList%
				%loop fileNameList -$index%
					<tr>
						<td class="evenrowdata"><input type="checkbox" name="selectedList%value $index%" value="%value fileNameList%">
						<td>%value fileNameList%</td>
						<td class="evenrowdata"><input type="button" name="SUBMIT" value="Download"  onclick="return doDownloadAction('download', '%value fileNameList%')"></input></td>
						<td class="evenrowdata"><input type="button" name="SUBMIT" value="Delete"  onclick="return doAction('delete', '%value fileNameList%')"></input></td>
					</tr>
				%endloop%
			%else%
				<tr><td colspan="4">No Files are currently registered.</td></tr>
			%endifvar%
		</table>
		
		</form>		
	</body>
</html>

%endinvoke%