%invoke JSocketAdapter.ADMIN:adminDeployAllConfig%

<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>

		<script language="javascript">
			function doAction(){				
				var targetServerLength = document.pform.targetServer.options.length;
				var remoteAliasList = "";
				
				for (var i = 0; i < targetServerLength; i++) {
					if (document.pform.targetServer.options[i].selected) {
						if (remoteAliasList == "") {
							remoteAliasList = document.pform.targetServer.options[i].value;
						} else {
							remoteAliasList = remoteAliasList + "/" + document.pform.targetServer.options[i].value;
						}
					}
				}
				
				if (remoteAliasList == "") {
					alert("Target Server를 선택하십시요!!!");
					return;
				}
				
				document.pform.targetServers.value = remoteAliasList;
				
				if (document.pform.dupProcessType.value == "update") {
					if (confirm("Processing Type For Duplicates 항목을 Update를 선택 시 Target Server에 이미 등록되어 있는 정보에 대해서는 Update 처리 됩니다.\n계속 진행하시겠습니까?")) {
						
					} else {
						return;
					}
				}
				
				var socketNameList = [];
				var tobeIP = "";
				var tobePort = "";
				var tobeIPVal = "";
				var tobePortVal = "";
				
				%loop ClientPortConfig/Ports -$index%
					socketNameList[%value $index%] = "%value name%";
				%endloop%
				
				if (socketNameList.length > 0) {
					for (var i = 0; i < socketNameList.length; i++) {
						tobeIP = "tobeIP" + socketNameList[i];
						tobePort = "tobePort" + socketNameList[i];
						tobeIPVal = document.getElementById(tobeIP).value;
						tobePortVal = document.getElementById(tobePort).value;
						
						if (tobeIPVal == "") {
							tobeIPVal = "NC";
						}
						
						if (tobePortVal == "") {
							tobePortVal = "NC";
						}
						
						if (document.pform.changeSNIPPort.value == "") {
							document.pform.changeSNIPPort.value = socketNameList[i] + "|" + tobeIPVal + "|" + tobePortVal;
						} else {
							document.pform.changeSNIPPort.value = document.pform.changeSNIPPort.value + "/" + socketNameList[i] + "|" + tobeIPVal + "|" + tobePortVal;
						}
					}
				}
				
				if(confirm("Deploy 하지 않은 모든 Config 정보에 대해서\n일괄적으로 Deploy 하시겠습니까?")){
					document.pform.submit();
				}
			}
			
			function alertMsg() {
				var deploy = "%value deploy%";
				
				if (deploy == "remote") {
					// Deploy 처리를 한 경우에는 Alert Message 생략 ==> 화면에 Deploy 처리결과가 Display 된다.
				} else {
					var msg = document.pform.alertMsg.value;
				
					if (msg != "") {
						alert(msg);
					}
				}
			}
		</script>
		
</head>
<body onload="javascript:alertMsg()">	
		%ifvar deploy equals('remote')%
		%else%
		<div class="message">아직 Deploy 하지 않은 모든 Config 정보에 대해서 일괄적으로 Deploy 할 수 있는 메뉴입니다.</div>
		%endifvar%
	
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					Deploy Config &gt;
					All Config
				</td>
			</tr>
		</table>
		
		%ifvar deploy equals('remote')%
			
			<ul class="listitems">
				<li class="listitem"><a href="deploy-allconfig.dsp">Return to All Config Deployment Information</a></li>
			</ul>
			
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">All Config Deployment Result</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			
			%ifvar CustomVariableValueResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>Custom Variable Value Information</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>Variable Name</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>
        	</tr>
        	
        	%loop CustomVariableValueResult%
        	
        		<tr>
        			<td>%value targetServer%</td>
        			<td>%value keyValue%</td>
        			<td>%value deployYN%</td>
        			<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
        			</td>
        		</tr>
        		
        	%endloop%
        	
        </table>
        <table><tr><td>&nbsp;</td></tr></table>
        
       %endifvar%
       
       %ifvar CustomVariableResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>Custom Variable Information</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>Variable Name</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>			
        	</tr>
        	
        	%loop CustomVariableResult%
        	
        		<tr>
        			<td>%value targetServer%</td>
        			<td>%value keyValue%</td>
        			<td>%value deployYN%</td>
        			<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
        			</td>
        		</tr>
        		
        	%endloop%
        	
        </table>
        <table><tr><td>&nbsp;</td></tr></table>
        
       %endifvar%
       
       %ifvar SystemCodeResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>System Name Information</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>System Name</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>			
        	</tr>
        	
        	%loop SystemCodeResult%
        	
        		<tr>
        			<td>%value targetServer%</td>
        			<td>%value keyValue%</td>
        			<td>%value deployYN%</td>
        			<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
        			</td>
        		</tr>
        		
        	%endloop%
        	
        </table>
        <table><tr><td>&nbsp;</td></tr></table>
        
       %endifvar%
       
       %ifvar BusinessNameResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>Business Name Information</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>Business Name</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>			
        	</tr>
        	
        	%loop BusinessNameResult%
        	
        		<tr>
        			<td>%value targetServer%</td>
        			<td>%value keyValue%</td>
        			<td>%value deployYN%</td>
        			<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
        			</td>
        		</tr>
        		
        	%endloop%
        	
        </table>
        <table><tr><td>&nbsp;</td></tr></table>
        
       %endifvar%
       
       %ifvar InterfaceListResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>Interface List Information in Business Name</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>Interface ID</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>			
        	</tr>
        	
        	%loop InterfaceListResult%
        	
        		<tr>
        			<td>%value targetServer%</td>
        			<td>%value keyValue%</td>
        			<td>%value deployYN%</td>
        			<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
        			</td>
        		</tr>
        		
        	%endloop%
        	
        </table>
        <table><tr><td>&nbsp;</td></tr></table>
        
       %endifvar%
       
       %ifvar LocalFileResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>Local File Path Infomation For Deletion</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>Local File Path</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>
        	</tr>
        	
        	%loop LocalFileResult%
        	
        		<tr>
        			<td>%value targetServer%</td>
        			<td>%value keyValue%</td>
        			<td>%value deployYN%</td>
        			<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
        			</td>
        		</tr>
        		
        	%endloop%
        	
        </table>
        <table><tr><td>&nbsp;</td></tr></table>
        
       %endifvar%
       
       %ifvar ServerPortResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>Local Server Socket Information</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>Port</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>			
        	</tr>
        	
        	%loop ServerPortResult%
        	
        		<tr>
        			<td>%value targetServer%</td>
        			<td>%value keyValue%</td>
        			<td>%value deployYN%</td>
        			<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
        			</td>
        		</tr>
        		
        	%endloop%
        	
        </table>
        <table><tr><td>&nbsp;</td></tr></table>
        
       %endifvar%
       
       %ifvar ClientPortResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>Remote Server Socket Information</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>Socket Name</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>			
        	</tr>
        	
        	%loop ClientPortResult%
        	
        		<tr>
        			<td>%value targetServer%</td>
        			<td>%value keyValue%</td>
        			<td>%value deployYN%</td>
        			<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
        			</td>
        		</tr>
        		
        	%endloop%
        	
        </table>
        <table><tr><td>&nbsp;</td></tr></table>
        
       %endifvar%
       
       %ifvar DocInterfaceIDResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>Interface Doc Information</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>Doc Name</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>			
        	</tr>
        	
        	%loop DocInterfaceIDResult%
        	
        		<tr>
        			<td>%value targetServer%</td>
        			<td>%value keyValue%</td>
        			<td>%value deployYN%</td>
        			<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
        			</td>
        		</tr>
        		
        	%endloop%
        	
        </table>
        <table><tr><td>&nbsp;</td></tr></table>
        
       %endifvar%
	   
	   %ifvar RestDocIDExtractResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>REST API Protocol Information</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>Name</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>			
        	</tr>
        	
        	%loop RestDocIDExtractResult%
        	
        		<tr>
        			<td>%value targetServer%</td>
        			<td>%value keyValue%</td>
        			<td>%value deployYN%</td>
        			<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
        			</td>
        		</tr>
        		
        	%endloop%
        	
        </table>
        <table><tr><td>&nbsp;</td></tr></table>
        
       %endifvar%
	   
	   %ifvar SourceTargetEmailResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>Source Target Email Information</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>Interface ID</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>			
        	</tr>
        	
        	%loop SourceTargetEmailResult%
        	
        		<tr>
        			<td>%value targetServer%</td>
        			<td>%value keyValue%</td>
        			<td>%value deployYN%</td>
        			<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
        			</td>
        		</tr>
        		
        	%endloop%
        	
        </table>
        <table><tr><td>&nbsp;</td></tr></table>
        
       %endifvar%
       
       %ifvar OnlineCheckScheduleResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>Online Check Schedule Information</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>Service</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>			
        	</tr>
        	
        	%loop OnlineCheckScheduleResult%
        	
        		<tr>
        			<td>%value targetServer%</td>
        			<td>%value keyValue%</td>
        			<td>%value deployYN%</td>
        			<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
        			</td>
        		</tr>
        		
        	%endloop%
        	
        </table>
        <table><tr><td>&nbsp;</td></tr></table>
        
       %endifvar%
       
       %ifvar OnlineTriggerResult -notempty%
			
				<table class="tableView" width=100%>
        	<tr>
						<td class="heading" colspan=4>Online Trigger Information</td>
					</tr>
        	<tr class="subheading2">
						<td>Target Server</td>
						<td>Trigger Name</td>
						<td>Deployment Result</td>
						<td>Deployment Message</td>			
        	</tr>
        	
        	%loop OnlineTriggerResult%
        	
        		<tr>
        			<td>%value targetServer%</td>
        			<td>%value keyValue%</td>
        			<td>%value deployYN%</td>
        			<td>
        				%loop alertMsgList%
        					%value alertMsgList%<br>
        				%endloop%
        			</td>
        		</tr>
        		
        	%endloop%
        	
        </table>
        <table><tr><td>&nbsp;</td></tr></table>
        
       %endifvar%
				
		%else%
		
			<form name="pform" method="post" target="_self">
				<input type="hidden" name="deploy" value="remote">
				<input type="hidden" name="targetServers" value="">
				<input type="hidden" name="changeSNIPPort" value="">
				<input type="hidden" name="alertMsg" value="%value deployMsg%">
			
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">All Config Deployment</td>
				</tr>
				<tr>
					<tr>
						<td class="evenrow" width="30%">Target Server</td>
						<td class="evenrow-l" width="70%">
							<!-- 하나만 선택한 경우에는 targetServer 라는 이름으로 선택한 값이 flow service에 전달되고
							     두 개 이상을 선택한 경우에는 targetServer 라는 이름으로 첫번째 선택한 값과
							     targetServerList 라는 이름으로(자동으로 생성됨) 선택한 모든 값이 StringList 형태로
							     flow service에 전달된다. -->
							<select name="targetServer" style="width:90" size=3 multiple>
								%loop remoteServerList%
									<option value="%value remoteServerList%">%value remoteServerList%</option>
								%endloop%
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Processing Type For Duplicates</td>
						<td class="evenrow-l" width="70%">
							<select name="dupProcessType" style="width:110">
								<option value="notAdd">Not Add</option>
								<option value="update">Update</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="action" colspan="2">
							<input type="button" name="SUBMIT" value="Deploy All Config"  onclick="return doAction()"></input>
						</td>
					</tr>
				</tr>
			</table>
			
			<table class="tableView" width=100%>
        <tr>
					<td class="heading" colspan=3>Custom Variable Value Information</td>
				</tr>
        <tr class="subheading2">
					<td>Variable Name</td>
					<td>Description</td>
					<td>Variable Values</td>
        </tr>
				%ifvar -notempty CustomVariableValueConfig/Items%
					%loop CustomVariableValueConfig/Items%
						<tr>
							<td>%value variableName%</td>
							<td>%value description%</td>
							<td>
								%loop variableValueList%
									%value value%<br>
								%endloop%
							</td>					
						</tr>
					%endloop%
				%else%
					<tr><td colspan=3>No custom variable values to deploying are currently.</td></tr>
				%endif%			
				
    	</table>
    	<table><tr><td>&nbsp;</td></tr></table>
    
    	<table class="tableView" width=100%>
      	<tr>
					<td class="heading" colspan=3>Custom Variable Information</td>
				</tr>
        <tr class="subheading2">
					<td>Variable Name</td>
					<td>Variable Value</td>
					<td>Description</td>
        </tr>
				%ifvar -notempty CustomVariableConfig/Items%
					%loop CustomVariableConfig/Items%
						<tr>
							<td>%value variableName%</td>
							<td>%value variableValue%</td>
							<td>%value description%</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan=3>No custom variables to deploying are currently.</td></tr>
				%endif%			
				
    	</table>
    	<table><tr><td>&nbsp;</td></tr></table>
    	
    	<table class="tableView" width=100%>
        <tr>
					<td class="heading" colspan=2>System Name Information</td>
				</tr>
    		<tr class="subheading2">
					<td>System Name</td>
					<td>Description</td>
    		</tr>
				%ifvar -notempty SystemCodeConfig/Items%
					%loop SystemCodeConfig/Items%
						<tr>
							<td>%value name%</td>
							<td>%value description%</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan=2>No system names to deploying are currently.</td></tr>
				%endif%			
				
    	</table>
    	<table><tr><td>&nbsp;</td></tr></table>
    	
    	<table class="tableView" width=100%>
        <tr>
					<td class="heading" colspan=5>Business Name Information</td>
				</tr>
        <tr class="subheading2">
					<td>Business Name</td>
					<td>Provider System Name</td>
					<td>Receive DataQ Name</td>
					<td>Receive DataQ KeyLength</td>
					<td>Description</td>
        </tr>
				%ifvar -notempty BusinessNameConfig/Items%
					%loop BusinessNameConfig/Items%
						<tr>
							<td>%value name%</td>
							<td>%value systemName%</td>
							<td>%value qName%</td>
							<td>%value keyLength%</td>
							<td>%value description%</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan=5>No business names to deploying are currently.</td></tr>
				%endif%		
				
    	</table>
    	<table><tr><td>&nbsp;</td></tr></table>
    	
    	<table class="tableView" width=100%>
        <tr>
					<td class="heading" colspan=7>Doc List Information in Business Name</td>
				</tr>
        <tr class="subheading2">
					<td>Business Name</td>
					<td>System Name</td>
					<td>Doc Name</td>
					<td>Doc Class Code (전문종별코드)</td>
					<td>Doc Business Code (전문업무구분코드)</td>
					<td>Interface ID</td>
					<td>Description</td>
        </tr>
				%ifvar -notempty InterfaceListConfig/Items%
					%loop InterfaceListConfig/Items%
						<tr>
							<td>%value businessName%</td>
							<td>%value systemName%</td>
							<td>%value docName%</td>
							<td>%value classCode%</td>
							<td>%value businessCode%</td>
							<td>%value interfaceID%</td>
							<td>%value description%</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan=7>No business docs to deploying are currently.</td></tr>
				%endif%			
				
    	</table>
    	<table><tr><td>&nbsp;</td></tr></table>
    	
    	<table class="tableView" width=100%>
        <tr>
        	<td class="heading" colspan=5>Local File Path Infomation For Deletion</td>
        </tr>
        <tr class="subheading2">
          <td>Local File Path</td>
					<td>Remain Days</td>
					<td>Sub-Directory Delete YN</td>
					<td>Shared Directory YN</td>
					<td>Description</td>
        </tr>
				%ifvar -notempty LocalFileConfig/Items%
        	%loop LocalFileConfig/Items%
						<tr>
							<td>%value filePath%</td>
							<td>%value remainDays%</td>
							<td>%value dirDeleteYN%</td>
							<td>%value sharedDirYN%</td>
							<td>%value description%</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan=5>No local file paths to deploying are currently.</td></tr>
      	%endif%
      	
    	</table>
    	<table><tr><td>&nbsp;</td></tr></table>
    	
    	<table class="tableView" width=100%>
        <tr>
					<td class="heading" colspan=8>Local Server Socket Information</td>
				</tr>
        <tr class="subheading2">
					<td>Enabled</td>
					<td>Port</td>
					<td>Description</td>
					<td>Execute Service</td>
					<td>Run As</td>
					<td>Read Timeout</td>
					<td>Thread Pool Usage</td>
					<td>Max Pool Size</td>
        </tr>
				%ifvar -notempty ServerPortConfig/Ports%
					%loop ServerPortConfig/Ports%
						<tr>
							<td>
								%ifvar enabled equals('true')%
									Yes
								%else%
									No
								%endifvar%
							</td>
							<td>%value portNumber%</td>
							<td>%value description%</td>
							<td>%value servicePath%</td>
							<td class="evenrowdata">%value runAs%</td>
							<td class="evenrowdata">%value readTimeout%</td>
							<td class="evenrowdata">
								%ifvar threadPool equals('true')%
									Yes
								%else%
									No
								%endifvar%
							</td>
							<td class="evenrowdata">%value poolSize%</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan=8>No local server sockets to deploying are currently.</td></tr>
				%endif%			
				
    	</table>
    	<table><tr><td>&nbsp;</td></tr></table>
    	
    	<table class="tableView" width=100%>
        <tr>
					<td class="heading" colspan="5">Remote Server Socket Information</td>
				</tr>
        <tr class="subheading2">
					<td>Socket Name</td>
					<td>Description</td>
					<td>IP</td>
					<td>Port</td>
					<td>Change IP & Port</td>
        </tr>
				%ifvar -notempty ClientPortConfig/Ports%
					%loop ClientPortConfig/Ports%
						<tr>
							<td>%value name%</td>
							<td>%value description%</td>
							<td>%value ip%</td>
							<td>%value port%</td>
							<td>
								This Server <input type="text" disabled id="asisIP%value name%" name="asisIP%value name%nm" value="%value ip%" size="5" style="font-size:10pt;width:200">&nbsp;&nbsp;
                                            <input type="text" disabled id="asisPort%value name%" name="asisPort%value name%nm" value="%value port%" size="5" style="font-size:10pt;width:70"> -->
								Target Server <input type="text" id="tobeIP%value name%" name="tobeIP%value name%nm" value="%value ip%" size="5" style="font-size:10pt;width:200">&nbsp;&nbsp;
								              <input type="text" id="tobePort%value name%" name="tobePort%value name%nm" value="%value port%" size="5" style="font-size:10pt;width:70">
							</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan="5">No remote server sockets to deploying are currently.</td></tr>
				%endif%			
				
    	</table>
    	<table><tr><td>&nbsp;</td></tr></table>
    	
    	<table class="tableView" width=100%>
        <tr>
					<td class="heading" colspan=6>Interface Doc Information</td>
				</tr>
        <tr class="subheading2">
					<td>Doc Name</td>
					<td>Doc Class Code (전문종별코드)</td>
					<td>Doc Business Code (전문업무구분코드)</td>
					<td>Interface ID</td>
					<td>Description</td>
					<td>Listening Port</td>
        </tr>
				%ifvar -notempty DocInterfaceIDConfig/Items%
					%loop DocInterfaceIDConfig/Items%
						<tr>
							<td>%value docName%</td>
							<td>%value classCode%</td>
							<td>%value businessCode%</td>
							<td>%value interfaceID%</td>
							<td>%value description%</td>
							<td>%value portNumber%</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan=6>No local server socket docs to deploying are currently.</td></tr>
				%endif%			
				
    	</table>
    	<table><tr><td>&nbsp;</td></tr></table>
		
		<table class="tableView" width=100%>
        <tr>
					<td class="heading" colspan=4>REST API Protocol Information</td>
				</tr>
        <tr class="subheading2">
					<td>Name</td>
					<td>API System Name</td>
					<td>API Business Name</td>
					<td>Description</td>
        </tr>
				%ifvar -notempty RestDocIDExtractConfig/Items%
					%loop RestDocIDExtractConfig/Items%
						<tr>
							<td>%value restName%</td>
							<td>%value systemName%</td>
							<td>%value businessName%</td>
							<td>%value description%</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan=4>No rest api protocols to deploying are currently.</td></tr>
				%endif%			
				
    	</table>
    	<table><tr><td>&nbsp;</td></tr></table>
		
		<table class="tableView" width=100%>
        <tr>
					<td class="heading" colspan=5>Source Target Email Information</td>
				</tr>
        <tr class="subheading2">
					<td>Interface ID</td>
					<td>Doc Name</td>
					<td>Description</td>
					<td>Source System Incharge Email</td>
					<td>Target System Incharge Email</td>
        </tr>
				%ifvar -notempty SourceTargetEmailConfig/Items%
					%loop SourceTargetEmailConfig/Items%
						<tr>
							<td>%value interfaceID%</td>
							<td>%value docName%</td>
							<td>%value description%</td>
							<td>
								%loop sourceEmailList%
									%value email%<br>
								%endloop%
							</td>
							<td>
								%loop targetEmailList%
									%value email%<br>
								%endloop%
							</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan=5>No source target emails to deploying are currently.</td></tr>
				%endif%			
				
    	</table>
    	<table><tr><td>&nbsp;</td></tr></table>
    	
    	<table class="tableView" width=100%>
        <tr>
					<td class="heading" colspan=4>Online Check Schedule Information</td>
				</tr>
        <tr class="subheading2">
					<td>Service</td>
					<td>Provider System Name</td>
					<td>Business Name</td>
					<td>Socket Name</td>
        </tr>
				%ifvar -notempty OnlineCheckScheduleConfig/Items%
					%loop OnlineCheckScheduleConfig/Items%
						<tr>
							<td>%value service%</td>
							<td>%value systemName%</td>
							<td>%value businessName%</td>
							<td>%value socketName%</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan=4>No online check schedules to deploying are currently.</td></tr>
				%endif%		
				
    	</table>
    	<table><tr><td>&nbsp;</td></tr></table>

      <table class="tableView" width=100%>
        <tr>
					<td class="heading" colspan=3>Online Trigger Information</td>
				</tr>
        <tr class="subheading2">
					<td>Trigger Name</td>
					<td>Provider System Name</td>
					<td>Business Name</td>
        </tr>
				%ifvar -notempty OnlineTriggerConfig/Items%
					%loop OnlineTriggerConfig/Items%
						<tr>
							<td>%value trgName%</td>
							<td>%value systemName%</td>
							<td>%value businessName%</td>
						</tr>
					%endloop%
				%else%
					<tr><td colspan=3>No online triggers to deploying are currently.</td></tr>
				%endif%		
    	</table>
   </form>
   %endifvar%
</body>
</html>

%endinvoke%