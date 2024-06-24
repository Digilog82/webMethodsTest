%invoke JSocketAdapter.ADMIN:adminDeployFile%

<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<SCRIPT SRC="%value designPath%webMethods.js.txt"></SCRIPT>
		<script language="javascript">
			function doAction(){				
				var targetServerLength = document.pform.remoteAlias.options.length;
				var remoteAliasList = "";
				
				for (var i = 0; i < targetServerLength; i++) {
					if (document.pform.remoteAlias.options[i].selected) {
						if (remoteAliasList == "") {
							remoteAliasList = document.pform.remoteAlias.options[i].value;
						} else {
							remoteAliasList = remoteAliasList + "/" + document.pform.remoteAlias.options[i].value;
						}
					}
				}
				
				if (remoteAliasList == "") {
					if(confirm("전체 서버에 Deploy 하시겠습니까?")) {
						for (var i = 0; i < targetServerLength; i++) {
							if (remoteAliasList == "") {
								remoteAliasList = document.pform.remoteAlias.options[i].value;
							} else {
								remoteAliasList = remoteAliasList + "/" + document.pform.remoteAlias.options[i].value;
							}
						}
					} else {
						return;
					}
				}
				
				document.pform.targetServers.value = remoteAliasList;
				document.pform.submit();
			}
			
			function alertMsg() {
				var msg = document.pform.alertMsg.value;
				
				if (msg != "") {
					alert(msg);
				} 
			}
		</script>
	</head>

	<body onload="javascript:alertMsg()">

		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%

		<form name="pform" method="post" target="_self">
			<input type="hidden" name="todo" value="Send">
			<input type="hidden" name="targetServers" value="">
			<input type="hidden" name="alertMsg" value="%value deployMsg%">
		
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					Utility &gt;
					Deploy File
				</td>
			</tr>
		</table>
				
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Local File Deployment</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Target Server</td>
				<td class="evenrow-l" width="70%">
					<!-- 하나만 선택한 경우에는 remoteAlias 라는 이름으로 선택한 값이 flow service에 전달되고
					     두 개 이상을 선택한 경우에는 remoteAlias 라는 이름으로 첫번째 선택한 값과
					     remoteAliasList 라는 이름으로(자동으로 생성됨) 선택한 모든 값이 StringList 형태로
					     flow service에 전달된다. -->
					<select name="remoteAlias" style="width:90" size=7 multiple>
						%loop remoteServerList%
							<option value="%value remoteServerList%">%value remoteServerList%</option>
						%endloop%
					</select>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Full File Name</td>
				<td class="evenrow-l" width="70%">
					<input type="text" name="fullFileName" value="%value fullFileName%" style="font-size:10pt;width:400"><br>(상대경로로 입력. 예) packages/JSocketAdapter/pub/menu.dsp)
				</td>
			</tr>
			<tr>
				<td class="action" colspan="2">
					<input type="button" name="SUBMIT" value="Deploy File"  onclick="return doAction()"></input>
				</td>
			</tr>
		</table>
   	</form>
	</body>
</html>

%endinvoke%