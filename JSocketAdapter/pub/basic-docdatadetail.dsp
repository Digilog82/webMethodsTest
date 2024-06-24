%invoke JSocketAdapter.ADMIN:adminDocInterfaceID%

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
						Doc Data Details
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			%ifvar schemaDefType equals('EN')%
			<!-- Endian 변환이 필요 없는 일반적인 경우 -->
			<tr>
				<td class="heading" colspan="4">%value docName% 전문 파싱</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Field Length</td>
				<td>Field Value</td>
			</tr>
			%loop DocDataList%
				<tr>				
				%ifvar idataType equals('field')%
					%loop fieldDataList -$index%
						<td>
							%ifvar $index equals('0')%
								<script language="javascript">
									var listDepth = %value listDepth%;
									
									if (listDepth > 0) {
										for (i = 0; i < (listDepth * 2); i += 1) {
											document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
										}
									}
								</script>
							%endifvar%
							%value fieldDataList%
						</td>
					%endloop%
				%else%
					%ifvar idataType equals('emptylist')%
						<!-- Record를 구분하기 위해서 빈 줄을 하나 추가한다. -->
						<td class="evenrowdata" colspan="4"><font color="blue">Record Division</font></td>
					%else%
						%ifvar idataType equals('remaindata')%
							<!-- Schema Define에 정의된 데이터 이외에 추가로 데이터를 수신한 경우 -->
							<td colspan="4"><font color="red">Remain Data : %value remainData%</font></td>
						%else%
							<td class="subheading2" colspan="4">
								<script language="javascript">
									var listDepth = %value listDepth% - 1;
									
									if (listDepth > 0) {
										for (i = 0; i < (listDepth * 2); i += 1) {
											document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
										}
									}
								</script>
								%value listName% Array Data (%value listCountDesc%)
							</td>
						%endifvar%
					%endifvar%
				%endifvar%
				</tr>
			%endloop%
			%else%
			%ifvar schemaDefType equals('ER')%
			<!-- 전문 수신 시 Endian 변환이 필요한 경우 -->
			<tr>
				<td class="heading" colspan="4">%value docName% 전문 파싱</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Field Length</td>
				<td>Field Value</td>
			</tr>
			%loop DocDataList%
				<tr>				
				%ifvar idataType equals('field')%
					%loop fieldDataList -$index%
						<td>
							%ifvar $index equals('0')%
								<script language="javascript">
									var listDepth = %value listDepth%;
									
									if (listDepth > 0) {
										for (i = 0; i < (listDepth * 2); i += 1) {
											document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
										}
									}
								</script>
							%endifvar%
							%value fieldDataList%
						</td>
					%endloop%
				%else%
					%ifvar idataType equals('emptylist')%
						<!-- Record를 구분하기 위해서 빈 줄을 하나 추가한다. -->
						<td class="evenrowdata" colspan="4"><font color="blue">Record Division</font></td>
					%else%
						%ifvar idataType equals('remaindata')%
							<!-- Schema Define에 정의된 데이터 이외에 추가로 데이터를 수신한 경우 -->
							<td colspan="4"><font color="red">Remain Data : %value remainData%</font></td>
						%else%
							<td class="subheading2" colspan="4">
								<script language="javascript">
									var listDepth = %value listDepth% - 1;
									
									if (listDepth > 0) {
										for (i = 0; i < (listDepth * 2); i += 1) {
											document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
										}
									}
								</script>
								%value listName% Array Data (%value listCountDesc%)
							</td>
						%endifvar%
					%endifvar%
				%endifvar%
				</tr>
			%endloop%
			%else%
			%ifvar schemaDefType equals('ES')%
			<!-- 전문 송신 시 Endian 변환이 필요한 경우 -->
			<tr>
				<td class="heading" colspan="8">%value docName% 전문 파싱</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Field Length</td>
				<td>Field Value</td>
			</tr>
			%loop DocDataList%
				<tr>				
				%ifvar idataType equals('field')%
					%loop fieldDataList -$index%
						<td>
							%ifvar $index equals('0')%
								<script language="javascript">
									var listDepth = %value listDepth%;
									
									if (listDepth > 0) {
										for (i = 0; i < (listDepth * 2); i += 1) {
											document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
										}
									}
								</script>
							%endifvar%
							%value fieldDataList%
						</td>
					%endloop%
				%else%
					%ifvar idataType equals('emptylist')%
						<!-- Record를 구분하기 위해서 빈 줄을 하나 추가한다. -->
						<td class="evenrowdata" colspan="4"><font color="blue">Record Division</font></td>
					%else%
						%ifvar idataType equals('remaindata')%
							<!-- Schema Define에 정의된 데이터 이외에 추가로 데이터를 수신한 경우 -->
							<td colspan="4"><font color="red">Remain Data : %value remainData%</font></td>
						%else%
							<td class="subheading2" colspan="4">
								<script language="javascript">
									var listDepth = %value listDepth% - 1;
									
									if (listDepth > 0) {
										for (i = 0; i < (listDepth * 2); i += 1) {
											document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
										}
									}
								</script>
								%value listName% Array Data (%value listCountDesc%)
							</td>
						%endifvar%
					%endifvar%
				%endifvar%
				</tr>
			%endloop%
			%else%
			%ifvar schemaDefType equals('EJ')%
			<!-- Endian 변환이 필요없으면서 Socket To REST API 방식, REST API To Socket 방식, Socket To Socket 방식이면서 Source, Target 포맷이 서로 다른 경우 -->
			<tr>
				<td class="heading" colspan="5">%value docName% 전문 파싱</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Field Length</td>
				<td>Field Type</td>
				<td>Field Value</td>
			</tr>
			%loop DocDataList%
				<tr>				
				%ifvar idataType equals('field')%
					%loop fieldDataList -$index%
						<td>
							%ifvar $index equals('0')%
								<script language="javascript">
									var listDepth = %value listDepth%;
									
									if (listDepth > 0) {
										for (i = 0; i < (listDepth * 2); i += 1) {
											document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
										}
									}
								</script>
							%endifvar%
							
							%ifvar fieldDataList equals('$FIELD_NA$')%
								<!-- Socket Schema Define에는 존재하지 않는 필드인 경우 -->
								<img src="%value ../../designPath%icons/delete.png" alt="non-existent field" border="0">
							%else%								
								%value fieldDataList%
							%endifvar%
						</td>
					%endloop%
				%else%
					%ifvar idataType equals('group')%
						<td class="subheading2" colspan="5">
							<script language="javascript">
								var listDepth = %value listDepth% - 1;
								
								if (listDepth > 0) {
									for (i = 0; i < (listDepth * 2); i += 1) {
										document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
									}
								}
							</script>
							%value groupName% Group Data
						</td>
					%else%
						%ifvar idataType equals('emptylist')%
							<!-- Record를 구분하기 위해서 빈 줄을 하나 추가한다. -->
							<td class="evenrowdata" colspan="5"><font color="blue">Record Division</font></td>
						%else%
							%ifvar idataType equals('remaindata')%
								<!-- Schema Define에 정의된 데이터 이외에 추가로 데이터를 수신한 경우 -->
								<td colspan="5"><font color="red">Remain Data : %value remainData%</font></td>
							%else%
								<td class="subheading2" colspan="5">
									<script language="javascript">
										var listDepth = %value listDepth% - 1;
										
										if (listDepth > 0) {
											for (i = 0; i < (listDepth * 2); i += 1) {
												document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
											}
										}
									</script>
									%value listName% Array Data (%value listCountDesc%)
								</td>
							%endifvar%
						%endifvar%
					%endifvar%
				%endifvar%
				</tr>
			%endloop%
			%endifvar%
			%endifvar%
			%endifvar%
			%endifvar%
		</table>
		%endifvar%

	</body>
</html>

%endinvoke%