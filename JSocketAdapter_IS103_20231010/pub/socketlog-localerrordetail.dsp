%invoke JSocketAdapter.ADMIN:adminLocalServerErrorLog%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
	</head>
	<body>
		<form name="dform" action="socketlog-localauditresubmitdetail.dsp" method="post">
			<input type="hidden" name="todo" value="resubmitread">
			<input type="hidden" name="fullFileName" value="%value auditLogFileName%">
			<input type="hidden" name="changeOrgLogFileName" value="%value changeOrgLogFileName%">
			<input type="hidden" name="orgLogFileNameChange" value="true">
		</form>
		<script langauge='javascript'>
			document.dform.submit();
		</script>
	</body>
</html>

%endinvoke%