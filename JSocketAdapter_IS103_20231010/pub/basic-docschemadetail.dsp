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
						Basic Info &gt;
						Interface Doc &gt;
						Doc Schema Details
					</td>
			</tr>
		</table>
		
		%ifvar CommSchemaDefList -notempty%
		<table class="tableForm" width="100%">
			%ifvar schemaDefType equals('EN')%
			<!-- Endian 변환이 필요 없는 일반적인 경우 -->
			<tr>
				<td class="heading" colspan="5">%value docName% 전문 공통정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Field Length</td>
				<td>Padding Char</td>
				<td>Padding Type</td>
			</tr>
			%loop CommSchemaDefList%
				<tr>				
				%ifvar idataType equals('field')%
					%loop schemaList -$index%
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
							%value schemaList%
						</td>
					%endloop%
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
						%value listName% Array Schema (%value listCountDesc%)
					</td>
				%endifvar%
				</tr>
			%endloop%
			%else%
			%ifvar schemaDefType equals('ER')%
			<!-- 전문 수신 시 Endian 변환이 필요한 경우 -->
			<tr>
				<td class="heading" colspan="5">%value docName% 전문 공통정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Data Type</td>
				<td>Field Length</td>
				<td>Array Count</td>
			</tr>
			%loop CommSchemaDefList%
				<tr>				
				%ifvar idataType equals('field')%
					%loop schemaList -$index%
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
							%value schemaList%
						</td>
					%endloop%
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
						%value listName% Array Schema (%value listCountDesc%)
					</td>
				%endifvar%
				</tr>
			%endloop%
			%else%
			%ifvar schemaDefType equals('ES')%
			<!-- 전문 송신 시 Endian 변환이 필요한 경우 -->
			<tr>
				<td class="heading" colspan="8">%value docName% 전문 공통정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Field Length</td>
				<td>Padding Char</td>
				<td>Padding Type</td>
				<td>Data Type</td>
				<td>Field Length</td>
				<td>Array Count</td>
			</tr>
			%loop CommSchemaDefList%
				<tr>				
				%ifvar idataType equals('field')%
					%loop schemaList -$index%
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
							%value schemaList%
						</td>
					%endloop%
				%else%
					<td class="subheading2" colspan="8">
						<script language="javascript">
							var listDepth = %value listDepth% - 1;
							
							if (listDepth > 0) {
								for (i = 0; i < (listDepth * 2); i += 1) {
									document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
								}
							}
						</script>
						%value listName% Array Schema (%value listCountDesc%)
					</td>
				%endifvar%
				</tr>
			%endloop%
			%else%
			%ifvar schemaDefType equals('EJ')%
			<!-- Endian 변환이 필요없으면서 Socket To REST API 방식, REST API To Socket 방식, Socket To Socket 방식이면서 Source, Target 포맷이 서로 다른 경우 -->
			<tr>
				<td class="heading" colspan="8">%value docName% 전문 공통정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Field Length</td>
				<td>Padding Char</td>
				<td>Padding Type</td>
				<td>Data Type</td>
				<td>Length Calculation Start</td>
				<td>Field Type</td>
			</tr>
			%loop CommSchemaDefList%
				<tr>				
				%ifvar idataType equals('field')%
					%loop schemaList -$index%
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
							%value schemaList%
						</td>
					%endloop%
				%else%
				%ifvar idataType equals('group')%
					<td class="subheading2" colspan="8">
						<script language="javascript">
							var listDepth = %value listDepth% - 1;
							
							if (listDepth > 0) {
								for (i = 0; i < (listDepth * 2); i += 1) {
									document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
								}
							}
						</script>
						%value groupName% Group Schema
					</td>
				%else%
					<td class="subheading2" colspan="8">
						<script language="javascript">
							var listDepth = %value listDepth% - 1;
							
							if (listDepth > 0) {
								for (i = 0; i < (listDepth * 2); i += 1) {
									document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
								}
							}
						</script>
						%value listName% Array Schema (%value listCountDesc%)
					</td>
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
		
		%ifvar SchemaDefList -notempty%
		<table class="tableForm" width="100%">
			%ifvar schemaDefType equals('EN')%
			<!-- Endian 변환이 필요 없는 일반적인 경우 -->
			<tr>
				<td class="heading" colspan="5">%value docName% 전문 업무정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Field Length</td>
				<td>Padding Char</td>
				<td>Padding Type</td>
			</tr>
			%loop SchemaDefList%
				<tr>				
				%ifvar idataType equals('field')%
					%loop schemaList -$index%
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
							%value schemaList%
						</td>
					%endloop%
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
						%value listName% Array Schema (%value listCountDesc%)
					</td>
				%endifvar%
				</tr>
			%endloop%
			%else%
			%ifvar schemaDefType equals('ER')%
			<!-- 전문 수신 시 Endian 변환이 필요한 경우 -->
			<tr>
				<td class="heading" colspan="5">%value docName% 전문 업무정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Data Type</td>
				<td>Field Length</td>
				<td>Array Count</td>
			</tr>
			%loop SchemaDefList%
				<tr>				
				%ifvar idataType equals('field')%
					%loop schemaList -$index%
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
							%value schemaList%
						</td>
					%endloop%
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
						%value listName% Array Schema (%value listCountDesc%)
					</td>
				%endifvar%
				</tr>
			%endloop%
			%else%
			%ifvar schemaDefType equals('ES')%
			<!-- 전문 송신 시 Endian 변환이 필요한 경우 -->
			<tr>
				<td class="heading" colspan="8">%value docName% 전문 업무정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Field Length</td>
				<td>Padding Char</td>
				<td>Padding Type</td>
				<td>Data Type</td>
				<td>Field Length</td>
				<td>Array Count</td>
			</tr>
			%loop SchemaDefList%
				<tr>				
				%ifvar idataType equals('field')%
					%loop schemaList -$index%
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
							%value schemaList%
						</td>
					%endloop%
				%else%
					<td class="subheading2" colspan="8">
						<script language="javascript">
							var listDepth = %value listDepth% - 1;
							
							if (listDepth > 0) {
								for (i = 0; i < (listDepth * 2); i += 1) {
									document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
								}
							}
						</script>
						%value listName% Array Schema (%value listCountDesc%)
					</td>
				%endifvar%
				</tr>
			%endloop%
			%else%
			%ifvar schemaDefType equals('EJ')%
			<!-- Endian 변환이 필요없으면서 Socket To REST API 방식, REST API To Socket 방식, Socket To Socket 방식이면서 Source, Target 포맷이 서로 다른 경우 -->
			<tr>
				<td class="heading" colspan="8">%value docName% 전문 업무정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>Field Name</td>
				<td>Field Desc</td>
				<td>Field Length</td>
				<td>Padding Char</td>
				<td>Padding Type</td>
				<td>Data Type</td>
				<td>Length Calculation Start</td>
				<td>Field Type</td>
			</tr>
			%loop SchemaDefList%
				<tr>				
				%ifvar idataType equals('field')%
					%loop schemaList -$index%
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
							%value schemaList%
						</td>
					%endloop%
				%else%
				%ifvar idataType equals('group')%
					<td class="subheading2" colspan="8">
						<script language="javascript">
							var listDepth = %value listDepth% - 1;
							
							if (listDepth > 0) {
								for (i = 0; i < (listDepth * 2); i += 1) {
									document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
								}
							}
						</script>
						%value groupName% Group Schema
					</td>
				%else%											
					<td class="subheading2" colspan="8">
						<script language="javascript">
							var listDepth = %value listDepth% - 1;
							
							if (listDepth > 0) {
								for (i = 0; i < (listDepth * 2); i += 1) {
									document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
								}
							}
						</script>
						%value listName% Array Schema (%value listCountDesc%)
					</td>
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