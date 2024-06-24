%invoke JSocketAdapter.COMMON.UTIL.FLOW:getSimpleDocLengthSum%

%ifvar lengthSum -notempty%
<script language="javascript">	
	parent.setDocLengthSum('%value lengthSum%', '%value alertMsg%');
</script>
%endifvar%

<html>
	<body>
		<form name="lform" method="post" target="_self">
			<input type="hidden" name="recCountFieldName" value="">
			<input type="hidden" name="schemaDefine" value="">
		</form>		
	</body>
</html>