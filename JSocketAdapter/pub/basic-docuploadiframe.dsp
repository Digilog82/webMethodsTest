<html>
	<head>
		<script language="javascript">
			function checkUpload() {
				var upload = parent.document.pform.schemaDefUpload.value;
				
				if (upload == "false") {
					alert("현재 서버에서는 파일 업로드를 할 수 없습니다.");
				}
			}
		</script>
	</head>
	<body>
		<form name="uform" action="/invoke/JSocketAdapter.ADMIN/uploadSchemaDefFile" method="post" enctype="multipart/form-data">
			<input type="hidden" name="docName" value="">
			<input type="hidden" name="interfaceID" value="">
			<input type="hidden" name="socketServerType" value="">
			<input type="file" name="schemaDefineFileName" style="font-size:10pt;width:500" onclick="checkUpload()">
		</form>		
	</body>
</html>