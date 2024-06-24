%invoke MLK_BANCA_SAMPLE.UNIT_TEST:adminUnitTest%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo){
				var frm = document.pform;
				var testCase = frm.testCase.value;
				var testData = frm.testData.value;
				var testFile = frm.testFile.value;
				var testBizCode = frm.testBizCode.value;				
				
				if (testCase == "case1" || testCase == "case2") {
					if (testData == "") {
						alert("Test Data를 입력하십시요.");
						return;
					}
				} else if (testCase == "case6") {
				
				} else {
					if (testFile == "") {
						alert("Test File을 입력하십시요.");
						return;
					}
					
					if (testBizCode == "") {
						alert("거래구분 코드를 입력하십시요.");
						return;
					}
				}
				
				frm.todo.value = todo;
				frm.submit();
			}
			
			function displayMethod() {
				var displayMode = document.pform.displayMode.value;
				const btnDisplay = document.getElementById("btnDisplay");
				
				if (displayMode == "nodisplay") {
					document.all.methodDetail.style.display="";
					document.pform.displayMode.value = "display";
					btnDisplay.value = "테스트 방법 숨기기";
				} else if (displayMode == "display") {
					document.all.methodDetail.style.display="none";
					document.pform.displayMode.value = "nodisplay";
					btnDisplay.value = "테스트 방법 보기";
				}
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
				<td class="action">
					<a href="#methodDetail"><input type="button" id ="btnDisplay" name="method_detail" value="테스트 방법 보기" onClick="javascript:displayMethod()"></a>
					<input type="hidden" name="displayMode" value="nodisplay">
					<div id="methodDetail" style="display:none">
						<table>
							<tr>
								<td class="evenrow-l">
								1. About<br>
									&nbsp;&nbsp;&nbsp;&nbsp;1) Socket Admin > Basic Info > Custom Variable 메뉴에서 Variable Name "ESB.CONFIG.CUSTOMMENU.CUSTOMER"의 Value를 "MLK"로 설정한 경우에만 Unit Test 메뉴가 Display 된다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;2) 단위 테스트를 위한 기본 설정 상태에서는 실제로 방카, 은행 시스템과 연계하는 것이 아니고 "MLK_BANCA_SAMPLE" 패키지를 이용해서 자체적인 테스트만 수행하는 것이다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;방카 또는 은행 시스템과 실제로 연계하기 위해서는 4번 ~ 8번 테스트 방법의 마지막 부분을 참고하면 된다.<br><br>
									
								2. 단위 테스트 Case<br>
									&nbsp;&nbsp;&nbsp;&nbsp;1) 온라인 수신(은행에서 메트라이프로 송신)<br>
									&nbsp;&nbsp;&nbsp;&nbsp;2) 역전송(메트라이프에서 은행으로 송신)<br>
									&nbsp;&nbsp;&nbsp;&nbsp;3) 배치 수신(은행에서 메트라이프로 송신, 은행이 온라인 소켓 서버인 경우)<br>
									&nbsp;&nbsp;&nbsp;&nbsp;4) 배치 수신(은행에서 메트라이프로 송신, 메트라이프가 온라인 소켓 서버인 경우)<br>
									&nbsp;&nbsp;&nbsp;&nbsp;5) 배치 송신(메트라이프에서 은행으로 송신, 은행이 Synch 방식 소켓 서버인 경우)<br>
									&nbsp;&nbsp;&nbsp;&nbsp;6) 온라인 헬스 체크(메트라이프에서 은행으로 송신)<br><br>
									
								3. 단위 테스트를 위하여 등록한 정보들<br>
									&nbsp;&nbsp;&nbsp;&nbsp;1) Socket Admin > Basic Info > System Name<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BBUS (방카 단위 테스트 은행 시스템)<br>
									&nbsp;&nbsp;&nbsp;&nbsp;2) Socket Admin > Basic Info > Business Name<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BBOB (방카 단위 테스트 - 온라인 송수신용(은행 Online Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BBRB (방카 단위 테스트 - 역전송 송신용(은행 Synch Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BBBR (방카 단위 테스트 - 배치 수신용(은행 Online Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BBBS (방카 단위 테스트 - 배치 송신용(은행 Synch Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MBBS (방카 단위 테스트 - 배치 수신용(MLK Online Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;3) Socket Admin > Server Socket > Local Server Socket<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7731 (7732) (방카 단위 테스트 - 온라인 수신용(은행 Online Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7733 (방카 단위 테스트 - 역전송 송신용(은행 Synch Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7734 (방카 단위 테스트 - 배치 수신용(은행 Online Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7735 (방카 단위 테스트 - 배치 송신용(은행 Synch Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7736 (방카 단위 테스트 - 배치 수신용(MLK Online Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;4) Socket Admin > Server Socket > Remote Server Socket<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BBUS_BBOB_ON_IN (방카 단위 테스트 - 온라인 수신용(은행 Online Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BBUS_BBOB_ON_OUT (방카 단위 테스트 - 온라인 송신용(은행 Online Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BBUS_BBRB_RE_OUT (방카 단위 테스트 - 역전송 송신용(은행 Synch Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BBUS_BBBR_BA_IN (방카 단위 테스트 - 배치 수신용(은행 Online Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BBUS_MBBS_BA_OUT (방카 단위 테스트 - 배치 수신용(MLK Online Server))<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BBUS_BBBS_BA_OUT (방카 단위 테스트 - 배치 송신용(은행 Synch Server))<br><br>
								
								4. 온라인 수신(은행에서 메트라이프로 송신) 테스트<br>
									&nbsp;&nbsp;&nbsp;&nbsp;1) Socket Admin > Online Server > Online Server List<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Port Number "7731 (7732)"는 온라인 수신 테스트를 위한 은행 Online Socket Server 역할을 한다. 이 Port Number를 Enable 시킨다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;2) Socket Admin > Online Client > Online Client List<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Socket Name "BBUS_BBOB_ON_IN", "BBUS_BBOB_ON_OUT"은 온라인 수신 테스트를 위한 메트라이프의 Online Socket Client로서 둘 다 Online Socket Server에 Connect 시킨다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;3) Test Case를 "온라인 수신(은행에서 메트라이프로 송신)"로 선택하고 Test Data에 테스트용 전문 데이터를 입력한 후 "Send Doc" 버튼을 클릭한다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;4) Socket Name "BBUS_BBOB_ON_IN", "BBUS_BBOB_ON_OUT"의 Listener Service, Distributer Service 항목을 단위 테스트용이 아닌 실제 사용하는 서비스로 설정하면 실제 방카 시스템과 연계가 가능하다.<br><br>
									
								5. 역전송(메트라이프에서 은행으로 송신) 테스트<br>
									&nbsp;&nbsp;&nbsp;&nbsp;1) Socket Admin > Server Socket > Local Server Socket<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Port Number "7733"은 역전송 송신 테스트를 위한 은행 Synch Socket Server 역할을 한다. 이 Port Number를 Enable 시킨다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;2) Socket Admin > Server Socket > Remote Server Socket<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Socket Name "BBUS_BBRB_RE_OUT"은 역전송 송신 테스트를 위한 메트라이프의 Socket Client 역할을 한다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;3) Test Case를 "역전송(메트라이프에서 은행으로 송신)"로 선택하고 Test Data에 테스트용 전문 데이터를 입력한 후 "Send Doc" 버튼을 클릭한다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;4) Socket Name "BBUS_BBRB_RE_OUT"의 IP, Port Number를 테스트용이 아닌 실제 은행의 IP, Port Number로 설정하면 실제 은행 시스템과 연계가 가능하다.<br><br>
								
								6. 배치 수신(은행에서 메트라이프로 송신, 은행이 온라인 소켓 서버인 경우) 테스트<br>
									&nbsp;&nbsp;&nbsp;&nbsp;1) Socket Admin > Online Server > Online Server List<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Port Number "7734"는 배치 수신 테스트를 위한 은행 Online Socket Server 역할을 한다. 이 Port Number를 Enable 시킨다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;2) Socket Admin > Online Client > Online Client List<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Socket Name "BBUS_BBBR_BA_IN"은 배치 수신(은행이 온라인 소켓 서버인 경우) 테스트를 위한 메트라이프의 Online Socket Client로서 Online Socket Server에 Connect 시킨다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;3) Socket Admin > Utility > Upload File<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;테스트 하고자 하는 파일을 IS Local File System에 업로드 한다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;4) Test Case를 "배치 수신(은행에서 메트라이프로 송신, 은행이 온라인 소켓 서버인 경우)"로 선택하고 Test File에 테스트용 파일의 Full Name, 거래구분 코드를 입력한 후 "Send Doc" 버튼을 클릭한다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;5) Socket Name "BBUS_BBBR_BA_IN"의 Listener Service, Distributer Service 항목을 단위 테스트용이 아닌 실제 사용하는 서비스로 설정하면 실제 방카 시스템과 연계가 가능하다.<br><br>
								
								7. 배치 수신(은행에서 메트라이프로 송신, 메트라이프가 온라인 소켓 서버인 경우) 테스트<br>
									&nbsp;&nbsp;&nbsp;&nbsp;1) Socket Admin > Online Server > Online Server List<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Port Number "7736"은 배치 수신 테스트를 위한 메트라이프 Online Socket Server 역할을 한다. 이 Port Number를 Enable 시킨다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;2) Socket Admin > Online Client > Online Client List<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Socket Name "BBUS_MBBS_BA_OUT"은 배치 수신(메트라이프가 온라인 소켓 서버인 경우) 테스트를 위한 은행의 Online Socket Client로서 Online Socket Server에 Connect 시킨다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;3) Socket Admin > Utility > Upload File<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;테스트 하고자 하는 파일을 IS Local File System에 업로드 한다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;4) Test Case를 "배치 수신(은행에서 메트라이프로 송신, 메트라이프가 온라인 소켓 서버인 경우)"로 선택하고 Test File에 테스트용 파일의 Full Name, 거래구분 코드를 입력한 후 "Send Doc" 버튼을 클릭한다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;5) Port Number "7736"의 Listener Service, Distributer Service 항목을 단위 테스트용이 아닌 실제 사용하는 서비스로 설정하면 실제 방카 시스템과 연계가 가능하다.<br><br>
								
								8. 배치 송신(메트라이프에서 은행으로 송신, 은행이 Synch 방식 소켓 서버인 경우) 테스트<br>
									&nbsp;&nbsp;&nbsp;&nbsp;1) Socket Admin > Server Socket > Local Server Socket<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Port Number "7735"은 배치 송신 테스트를 위한 은행 Synch Socket Server 역할을 한다. 이 Port Number를 Enable 시킨다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;2) Socket Admin > Server Socket > Remote Server Socket<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Socket Name "BBUS_BBBS_BA_OUT"은 배치 송신 테스트를 위한 메트라이프의 Socket Client 역할을 한다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;3) Socket Admin > Utility > Upload File<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;테스트 하고자 하는 파일을 IS Local File System에 업로드 한다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;4) Test Case를 "배치 송신(메트라이프에서 은행으로 송신, 은행이 Synch 방식 소켓 서버인 경우)"로 선택하고 Test File에 테스트용 파일의 Full Name, 거래구분 코드를 입력한 후 "Send Doc" 버튼을 클릭한다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;5) Socket Name "BBUS_BBBS_BA_OUT"의 IP, Port Number를 테스트용이 아닌 실제 은행의 IP, Port Number로 설정하면 실제 은행 시스템과 연계가 가능하다.<br><br>
								
								9. 온라인 헬스 체크(메트라이프에서 은행으로 송신) 테스트<br>
									&nbsp;&nbsp;&nbsp;&nbsp;1) Socket Admin > Online Server > Online Server List<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Port Number "7731 (7732)"는 온라인 수신 테스트를 위한 은행 Online Socket Server 역할을 한다. 이 Port Number를 Enable 시킨다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;2) Socket Admin > Online Client > Online Client List<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Socket Name "BBUS_BBOB_ON_IN", "BBUS_BBOB_ON_OUT"은 온라인 수신 테스트를 위한 메트라이프의 Online Socket Client로서 둘 다 Online Socket Server에 Connect 시킨다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;3) Test Case를 "온라인 헬스 체크(메트라이프에서 은행으로 송신)"로 선택하고 Test Data는 입력하지 않고 "Send Doc" 버튼을 클릭한다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;지속적으로 헬스 체크를 수행하는 것이 아니고 헬스 체크 전문 송수신 1회만 수행하는 것이다.<br><br>
								
								10. 단위 테스트 결과 조회<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1) 온라인 수신(은행에서 메트라이프로 송신)<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;단위 테스트 화면의 "Doc Send Results" 영역에서 은행 쪽 송수신 로그를 조회할 수 있다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;은행 쪽 응답전문 수신 로그는 IS Administrator > Logs > Server 메뉴에서도 조회할 수 있다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;메트라이프 쪽 송수신 로그는 IS Administrator > Logs > Server 메뉴에서 조회할 수 있다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2) 역전송(메트라이프에서 은행으로 송신)<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;단위 테스트 화면의 "Doc Send Results" 영역에서 메트라이프 쪽 송신 로그를 조회할 수 있다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;은행 쪽 송수신 로그는 IS Administrator > Logs > Server 메뉴에서 조회할 수 있다.<br>	
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3) 배치 수신(은행에서 메트라이프로 송신, 은행이 온라인 소켓 서버인 경우)<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;단위 테스트 화면의 "Doc Send Results" 영역에서 은행 쪽 송수신 로그를 조회할 수 있다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;메트라이프 쪽 송수신 로그는 IS Administrator > Logs > Server 메뉴에서 조회할 수 있다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4) 배치 수신(은행에서 메트라이프로 송신, 메트라이프가 온라인 소켓 서버인 경우)<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;단위 테스트 화면의 "Doc Send Results" 영역에서 은행 쪽 송수신 로그를 조회할 수 있다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;메트라이프 쪽 송수신 로그는 IS Administrator > Logs > Server 메뉴에서 조회할 수 있다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5) 배치 송신(메트라이프에서 은행으로 송신, 은행이 Synch 방식 소켓 서버인 경우)<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;단위 테스트 화면의 "Doc Send Results" 영역에서 메트라이프 쪽 송수신 로그를 조회할 수 있다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;은행 쪽 송수신 로그는 IS Administrator > Logs > Server 메뉴에서 조회할 수 있다.<br>	
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6) 온라인 헬스 체크(메트라이프에서 은행으로 송신)<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;단위 테스트 화면의 "Doc Send Results" 영역에서 메트라이프 쪽 송수신 로그를 조회할 수 있다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;메트라이프 쪽 응답전문 수신 로그는 IS Administrator > Logs > Server 메뉴에서도 조회할 수 있다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;은행 쪽 송수신 로그는 IS Administrator > Logs > Server 메뉴에서 조회할 수 있다.<br>	
								</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Doc Send Properties</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Test Case</td>
					<td class="evenrow-l" width="70%">
						<select name="testCase">
							<option value="case1">온라인 수신(은행에서 메트라이프로 송신)</option>
							<option value="case2">역전송(메트라이프에서 은행으로 송신)</option>
							<option value="case3">배치 수신(은행에서 메트라이프로 송신, 은행이 온라인 소켓 서버인 경우)</option>
							<option value="case4">배치 수신(은행에서 메트라이프로 송신, 메트라이프가 온라인 소켓 서버인 경우)</option>
							<option value="case5">배치 송신(메트라이프에서 은행으로 송신, 은행이 Synch 방식 소켓 서버인 경우)</option>
							<option value="case6">온라인 헬스 체크(메트라이프에서 은행으로 송신)</option>
						</select>
						<script language="javascript">
							document.pform.testCase.value = "%value testCase%";
						</script>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Test Data</td>
					<td class="evenrow-l" width="70%">
						<textarea name="testData" value="" cols="200" rows="20">%value testData%</textarea>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Test File</td>
					<td class="evenrow-l" width="70%">
						<input type="text" name="testFile" value="%value testFile%" style="font-size:10pt;width:700">&nbsp;&nbsp;
						거래구분 코드&nbsp;<input type="text" name="testBizCode" value="%value testBizCode%" style="font-size:10pt;width:70">
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
					%ifvar resultMsgText equals('true')%
						<td class="evenrow-l" width="70%">
							<textarea cols="200" rows="20">%value sendResultMsg%</textarea>
						</td>
					%else%
						<td class="evenrow-l" width="70%">
							%value sendResultMsg%							
						</td>
					%endifvar%
				</tr>
				<tr>
					<td class="evenrow" width="30%">Send Socket Log</td>
					<td class="evenrow-l" width="70%">
						<textarea cols="200" rows="20">%value sendSocketLog%</textarea>
					</td>
				</tr>
				%ifvar testCase equals('case1')%
				<tr>
					<td class="evenrow" width="30%">Receive Result Code</td>
					<td class="evenrow-l" width="70%">%value receiveResultCode%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Receive Result Msg</td>
					<td class="evenrow-l" width="70%">%value receiveResultMsg%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Receive Socket Log</td>
					<td class="evenrow-l" width="70%">
						<textarea cols="200" rows="20">%value receiveSocketLog%</textarea>
					</td>
				</tr>
				%endifvar%
				%ifvar testCase equals('case6')%
				<tr>
					<td class="evenrow" width="30%">Receive Result Code</td>
					<td class="evenrow-l" width="70%">%value receiveResultCode%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Receive Result Msg</td>
					<td class="evenrow-l" width="70%">%value receiveResultMsg%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Receive Socket Log</td>
					<td class="evenrow-l" width="70%">
						<textarea cols="200" rows="20">%value receiveSocketLog%</textarea>
					</td>
				</tr>
				%endifvar%
			</table>				
		</form>		
	</body>
</html>

%endinvoke%