%invoke JSocketAdapter.ADMIN:adminCheckTargetConnection%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo){
				var frm = document.pform;
				frm.todo.value = todo;				
				frm.submit();
			}
		</script>
	</head>
	<body>
	
		<form name="pform" method="post" target="_self">
			<input type="hidden" name="todo" value="">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Utility &gt;
						Check Target Connection
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Target Host Properties</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Host IP(or name)</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="hostIP" value="%value hostIP%" style="font-size:10pt;width:150">
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Host Port Number</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="hostPort" value="%value hostPort%" style="font-size:10pt;width:50">
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Connect Timeout</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="connectTimeout" value="%value connectTimeout%" style="font-size:10pt;width:50"> (seconds)
					</td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Test Connection"  onclick="return doAction('connect')"></input>
					</td>
				</tr>
		</table>
		
		<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Connection Test Results</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Connect</td>
					<td class="evenrow-l" width="70%">
						%switch connect%
						%case 'true'%
							연결 성공
						%case 'false'%
							연결 실패
						%endswitch%
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Firewall Open</td>
					<td class="evenrow-l" width="70%">
						%switch firewallOpen%
						%case 'true'%
							방화벽 오픈 완료
						%case 'false'%
							방화벽 미오픈
						%case 'unknown'%
							방화벽 오픈 상태 알 수 없음
						%endswitch%
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Error Message</td>
					<td class="evenrow-l" width="70%">%value errorMsg%</td>
				</tr>
			</table>				
		</form>		
	</body>
</html>

%endinvoke%