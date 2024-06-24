%invoke JSocketAdapter.ADMIN:adminOnlineErrorHistory%

<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
<SCRIPT SRC="%value designPath%webMethods.js.txt"></SCRIPT>
<script language="javascript">
	function doAction(todo, hname){
		var frm = document.pform;
		frm.todo.value = todo;
		if(hname != '')
			frm.headerName.value = hname;
		if(todo == 'delete'){
			if(confirm("Do you really want to delete Info of  " + hname)){
				frm.submit();
			}
		} else if(todo == 'deleteAll'){
			if(confirm("Do you really want to delete all Info?")){
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
		<input type="hidden" name="todo" value="search">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		<input type="hidden" name="systemName" value="%value systemName%">
	</form>
	<script langauge='javascript'>
		document.dform.submit();
	</script>
%endifvar%

%ifvar hisError/error -notempty%
	<div class="message">%value hisError/error%</div>
%endifvar%

<form name="pform" method="post" target="_self">
	<input type="hidden" name="todo" value="">
	<input type="hidden" name="systemName" value="%value systemName%">
	<input type="hidden" name="headerName" value="">
	<input type="hidden" name="alertMsg" value="%value alertMsg%">

<table width="100%">
	<tr>
		<td class="menusection-Settings" colspan="2">
			JSocketAdapter Package Home &gt;
			%value systemName% Online Client &gt;
			Online Error History
		</td>
	</tr>
</table>
		
      <table class="tableView" width=100%>
        <tr><td class="heading" colspan=5>%value systemName% Asynch Online Interface Error History</td></tr>
        <tr class="subheading2">
          <td>Saved Time</td>
          <td>ESB Header Name</td>
          <td>ESB Transaction ID</td>
          <td>Error Message</td>
          <td>Delete</td>
        </tr>
				%ifvar -notempty OnlineErrorHistory%
        %loop OnlineErrorHistory%
				<tr>
					<td>%value savedTime%</td>
					<td>%value headerName%</td>
					<td>%value transactionID%</td>
					<td>%value errorMessage%</td>
					<td class="evenrowdata"><a href="javascript:doAction('delete', '%value headerName%')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a></td>
				</tr>
				%endloop%
				<tr>
					<td class="action" colspan="5"><input type="button" name="SUBMIT" value="Delete All"  onclick="return doAction('deleteAll', '')"></input>
					</td>
				</tr>
			
			%else%
			<tr><td colspan=5>No asynch online errors are currently occurred.</td></tr>
      %endif%
    </table>
</body>
</html>

%endinvoke%