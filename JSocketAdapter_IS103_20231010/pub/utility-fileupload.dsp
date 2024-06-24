%invoke JSocketAdapter.ADMIN:adminUploadFile%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doUploadAction() {
				var localFileName = document.getElementById("fileNames").value;
				
				if (localFileName == "") {
					alert("Upload 할 파일을 선택하십시요.");
					return;
				}
				
				if (document.pform.uploadPath.value == "") {
					alert("Upload Path를 입력하십시요.");
					return;
				}
				
				document.pform.submit();
			}
			
			function doAction(todo, fileName) {
				if (todo == "delete") {
					if (confirm("Do you really want to delete file " + fileName + "?")) {						
					} else {
						return;
					}
				} else if (todo == "deleteFiles") {
					for (var i=0; i < document.dform.length; i++) {
						if (document.dform.elements[i].checked) {
							if (document.dform.deleteFileNameList.value == "") {
								document.dform.deleteFileNameList.value = document.dform.elements[i].value;
							} else {
								document.dform.deleteFileNameList.value = document.dform.deleteFileNameList.value + "|" + document.dform.elements[i].value;
							}
						}
					}
					
					if (document.dform.deleteFileNameList.value == "") {
						alert("삭제할 파일을 선택하십시요.");
						return;
					} else {
						if(confirm("Do you really want to delete selected files?")) {						
						} else {
							document.dform.deleteFileNameList.value = "";
							return;
						}
					}
				} else if (todo == "search") {
					if (document.pform.uploadPath.value == "") {
						alert("Upload Path를 입력하십시요.");
						return;
					}
				}
				
				document.dform.todo.value = todo;
				document.dform.uploadPath.value = document.pform.uploadPath.value;
				document.dform.deleteFileName.value = fileName;
				document.dform.submit();
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
				var checkMode = document.dform.checkMode.value;
				var eleName;
				
				if (checkMode == "uncheck") { // All Checked
					for (var i=0; i < document.dform.length; i++) {
						eleName = document.dform.elements[i].name;
						
						if (eleName.indexOf("selectedList") >= 0) {
							if (!document.dform.elements[i].checked) {
								document.dform.elements[i].checked = true;
							}
						}
					}
					
					document.dform.checkMode.value = "check";
				} else { // All Unchecked
					for (var i=0; i < document.dform.length; i++) {
						eleName = document.dform.elements[i].name;
						
						if (eleName.indexOf("selectedList") >= 0) {
							if (document.dform.elements[i].checked) {
								document.dform.elements[i].checked = false;
							}
						}
					}
					
					document.dform.checkMode.value = "uncheck";
				}
			}
		</script>
	</head>
	<body onload="javascript:alertMsg()">
		
		<form name="pform" action="/invoke/JSocketAdapter.ADMIN/uploadFile" method="post" enctype="multipart/form-data">
			<input type="hidden" name="alertMsg" value="%value alertMsg%">
		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Utility &gt;
						Upload File
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">File Properties</td>
				</tr>				
				<tr>
					<td class="evenrow" width="30%">File</td>
					<td class="evenrow-l" width="70%">
						<input multiple="multiple" type="file" name="fileName[]" id="fileNames" style="font-size:10pt;width:600" />
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Upload Path</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="uploadPath" value="%value uploadPath%" size="20" style="font-size:10pt;width:600">
					</td>
				</tr>					
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Search File"  onclick="return doAction('search', '')"></input>&nbsp;&nbsp;
						<input type="button" name="UPLOAD" value="Upload File"  onclick="return doUploadAction()"></input>&nbsp;&nbsp;
						<input type="button" name="DELETE" value="Delete Files"  onclick="return doAction('deleteFiles', '')"></input>
					</td>
				</tr>
		</table>
		</form>
		
		<form name="dform" method="post" target="_self">
			<input type="hidden" name="todo" value="">
			<input type="hidden" name="uploadPath" value="">
			<input type="hidden" name="deleteFileName" value="">
			<input type="hidden" name="deleteFileNameList" value="">
			<input type="hidden" name="filePath" value="%value uploadPath%">
			<input type="hidden" name="checkMode" value="uncheck">
			
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="3">File Name Infomation</td>
			</tr>
			<tr class="subheading2">
				<td>Select <a href="javascript:allChecked()">All</a></td>
				<td>File Name</td>
				<td>Delete</td>
			</tr>
			%ifvar -notempty fileNameList%
				%loop fileNameList -$index%
					<tr>
						<td class="evenrowdata"><input type="checkbox" name="selectedList%value $index%" value="%value fileNameList%">
						<td>%value fileNameList%</td>
						<td class="evenrowdata"><input type="button" name="SUBMIT" value="Delete"  onclick="return doAction('delete', '%value fileNameList%')"></input></td>
					</tr>
				%endloop%
			%else%
				<tr><td colspan="3">No Files are currently registered.</td></tr>
			%endifvar%
		</table>
		</form>
	</body>
</html>

%endinvoke%