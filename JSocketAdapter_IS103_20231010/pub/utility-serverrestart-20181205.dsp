%invoke JSocketAdapter.ADMIN:adminServerRestart%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(bounce) {
				var frm = document.pform;
				var asisPPort = "%value primary/port%";
				var tobePPort = frm.primaryListener.value;
				var portInfo = tobePPort.split("@");
				tobePPort = portInfo[1];
				var ignoreUser = frm.ignoreUser.value;
				var checkTimeout = frm.checkTimeout.value;
				
				if (asisPPort == tobePPort) {
					alert("AS-IS Primary Port는 Disable 처리 됩니다.\nTO-BE Primary Port를 AS-IS Primary Port와 다른 Port를 선택하십시요.");
					return;
				}
				
				if (ignoreUser == "") {
					alert("Ignore Session User를 입력하십시요.");
					return;
				}
				
				if (checkTimeout == "") {
					alert("Check Timeout을 입력하십시요.");
					return;
				}
				
				var conMsg = "";
				
				if (bounce == "yes") {
				  conMsg = "현재 Server를 Restart 합니다.\n계속 진행 하시겠습니까?";
				} else {
				  conMsg = "현재 Server를 Shutdown 합니다.\n계속 진행 하시겠습니까?";
				}
				
				if (confirm(conMsg)) {
				  frm.bounce.value = bounce;
				  frm.submit();
				} else {
				  return;
				}
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
		
		<div class="message">현재 Server에서 운영되고 있는 기능들을 %value otherServer% Server에서 실행되도록 Switching 한 후 현재 Server를 Shutdown or Restart 합니다.</div>
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">
			<input type="hidden" name="bounce" value="">
			<input type="hidden" name="option" value="force">
			<input type="hidden" name="quiesce" value="false">
			<input type="hidden" name="alertMsg" value="%value resultMsg%">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Utility &gt;
						Server Restart
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Server Shutdown/Restart Properties</td>
			</tr>
			
			%ifvar progressMsg -notempty%
			  <tr>
				  <td class="evenrow" width="30%">Progress Message</td>
				  <td class="evenrow-l" width="70%">%value progressMsg%</td>
				</tr>
				%ifvar resultMsgList -notempty%				  
				  <tr>
				    <td class="evenrow" width="30%">Result Message</td>
				    <td class="evenrow-l" width="70%">
				      <script>
				        var resultMsg = "";
				        var resultMsgList = "";
				        
				        %loop resultMsgList%
				          resultMsg = "%value resultMsgList encode(none)%";
				          resultMsg = resultMsg.replace(/ /gi, "&nbsp;"); // Space를 &nbsp;로 변환
				          resultMsgList = resultMsgList + resultMsg + "<br>";
				        %endloop%
                
                document.write(resultMsgList);
              </script>
				    </td>
				  </tr>
				%endifvar%
		    </table>
			%else%
				<tr>
				  <td class="evenrow" width="30%">Primary Port Change</td>
				  <td class="evenrow-l" width="70%">AS-IS Primary Port %value primary/port% --> TO-BE Primary Port&nbsp;
				    <select name="primaryListener">
              %loop listeners%
                %ifvar matches('HTTP*') protocol%
                  %ifvar equals('true') enabled%
                    %ifvar equals('WmRoot') pkg%
                      %ifvar equals('Regular') listenerType%
                        <option value="%value key encode(htmlattr)%">
                          %value portAlias encode(html)%(%value port encode(html)%)
                        </option>
                      %endif%
                    %endif%
                  %endif%
                %endif%
              %endloop%
            </select>
            <input type="hidden" name="operation" value="setPrimary">
            <input type="hidden" name="poperation" value="disable">
            <input type="hidden" name="listenerKey" value="%value primary/key encode(htmlattr)%">
            <input type="hidden" name="pkg" value="%value primary/pkg encode(htmlattr)%">
				  </td>
				</tr>
				<tr>
				  <!--
				  <td class="evenrow" width="30%">Running Service Name Check</td>
				  <td class="evenrow-l" width="70%">
				    <input type="text" name="runningServiceName" value="" size="20" style="font-size:10pt;width:400"> (여러 개인 경우 '/' 로 구분)
				  </td>
				  -->
				  <td class="evenrow" width="30%">Ignore Session User</td>
				  <td class="evenrow-l" width="70%">
				    <input type="text" name="ignoreUser" value="Administrator" size="20" style="font-size:10pt;width:300"> (여러 개인 경우 '/' 로 구분)&nbsp;&nbsp;&nbsp;&nbsp;
				    Check Timeout <input type="text" name="checkTimeout" value="30" size="20" style="font-size:10pt;width:40"> seconds
				  </td>
				<tr>
				  <td class="evenrow" width="30%">Re-Switching YN After Server Starting</td>
				  <td class="evenrow-l" width="70%">
				    <select name="reswitching">
				      <option value="yes">Yes</option>
				      <option value="no">No</option>
				    </select> (현재 Server Starting 후 기존의 기능들을 현재 Server에서 다시 운영되도록 Switching 할 것인지 여부)
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Restart"  onclick="return doAction('yes')"></input>&nbsp;&nbsp;
						<input type="button" name="SUBMIT" value="Shutdown"  onclick="return doAction('no')"></input>
					</td>
				</tr>
		  </table>
		  
		  <table class="tableForm" width="100%">
			  <tr>
				  <td class="heading">Server Shutdown/Restart Flow</td>
			  </tr>
			  <tr>
			    <td class="evenrow-l">
			      1. 대외기관 온라인 소켓 관련 업무를 제외한 AS400 Data Q Listener Switching<br>
            2. 대외기관 온라인 소켓 Switching<br>
            3. Running Socket Server Shutdown<br>
            4. Primary Port 변경<br>
            5. 기존 Primary Port Disable<br>
               &nbsp;&nbsp;&nbsp;&nbsp;Disable 처리 이전에 수신되고 아직 완료가 안된 서비스는 정상적으로 처리되어 Client에게 정상적으로 응답을 보낸다.<br>
               &nbsp;&nbsp;&nbsp;&nbsp;Client 쪽에서도 Port Disable 하더라도 Connection이 끊기지 않고 정상적으로 응답을 수신한다.<br>
            6. Registration Internal Port Disable<br>
               &nbsp;&nbsp;&nbsp;&nbsp;Disable 처리 이전에 수신되고 아직 완료가 안된 서비스는 정상적으로 처리되어 Client에게 정상적으로 응답을 보낸다.<br>
               &nbsp;&nbsp;&nbsp;&nbsp;Client 쪽에서도 Port Disable 하더라도 Connection이 끊기지 않고 정상적으로 응답을 수신한다.<br>
            7. 1 ~ 6 내용을 파일로 저장 ==> 화면에서 Re-Switching 하도록 선택한 경우에만 저장<br>
            8. 유효한 Client Session이 있는지 체크<br>
            9. 1 ~ 8까지 처리 내역을 ESB 관리자에게 메일로 통보<br>
            10. 유효한 Client Session이 없을 경우 IS Shutdown/Restart<br>
            11. IS Start 시 startup 서비스 실행 ==> 1 ~ 6 내용을 저장한 파일을 읽어서 13 ~ 18까지 처리 ==> 파일이 존재하지 않을 경우 startup 서비스 바로 종료됨<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;==> 파일 내용을 읽은 후 파일 삭제<br>
            12. IS Start가 완료될 때까지 대기<br>
            13. Registration Internal Port Enable<br>
            14. 기존 Primary Port Enable<br>
            15. Primary Port 원래대로 변경<br>
            16. 대외기관 온라인 소켓 관련 업무를 제외한 AS400 Data Q Listener 원래대로 Switching<br>
            17. 대외기관 온라인 소켓 원래대로 Switching<br>
            18. 13 ~ 17 내용을 ESB 관리자에게 메일로 통보
          </td>
        </tr>
      </table>
		  %endifvar%

		</form>
	</body>
</html>

%endinvoke%