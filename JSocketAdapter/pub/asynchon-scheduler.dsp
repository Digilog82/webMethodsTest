%invoke JSocketAdapter.ADMIN:adminOnlineCheckSchedule%

<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<SCRIPT SRC="%value designPath%webMethods.js.txt"></SCRIPT>
		<script language="javascript">
			function doAction(todo, pname){
				var frm = document.pform;
				frm.todo.value = todo;
				
				if(pname != '') {
					frm.service.value = pname;
				}
				
				if(todo == 'delete'){
					if(confirm("Do you really want to delete config of  " + pname)){
						frm.submit();
					}
				} else if (todo == 'add' || todo == 'update') {
					var type = frm.type.value;
					var scheNames = "";
					
					if (type == "complex") {
						scheNames = frm.complexSchedule.value;
					} else {
						scheNames = frm.intervalSchedule.value;
					}
					
					if (scheNames == "") {
						alert("Schedule Service를 선택하십시요!!!");
						return;
					}
					
					var scheList = scheNames.split('/');
					var oid = scheList[0];
					var service = scheList[1];
					frm.oid.value = oid;
					frm.service.value = service;
					frm.submit();
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
				
				var todo = frm.todo.value;
				
				if (todo == "create") {
					var businessName = frm.businessName.value;
					makeSocketName(businessName);
				} else if (todo == "read") {
					var businessName = frm.businessName.value;
					var socketName = frm.socketName.value;
					makeSocketName(businessName);
					
					// Socket Name Set.
					frm.socketName.value = socketName;
				}
			}
			
			function displaySchedule(type) {
				if (type == "complex") {
					document.all.complexSchedule.style.display="";
					document.all.intervalSchedule.style.display="none";
				} else {
					document.all.complexSchedule.style.display="none";
					document.all.intervalSchedule.style.display="";
				}
			}
			
			function makeSocketName(businessName) {
				var socketName = document.pform.socketName;
								
				for (var i=0; i < document.pform.length; i++) {
					if (document.pform.elements[i].name == businessName) {
						var socketNames = document.pform.elements[i].value;
						var tockens = socketNames.split("/");
					  
						// 기존의 Option 삭제
						while (socketName.options.length > 0) {
							socketName.options.remove(0);
						}
					
						// 해당 Business Name에 속한 Socket Name Option 추가
						for (var i = 0; i < tockens.length; i++) {
							socketName.options[i] = new Option(tockens[i], tockens[i]);
						}
					
						break;
					}
				}
			}
		</script>
	</head>

	<body onload="javascript:alertMsg()">		
	
		%ifvar changed equals('true')%
			<form name="dform" method="post">
				<input type="hidden" name="alertMsg" value="%value alertMsg%">
				<input type="hidden" name="systemName" value="%value systemName%">
			</form>
			<script langauge='javascript'>
				document.dform.submit();
			</script>
		%endifvar%
		
		<div class="message">IS Administrator > Server > Scheduler 메뉴에서 등록한 %value systemName%의 Online Check Schedules를 등록, 관리하는 메뉴입니다.</div>
		
		%ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">

		<table width="100%">
			<tr>
				%ifvar todo equals('create')%
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						%value systemName% Online Client &gt;
						Online Check Schedule &gt;
						Register Online Check Schedule
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							%value systemName% Online Client &gt;
							Online Check Schedule &gt;
							Edit Online Check Schedule
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							%value systemName% Online Client &gt;
							Online Check Schedule
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		
		<input type="hidden" name="todo" value="%value todo%">
		<input type="hidden" name="oldService" value="%value service%">
		<input type="hidden" name="systemName" value="%value systemName%">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		
		%loop socketNameList%		
			<input type="hidden" name="%value businessName%" value="%value socketName%">
		%endloop%
		
		%ifvar todo -notempty%
			<ul class="listitems">
				<li class="listitem"><a href="asynchon-scheduler.dsp?systemName=%value systemName%">Return to Online Check Schedule Information</a></li>
			</ul>
		%else%
			<input type="hidden" name="service" value="">		
				<ul class="listitems">
					<li class="listitem"><a href="javascript:doAction('create', '')">Register New Online Check Schedule</a></li>	
				</ul>
		%endifvar%
		
		%ifvar todo equals('create')%
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Online Check Schedule Properties</td>
				</tr>
				<tr>
					<tr>
						<td class="evenrow" width="30%">Schedule Type</td>
						<td class="evenrow-l" width="70%">
							<select name="type" style="width:150" onchange="javascript:displaySchedule(this.value)">
								<option value="complex">Complex Repeating</option>
								<option value="repeat">Simple Interval Repeating</option>								
							</select>
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Schedule Service</td>
						<td class="evenrow-l" width="70%">
							<select name="complexSchedule" id="complexSchedule">
								%loop extTasks%
									<option value="%value oid%/%value service%">%value service%</option>
								%endloop%
							</select>
							<select name="intervalSchedule" id="intervalSchedule" style="display:none">
								%loop tasks%
									<option value="%value oid%/%value service%">%value service%</option>
								%endloop%
							</select>
							<input type="hidden" name="oid" value="">
							<input type="hidden" name="service" value="">
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Provider System Name</td>
						<td class="evenrow-l" width="70%">%value systemName%</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Business Name</td>
						<td class="evenrow-l" width="70%">
							<select name="businessName" style="width:150" onchange="javascript:makeSocketName(this.value)">
								%loop businessNameList%
									<option value="%value businessNameList%">%value businessNameList%</option>
								%endloop%
							</select>						
						</td>
					</tr>
					<tr>
						<td class="evenrow" width="30%">Online Check Socket Name</td>
						<td class="evenrow-l" width="70%">
							<select name="socketName" style="width:150">
							</select>						
						</td>
					</tr>
					<tr>
						<td class="action" colspan="2">
							<input type="button" name="SUBMIT" value="Register Online Check Schedule"  onclick="return doAction('add', '')"></input>
						</td>
					</tr>
				</tr>
			</table>
		%else%
				%ifvar todo equals('read')%
					<table class="tableForm" width="100%">
						<tr>
							<td class="heading" colspan="2">Online Check Schedule Properties</td>
						</tr>
						<tr>
							<tr>
								<td class="evenrow" width="30%">Schedule Type</td>
								<td class="evenrow-l" width="70%">
									<select name="type" style="width:150" onchange="javascript:displaySchedule(this.value)">
										<option value="complex">Complex Repeating</option>
										<option value="repeat">Simple Interval Repeating</option>								
									</select>
									<script language="javascript">
										document.pform.type.value = "%value type%";
									</script>
								</td>
							</tr>
							<tr>
								<td class="evenrow" width="30%">Schedule Service</td>
								<td class="evenrow-l" width="70%">
									%ifvar type equals('complex')%
										<select name="complexSchedule" id="complexSchedule">
											%loop extTasks%
												<option value="%value oid%/%value service%">%value service%</option>
											%endloop%
										</select>
										<script language="javascript">
											document.pform.complexSchedule.value = "%value oid%/%value service%";
										</script>
										<select name="intervalSchedule" id="intervalSchedule" style="display:none">
											%loop tasks%
												<option value="%value oid%/%value service%">%value service%</option>
											%endloop%
										</select>
									%else%
										<select name="complexSchedule" id="complexSchedule" style="display:none">
											%loop extTasks%
												<option value="%value oid%/%value service%">%value service%</option>
											%endloop%
										</select>										
										<select name="intervalSchedule" id="intervalSchedule">
											%loop tasks%
												<option value="%value oid%/%value service%">%value service%</option>
											%endloop%
										</select>
										<script language="javascript">
											document.pform.intervalSchedule.value = "%value oid%/%value service%";
										</script>
									%endifvar%
									<input type="hidden" name="oid" value="%value oid%">
									<input type="hidden" name="service" value="%value service%">
								</td>
							</tr>
							<tr>
								<td class="evenrow" width="30%">Provider System Name</td>
								<td class="evenrow-l" width="70%">%value systemName%</td>
							</tr>
							<tr>
								<td class="evenrow" width="30%">Business Name</td>
								<td class="evenrow-l" width="70%">
									<select name="businessName" style="width:150" onchange="javascript:makeSocketName(this.value)">
										%loop businessNameList%
											<option value="%value businessNameList%">%value businessNameList%</option>
										%endloop%
									</select>						
									<script language="javascript">
										document.pform.businessName.value = "%value businessName%";
									</script>
								</td>
							</tr>
							<tr>
								<td class="evenrow" width="30%">Online Check Socket Name</td>
								<td class="evenrow-l" width="70%">
									<select name="socketName" style="width:150">
										<option value="%value socketName%">%value socketName%</option>
									</select>						
								</td>
							</tr>
							<tr>
								<td class="action" colspan="2">
									<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>
								</td>
							</tr>
						</tr>
					</table>
				%else%
        <table class="tableView" width=100%>
          <tr><td class="heading" colspan=9>One-Time and Simple Interval Tasks</td></tr>
          <tr class="subheading2">
            <td>Service</td>
            <td>Description</td>
            <td>Target</td>                        
            <td>Interval (sec)</td>
            <td>Status</td>
            <td>Business Name</td>
            <td>Socket Name</td>
            <td>Edit</td>
						<td>Delete</td>
          </tr>
          
          %ifvar -notempty tasks%
              <script>resetRows();</script>
          	%loop tasks%
          		<tr>
          			<td>%value name%</td>
          			<td>%value description%</td>
          			<td>
              		%ifvar target equals('$all')%
	              		<font color="red">All cluster nodes</font>
	          			%else%
	          	 			%ifvar target equals('$any')%
	              			<font color="red">Any cluster node</font>
		         				%else%
                  		<font color="red">%value target%</font>                                    
    	      				%endif%
			  					%endif% 
			     	     </td>
			     	     <td>
              	 	%ifvar interval equals(0)%once%else%%value interval decimal(-3,1)% %endif%
              	 </td>
								 <td>
								   %ifvar schedState equals('expired')%
                     <font color="red">Expired</font>
		    					 %else%
                     %ifvar execState equals('suspended')%
                       <font color="red">Suspended</font>
                     %else%
                       <img src="%value ../designPath%images/green_check.png" border=0>%ifvar execState equals('running')%Running%else%Active%endif%
			  			       %endif%
                   %endif%
								 </td>
	    		       <td>%value businessName%</td>
	    		       <td>%value socketName%</td>
	    		       <td><a href="javascript:doAction('read', '%value service%')"><img src="%value ../designPath%icons/copy.gif" alt="Edit" border="0"></a></td>
	    		       <td><a href="javascript:doAction('delete', '%value service%')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a></td>
          		</tr>
              <script>swapRows();</script>
          	%endloop%
          %else%
           %ifvar error%
           <tr><td colspan=9>%value error%</td></tr>
           %else%
             <tr><td colspan=9>No tasks are currently registered</td></tr>
           %endif%
          %endif%
          
     			<tr><td class="space" colspan="9">&nbsp;</td></tr>
					<tr><td class="heading" colspan=9>Complex Repeating Tasks</td></tr>
          <tr class="subheading2">
            <td>Service</td>
            <td>Description</td>
            <td>Target</td>
            <td>Interval Masks</td>
            <td>Status</td>
            <td>Business Name</td>
            <td>Socket Name</td>
            <td>Edit</td>
						<td>Delete</td>
          </tr>
          
          %ifvar -notempty extTasks%
              <script>resetRows();</script>
          	%loop extTasks%
          		<tr>
          			<td>%value name%</td>
          			<td>%value description%</td>
          			<td>
              		%ifvar target equals('$all')%
	              		<font color="red">All Servers</font>
	          			%else%
	          	 			%ifvar target equals('$any')%
	              			<font color="red">Any Server</font>
		         				%else%
    	          			<font color="red">%value target%</font>
    	      				%endif%
			  					%endif%
			  				</td>
	      				<td class="rowdata" colspan="1" style="padding: 0px;">
									<table width="100%" class="tableInline" cellspacing="1" style="background-color: #ffffff">
										<tr>
											<td>Months</td>
											<td>    			  					
		    								%ifvar monthMaskAlt%
		    									%value monthMaskAlt%
		    								%else%
		    									January..December
		    								%endif%
											</td>
										</tr>
										<tr>
											<td>Days</td>
											<td>    			  					
		    								%ifvar dayOfMonthMaskAlt%
		    									%value dayOfMonthMaskAlt%
		    								%else%
		    									1..31
		    								%endif%
											</td>
										</tr>
										<tr>
											<td>Days&nbsp;of Week</td>
											<td>    			  					
		    								%ifvar dayOfWeekMaskAlt%
		    									%value dayOfWeekMaskAlt%
		    								%else%
		    									Sunday..Saturday
		    								%endif%
											</td>
										</tr>
										<tr>
											<td>Hours</td>
											<td>    			  					
		    								%ifvar hourMaskAlt%
		    									%value hourMaskAlt%
		    								%else%
		    									0..23
		    								%endif%
											</td>
										</tr>
										<tr>
											<td>Minutes</td>
											<td>    			  					
		    								%ifvar minuteMaskAlt%
		    									%value minuteMaskAlt%
		    								%else%
		    									0..59
		    								%endif%
											</td>
										</tr>
									</table>
								</td>
								<td>
								   %ifvar schedState equals('expired')%
                     <font color="red">Expired</font>
		    					 %else%
                     %ifvar execState equals('suspended')%
                       <font color="red">Suspended</font>
                     %else%
                       <img src="%value ../designPath%images/green_check.png" border=0>%ifvar execState equals('running')%Running%else%Active%endif%
			  			       %endif%
                   %endif%
								 </td>
	    		      <td>%value businessName%</td>
	    		      <td>%value socketName%</td>
	    		      <td><a href="javascript:doAction('read', '%value service%')"><img src="%value ../designPath%icons/copy.gif" alt="Edit" border="0"></a></td>
	    		      <td><a href="javascript:doAction('delete', '%value service%')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a></td>
          		</tr>
              <script>swapRows();</script>
          	%endloop%
          %else%
           %ifvar error%
           	 <tr><td colspan=9>%value error%</td></tr>
           %else%
             <tr><td colspan=9>No tasks are currently registered</td></tr>
           %endif%
          %endif%
    		</table>
			%endifvar%
		%endifvar%
	</form>
	</body>
</html>

%endinvoke%