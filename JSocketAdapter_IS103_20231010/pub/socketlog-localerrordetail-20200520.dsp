%invoke JSocketAdapter.ADMIN:adminLocalServerErrorLog%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
	</head>
	<body>
	
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Socket Log &gt;
						Local Server Error Log &gt;
						Details
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Transaction Basic Info</td>
			</tr>
			<tr>
				<tr>
					<td class="evenrow" width="30%">Port Number</td>
					<td class="evenrow-l" width="70%">%value SocketAuditInfo/portNumber%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Start Time</td>
					<td class="evenrow-l" width="70%">%value SocketAuditInfo/auditStartTime%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Doc ID</td>
					<td class="evenrow-l" width="70%">%value SocketAuditInfo/docID%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Error Type</td>
					<td class="evenrow-l" width="70%">%value SocketAuditInfo/errorType%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Execution Server</td>
					<td class="evenrow-l" width="70%">%value SocketAuditInfo/serverIP%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Socket Log</td>
					<td class="evenrow-l" width="70%"><textarea cols="200" rows="20">%value SocketAuditInfo/socketLog%</textarea></td>
				</tr>
			</tr>			
		</table>
	</body>
</html>

%endinvoke%