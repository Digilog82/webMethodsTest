%invoke JSocketAdapter.ADMIN:adminAlertMsg%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">		
	</head>
	<body>
		<table class="tableForm" width="100%">	
			<tr>
				<td class="heading">Local Server Socket Alert Message</td>
			</tr>
			%loop alertMsgList%
				<tr>
					<td class="evenrow-l">%value alertMsgList%</td>
				</tr>
			%endloop%
		</table>			
	</body>
</html>

%endinvoke%