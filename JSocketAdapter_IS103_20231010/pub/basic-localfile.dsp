%invoke JSocketAdapter.ADMIN:adminLocalFile%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(todo, pfilepath){
				var frm = document.pform;
				frm.todo.value = todo;
				
				if (pfilepath != '') {
					frm.filePath.value = pfilepath;
				}
				
				if (todo == 'add' || todo == 'update') {
					// var filePath = frm.filePath.value; ==> '\' 가 포함된 경우에 변수에 담아서 처리할 경우 스크립트 오류 발생
					
					if (frm.filePath.value.indexOf('\\') >= 0) {
						alert("디렉토리 구분자에 '\\' 를 사용 시\n자바스크립트 오류가 발생할 수 있습니다.\n'\\' 를 '/' 로 변환하여 저장합니다.");
						frm.filePath.value = frm.filePath.value.replace(/\\/g, '/'); // 모든 '\' 를 '/' 로 변환
					}
					
					var backupYN = frm.backupYN.value;
					var backupPath = frm.backupPath.value;
					
					if (backupYN == 'Yes') {
						if (backupPath == '') {
							alert("Backup 후 삭제하는 경우에는 Backup Path를 입력해야 합니다.");
							return;
						}
					}
					
					frm.submit();
				} else if(todo == 'delete') {
					if (confirm("Do you really want to delete config of  " + pfilepath)) {
						frm.submit();
					}
				} else {
					frm.submit();
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

		%ifvar changed equals('true')%
			<form name="dform" method="post">
				<input type="hidden" name="alertMsg" value="%value alertMsg%">
			</form>
			<script langauge='javascript'>
				document.dform.submit();
			</script>
		%endifvar%
		
		%ifvar requireMsg -notempty%
			<div class="message">%value requireMsg%<br>JSocketAdapter Package Home > Basic Info > Local File Delete Schedule 메뉴에서 파일삭제 Service에 대해서 Schedule 등록을 해야 합니다.</div>
		%else%
			<div class="message">JSocketAdapter Package Home > Basic Info > Local File Delete Schedule 메뉴에서 파일삭제 Service에 대해서 Schedule 등록을 해야 합니다.</div>
		%endifvar%
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">
		<table width="100%">
			<tr>
				%ifvar todo equals('create')%
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Basic Info &gt;
						Delete Local File &gt;
						Create Local File Delete Path
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						  Delete Local File &gt;
							Edit Local File Delete Path
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							Basic Info &gt;
						  Delete Local File
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		<input type="hidden" name="todo" value="">
		<input type="hidden" name="oldFilePath" value="%value filePath%">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">

		%ifvar todo -notempty%
			<ul class="listitems">
				<li class="listitem"><a href="basic-localfile.dsp">Return to Delete Local File Information</a></li>
			</ul>
		%else%
			<input type="hidden" name="filePath" value="">		
				<ul class="listitems">
					<li class="listitem"><a href="javascript:doAction('create', '')">Create New Local File Delete Path</a></li>	
				</ul>
		%endifvar%
		
		<table class="tableForm" width="100%">	
			%ifvar todo equals('create')%
				<tr>
					<td class="heading" colspan="2">Local File Path Properties For Deletion</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Local File Path</td>
					<td class="evenrow-l" width="70%"><input type="text" name="filePath" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Remain Days</td>
					<td class="evenrow-l" width="70%"><input type="text" name="remainDays" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Sub-Directory Delete YN</td>
					<td class="evenrow-l" width="70%">
						<select name="dirDeleteYN" style="width:90">
							<option value="Yes">Yes</option>
							<option value="No">No</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Shared Directory YN</td>
					<td class="evenrow-l" width="70%">
						<select name="sharedDirYN" style="width:90">								
							<option value="No">No</option>
							<option value="Yes">Yes</option>
						</select> (Shared directory in clustering environment)
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Description</td>
					<td class="evenrow-l" width="70%"><input type="text" name="description" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Backup YN</td>
					<td class="evenrow-l" width="70%">
						<select name="backupYN" style="width:90">								
							<option value="No">No</option>
							<option value="Yes">Yes</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Backup Path</td>
					<td class="evenrow-l" width="70%"><input type="text" name="backupPath" size="20" style="font-size:10pt;width:400"></td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Create File Delete Path"  onclick="return doAction('add', '')"></input>
					</td>
				</tr>
			%else%
				%ifvar todo equals('read')%
					<tr>
						<td class="heading" colspan="2">Local File Path Properties For Deletion</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Local File Path</td>
						<td class="evenrow-l" width="70%"><input type="text" name="filePath" value="%value filePath%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Remain Days</td>
						<td class="evenrow-l" width="70%"><input type="text" name="remainDays" value="%value remainDays%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Sub-Directory Delete YN</td>
						<td class="evenrow-l" width="70%">
							<select name="dirDeleteYN" style="width:90">
								<option value="Yes">Yes</option>
								<option value="No">No</option>
							</select>
							<script language="javascript">
								document.pform.dirDeleteYN.value = "%value dirDeleteYN%";
							</script>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Shared Directory YN</td>
						<td class="evenrow-l" width="70%">
							<select name="sharedDirYN" style="width:90">								
								<option value="No">No</option>
								<option value="Yes">Yes</option>
							</select> (Shared directory in clustering environment)
							<script language="javascript">
								document.pform.sharedDirYN.value = "%value sharedDirYN%";
							</script>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Description</td>
						<td class="evenrow-l" width="70%"><input type="text" name="description" value="%value description%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Backup YN</td>
						<td class="evenrow-l" width="70%">
							<select name="backupYN" style="width:90">								
								<option value="No">No</option>
								<option value="Yes">Yes</option>
							</select>
							<script language="javascript">
								document.pform.backupYN.value = "%value backupYN%";
							</script>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Backup Path</td>
						<td class="evenrow-l" width="70%"><input type="text" name="backupPath" value="%value backupPath%" size="20" style="font-size:10pt;width:400"></td>
					</tr>
					<tr>
						<td class="action" colspan="2">
							<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>
						</td>
					</tr>
				%else%
					<tr>
						<td class="heading" colspan=7>Local File Path Infomation For Deletion</td>
					</tr>
					<tr class="subheading2">
						<td>Local File Path</td>
						<td>Remain Days</td>
						<td>Sub-Directory Delete YN</td>
						<td>Shared Directory YN</td>
						<td>Description</td>
						<td>Edit</td>
						<td>Delete</td>
					</tr>
					
					%ifvar -notempty LocalFileConfig/Items%
						%loop LocalFileConfig/Items%
							<tr>
								<td>%value filePath%</td>
								<td>%value remainDays%</td>
								<td>%value dirDeleteYN%</td>
								<td>%value sharedDirYN%</td>
								<td>%value description%</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('read', '%value filePath%')"><img src="%value ../../designPath%icons/copy.gif" alt="Edit" border="0"></a>
								</td>
								<td class="evenrowdata">
									<a href="javascript:doAction('delete', '%value filePath%')"><img src="%value ../../designPath%icons/delete.png" alt="Delete" border="0"></a>
								</td>
							</tr>
						%endloop%
					%else%
						<tr><td colspan="7">No local file delete paths are currently registered.</td></tr>
      		%endif%												
				%endifvar%
			%endifvar%
		%endifvar%
		</table>
		</form>
	</body>
</html>

%endinvoke%