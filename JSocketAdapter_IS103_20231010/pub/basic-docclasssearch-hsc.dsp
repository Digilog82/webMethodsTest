%invoke JSocketAdapter.ADMIN:adminDocClassSearch_HSC%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(){
				document.pform.submit();				
			}
			
			var seq = 1;
		</script>
	</head>
	<body>				
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%		
		
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
					JSocketAdapter Package Home &gt;
					Basic Info &gt;
					Doc Class Search
				</td>
			</tr>
		</table>
		
		<form name="pform" method="post" target="_self">
			<input type="hidden" name="todo" value="search">
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">Search Condition</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Common Header Length</td>
				<td class="evenrow-l" width="70%">
					<select name="sHeaderLength" style="width:300">
						<option value="">선택</option>
						%loop HeaderLengthList%
							<option value="%value lengthValue%">%value lengthDesc%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.sHeaderLength.value = "%value sHeaderLength%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Listening Port</td>
				<td class="evenrow-l" width="70%">
					<select name="sPortNumber" style="width:300">
						<option value="">선택</option>
						%loop portList%
							<option value="%value portList%">%value portList%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.sPortNumber.value = "%value sPortNumber%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Health Check Doc YN</td>
				<td class="evenrow-l" width="70%">
					<select name="sHealthCheckDoc" style="width:300">
						<option value="">선택</option>
						<option value="No">No</option>
						<option value="Yes">Yes</option>
					</select>
					<script language="javascript">
						document.pform.sHealthCheckDoc.value = "%value sHealthCheckDoc%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">ANB Return Doc YN</td>
				<td class="evenrow-l" width="70%">
					<select name="sAnbReturnDoc" style="width:300">
						<option value="">선택</option>
						<option value="No">No</option>
						<option value="Yes">Yes (GW 서버에서 Return)</option><!-- 전문을 수신한 Socket으로 Ack 전문을 리턴하는 경우 -->
						<option value="YesRSS">YesRSS (MA 서버에서 Return)</option><!-- 전문을 수신한 Socket이 아니고 Remote Server Socket으로 Ack 전문을 리턴하는 경우 -->
					</select>
					<script language="javascript">
						document.pform.sAnbReturnDoc.value = "%value sAnbReturnDoc%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Target Socket Name</td>
				<td class="evenrow-l" width="70%">
					<select name="sTargetSocketName" style="width:300">
						<option value="">선택</option>
						%loop SocketNameDescList%
							<option value="%value socketNameValue%">%value socketNameDisplay%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.sTargetSocketName.value = "%value sTargetSocketName%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">One Way Doc YN</td>
				<td class="evenrow-l" width="70%">
					<select name="sOneWayDoc" style="width:300">
						<option value="">선택</option>
						<option value="No">No</option>
						<option value="Yes">Yes</option>
					</select>&nbsp;&nbsp;
					<script language="javascript">
						document.pform.sOneWayDoc.value = "%value sOneWayDoc%";
					</script>
					One Way Port&nbsp;
					<select name="sOneWayPort" style="width:300">
						<option value="">선택</option>
						%loop portList%
							<option value="%value portList%">%value portList%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.sOneWayPort.value = "%value sOneWayPort%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Doc Length Type</td>
				<td class="evenrow-l" width="70%">
					<select name="sDocLengthType" style="width:300">
						<option value="">선택</option>
						<option value="fixed">고정길이</option>
						<option value="variable">가변길이</option>
					</select>
					<script language="javascript">
						document.pform.sDocLengthType.value = "%value sDocLengthType%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Source Target System</td>
				<td class="evenrow-l" width="70%">
					<select name="sSourceTarget" style="width:300">
						<option value="">선택</option>
						%loop SourceTargetList%
							<option value="%value sourceTargetValue%">%value sourceTargetDesc%</option>
						%endloop%
					</select>
					<script language="javascript">
						document.pform.sSourceTarget.value = "%value sSourceTarget%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Serial Processing Queue/Topic Use YN</td>
				<td class="evenrow-l" width="70%">
					<select name="sSerialProcessing" style="width:300">
						<option value="">선택</option>
						<option value="Yes">Yes</option>
						<option value="No">No</option>							
					</select>
					<script language="javascript">
						document.pform.sSerialProcessing.value = "%value sSerialProcessing%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="30%">Sending Doc Length Change YN</td>
				<td class="evenrow-l" width="70%">
					<select name="sChangeDocLength" style="width:300">
						<option value="">선택</option>
						<option value="No">No</option>
						<option value="Yes">Yes</option>
					</select>
					<script language="javascript">
						document.pform.sChangeDocLength.value = "%value sChangeDocLength%";
					</script>
				</td>
			</tr>
			<tr>
				<td class="action" colspan="2">
					<input type="button" name="SUBMIT" value="Search" onclick="return doAction()"></input>
				</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">					
			<tr>
				<td class="heading" colspan=10>Interface Doc Information</td>
			</tr>
			<tr class="subheading2">
				<td>Seq</td>
				<td>Doc Name</td>
				<td>Description</td>
				<td>Listening Port</td>
				<td>Health Check</td>
				<td>ANB Return</td>
				<td>Target Socket Name</td>
				<td>One Way Port</td>
				<td>Doc Length</td>
				<td>SourceToTarget System</td>
			</tr>
			%ifvar -notempty DocInterfaceIDInfoList%
				%loop DocInterfaceIDInfoList%
					<tr>
						<td class="evenrowdata">
							<script language="javascript">
								document.write(seq);
								seq++;
							</script>
						</td>
						<td>%value docName%</td>
						<td>%value description%</td>
						<td>%value portNumber%</td>
						<td>%value healthCheckDoc%</td>
						<td>%value returnResponse%</td>
						<td>%value targetSocketName%</td>
						<td>%value targetPortNumber%</td>
						<td>%value docLength%</td>
						<td>%value jmsSendQueue%</td>
					</tr>
				%endloop%
			%else%
				<tr><td colspan=10>No local server socket docs are currently registered.</td></tr>
			%endifvar%
		</table>
		
		</form>
	</body>
</html>
%endinvoke%