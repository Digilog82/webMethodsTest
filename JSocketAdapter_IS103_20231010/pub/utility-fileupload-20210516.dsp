%invoke JSocketAdapter.ADMIN:adminUploadFile%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doUploadAction() {
				var localFileName = document.pform.fileName.value;
				document.pform.localFileName.value = localFileName;
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
					<tr>
						<td class="evenrow" width="30%">File</td>
						<td class="evenrow-l" width="70%">
							<input type="file" name="fileName" style="font-size:10pt;width:600" />
							<input type="hidden" name="localFileName" value="">
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
							<input type="button" name="SUBMIT" value="Upload File"  onclick="return doUploadAction()"></input>
						</td>
					</tr>
				</tr>			
		</table>
		</form>
	</body>
</html>

%endinvoke%