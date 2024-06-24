%invoke JSocketAdapter.ADMIN:adminBusinessInterfaceList%

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
						Business Name &gt;
						Business Doc List &gt;
						Doc Schema Details
					</td>
			</tr>
		</table>
		
		%ifvar CommSchemaDefList -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="5">전문 공통정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>필드명</td>
				<td>필드설명</td>
				<td>필드길이</td>
				<td>패딩문자</td>
				<td>패딩타입</td>
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
							var listDepth = %value listDepth%;
							
							for (i = 0; i < (listDepth * 2); i += 1) {
								document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
							}
						</script>
						%value listName% Array Schema
					</td>
				%endifvar%
				</tr>
			%endloop%
		</table>
		%endifvar%
		
		%ifvar SchemaDefList -notempty%
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="5">전문 업무정보부 Schema 정의</td>
			</tr>
			<tr class="subheading2">
				<td>필드명</td>
				<td>필드설명</td>
				<td>필드길이</td>
				<td>패딩문자</td>
				<td>패딩타입</td>
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
							var listDepth = %value listDepth%;
							
							for (i = 0; i < (listDepth * 2); i += 1) {
								document.write("<img src='%value ../../designPath%images/blank.gif' border='0'>");
							}
						</script>
						%value listName% Array Schema
					</td>
				%endifvar%
				</tr>
			%endloop%
		</table>
		%endifvar%

	</body>
</html>

%endinvoke%