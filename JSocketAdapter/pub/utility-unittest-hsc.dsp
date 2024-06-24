%invoke JSocketAdapter.ADMIN:adminUnitTest_HSC%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo){
				var frm = document.pform;
				var requestData = frm.requestData.value;
				var charset = frm.charset.value;
				var docName = frm.docName.value;
				var serverRole = "%value serverRole%";
				var serverType = "%value serverType%";
				
				if (serverRole == "GW") {
					alert("Gateway Server에서는 단위테스트를 수행할 수 없습니다.\nMain Server에서 단위테스트를 수행하십시요.");
					return;
				} else {
					if (serverType == "DEV2" || serverType == "PROD2") {
						alert("Main Server 2번에서는 단위테스트를 수행할 수 없습니다.\nMain Server 1번에서 단위테스트를 수행하십시요.");
						return;
					}
				}
				
				if (requestData != "" && charset == "") {
					alert("Request Data 입력 시에는 Character Set을 선택해야 합니다.");
					return;
				}
				
				if (requestData == "" && docName == "") {
					alert("Request Data를 입력 하든가 Doc ID를 선택해야 합니다.");
					return;
				}
				
				frm.todo.value = todo;
				frm.submit();
			}
		</script>
	</head>
	<body>
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">
			<input type="hidden" name="todo" value="">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Utility &gt;
						Unit Test
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading">Unit Test Method</td>
			</tr>
			<tr>
			    <td class="evenrow-l">
			      1. 전문 송신은 Main Server1(10.216.133.112:6610)에서 수행한다.<br>
				  2. 단위 테스트 결과 조회<br>
				     &nbsp;&nbsp;&nbsp;&nbsp;1) L2 --> L3 송신<br>
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;JSocketAdapter Package Home > Socket Log > Local Server Audit Log 메뉴에서 조회한다.<br>
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Port Number를 공통헤더의 길이에 따라서 선택한 후 조회한다.<br>
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;공통헤더 길이가 60인 경우에는 2260을 선택, 30인 경우에는 2230을 선택, 7인 경우에는 2207을 선택한다.<br>
					 &nbsp;&nbsp;&nbsp;&nbsp;2) L3 --> L2 송신<br>
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;JSocketAdapter Package Home > Socket Log > Local Server Audit Log 메뉴에서 조회한다.<br>
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Port Number를 공통헤더의 길이에 따라서 선택한 후 조회한다.<br>
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;공통헤더 길이가 60인 경우에는 3360을 선택, 30인 경우에는 3330을 선택, 7인 경우에는 3307을 선택한다.<br>
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L2에서 수신한 전문은 Gateway Server2(10.216.133.113:5510) IS Admin > Logs > Server 메뉴에서 조회한다.<br>
				  3. Source System : L2 --> L3 전문 송신일 경우에는 L2를 선택하고 L3 --> L2 전문 송신일 경우에는 L3를 선택한다.<br>
                  4. Common Header Length : 테스트 하고자 하는 전문의 공통 헤더의 길이를 선택한다.<br>
                  5. Request Data : 테스트 하고자 하는 전문의 샘플 데이터가 있는 경우에 입력한다. 이런 경우에는 Doc ID를 선택하지 않는다.<br>
                  6. Character Set : 테스트 하고자 하는 전문의 샘플 데이터가 있는 경우에 전문 변환에 사용하는 Character Set을 선택한다.<br>
                  7. Doc ID : 테스트 하고자 하는 전문의 샘플 데이터가 없는 경우에 테스트 하고자 하는 전문의 ID를 선택한다. 이런 경우에는 Request Data를 입력하지 않는다.<br>
				</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Doc Send Properties</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Source System</td>
					<td class="evenrow-l" width="70%">
						<select name="sourceSystem" style="width:100">
							<option value="L2">L2</option>
							<option value="L3">L3</option>
						</select>
						<script language="javascript">
							document.pform.sourceSystem.value = "%value sourceSystem%";
						</script>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Common Header Length</td>
					<td class="evenrow-l" width="70%">
						<select name="commonHeaderLength" style="width:100">
							<option value="60">60</option>
							<option value="30">30</option>
							<option value="07">07</option>
							<option value="24">24</option>
							<option value="33">33</option>
						</select>
						<script language="javascript">
							document.pform.commonHeaderLength.value = "%value commonHeaderLength%";
						</script>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Online YN</td>
					<td class="evenrow-l" width="70%">
						<select name="online" style="width:100">
							<option value="Yes">Yes</option>
							<option value="No">No</option>
						</select>
						<script language="javascript">
							document.pform.online.value = "%value online%";
						</script>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Request Data</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="requestData" value="%value requestData%" style="font-size:10pt;width:400">
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Character Set</td>
					<td class="evenrow-l" width="70%">
						<select name="charset" style="width:100">
							<option value="">선택</option>
							%loop charSetList%
								<option value="%value charSetList%">%value charSetList%</option>
							%endloop%
						</select>
						<script language="javascript">
							document.pform.charset.value = "%value charset%";
						</script>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Doc ID</td>
					<td class="evenrow-l" width="70%">
						<select name="docName" style="width:400">
							<option value="">선택</option>
							%loop DocNameList%
								<option value="%value docNameValue%">%value docNameDisplay%</option>
							%endloop%
						</select>
						<script language="javascript">
							document.pform.docName.value = "%value docName%";
						</script>
					</td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Send Doc"  onclick="return doAction('send')"></input>
					</td>
				</tr>
		</table>
		
		<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Doc Send Results</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Send Result Code</td>
					<td class="evenrow-l" width="70%">
						%value sendResultCode%							
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Send Result Msg</td>
					<td class="evenrow-l" width="70%">
						%value sendResultMsg%							
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Socket Log</td>
					<td class="evenrow-l" width="70%">
						<textarea cols="200" rows="20">%value socketLog%</textarea>
					</td>
				</tr>
				%ifvar anbResultFlag -notempty%
				<tr>
					<td class="evenrow" width="30%">ANB Receive Result Code</td>
					<td class="evenrow-l" width="70%">%value anbResultFlag%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">ANB Receive Result Msg</td>
					<td class="evenrow-l" width="70%">%value anbErrorMsg%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">ANB Data</td>
					<td class="evenrow-l" width="70%">%value anbData%</td>
				</tr>
				%endifvar%					
				%ifvar oneWayResultFlag -notempty%
				<tr>
					<td class="evenrow" width="30%">One Way Receive Result Code</td>
					<td class="evenrow-l" width="70%">%value oneWayResultFlag%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">One Way Receive Result Msg</td>
					<td class="evenrow-l" width="70%">%value oneWayErrorMsg%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">One Way Data</td>
					<td class="evenrow-l" width="70%">%value oneWayData%</td>
				</tr>
				%endifvar%
			</table>				
		</form>		
	</body>
</html>

%endinvoke%