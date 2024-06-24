%invoke JSocketAdapter.ADMIN:adminOnlineTrigger%

<html>
<head>
  <meta content="no-cache" http-equiv="Pragma">
  <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  <meta content="-1" http-equiv="Expires">
  <title>Server &gt; Statistics</title>
  <link href="%value designPath%webMethods.css" type="text/css" rel="stylesheet">
  <script src="%value designPath%webMethods.js.txt"></script>
  
  <script language="JavaScript">
  
    var messageFlag = false;
    
    function getMessageFlag() { 
      return messageFlag;
    }
    
    function setMessageFlag(value) {
      messageFlag = value;
    }
    
    function this_writeMessage(value) {
    
      if (!messageFlag) // this will avoid more than one error message at a time.
        writeMessage(value);
    }
    
    function showCluster() {
      prop = "%sysvar property('watt.server.cluster.aliasList')%";
      if (prop == null || prop.length < 1)
        return false;
      else
        return true;
    }
    
    function doAction(todo, pname){
			var frm = document.pform;
			frm.todo.value = todo;
			
			if(pname != '') {
				frm.trgName.value = pname;
			}
			
			if(todo == 'delete'){
				if(confirm("Do you really want to delete config of  " + pname)){
					frm.submit();
				}
			} else if (todo == 'add' || todo == 'update') {
				var type = frm.type.value;
				
				if (type == "JMS") {
					frm.trgName.value = frm.jmsTrigger.value;
				} else {
					frm.trgName.value = frm.mesTrigger.value;
				}
				
				if (frm.trgName.value == "") {
					alert("Trigger를 선택하십시요!!!");
					return;
				}
				
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
		}
			
		function displayTrigger(type) {
			if (type == "JMS") {
				document.all.jmsTrigger.style.display="";
				document.all.mesTrigger.style.display="none";
			} else {
				document.all.jmsTrigger.style.display="none";
				document.all.mesTrigger.style.display="";
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
		
		<div class="message">Designer에서 생성한 %value systemName%의 Online Triggers를 등록, 관리하는 메뉴입니다. Trigger는 Unlock 상태이어야 합니다.</div>
		
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
						Trigger &gt;
						Register Online Trigger
					</td>
				%else%
					%ifvar todo equals('read')%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							%value systemName% Online Client &gt;
							Trigger &gt;
							Edit Online Trigger
						</td>
					%else%
						<td class="menusection-Settings" colspan="2">
							JSocketAdapter Package Home &gt;
							%value systemName% Online Client &gt;
							Trigger
						</td>
					%endifvar%
				%endifvar%
			</tr>
		</table>
		
		<input type="hidden" name="todo" value="%value todo%">
		<input type="hidden" name="oldTrgName" value="%value trgName%">
		<input type="hidden" name="systemName" value="%value systemName%">
		<input type="hidden" name="remoteInvoke" value="true">
		<input type="hidden" name="alertMsg" value="%value alertMsg%">
		
		%ifvar todo -notempty%
			<ul class="listitems">
				<li class="listitem"><a href="asynchon-trigger.dsp?systemName=%value systemName%">Return to Online Trigger Information</a></li>
			</ul>
		%else%
			<input type="hidden" name="trgName" value="">		
				<ul class="listitems">
					<li class="listitem"><a href="javascript:doAction('create', '')">Register New Online Trigger</a></li>	
				</ul>
		%endifvar%
		
		%ifvar todo equals('create')%
			<table class="tableForm" width="100%">
				<tr>
					<td class="heading" colspan="2">Online Trigger Properties</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Trigger Type</td>
					<td class="evenrow-l" width="70%">
						<select name="type" style="width:190" onchange="javascript:displayTrigger(this.value)">
							<option value="JMS">JMS Trigger</option>
							<option value="MES">webMethods Messaging Trigger</option>								
						</select>
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Trigger Name</td>
					<td class="evenrow-l" width="70%">
						<select name="jmsTrigger" id="jmsTrigger">
							%loop triggerDataList%
								<option value="%value node_nsName%">%value node_nsName%</option>
							%endloop%
						</select>
						<select name="mesTrigger" id="mesTrigger" style="display:none">
							%loop triggers%
								<option value="%value name%">%value name%</option>
							%endloop%
						</select>
						<input type="hidden" name="trgName" value="">
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Provider System Name</td>
					<td class="evenrow-l" width="70%">%value systemName%</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%">Business Name</td>
					<td class="evenrow-l" width="70%">
						<select name="businessName" style="width:190">
							%loop onlineBusinessNameList%
								<option value="%value onlineBusinessNameList%">%value onlineBusinessNameList%</option>
							%endloop%
						</select>						
					</td>
				</tr>
				<tr>
					<td class="action" colspan="2">
						<input type="button" name="SUBMIT" value="Register Online Trigger"  onclick="return doAction('add', '')"></input>
					</td>
				</tr>
			</table>
		%else%
				%ifvar todo equals('read')%
					<table class="tableForm" width="100%">
						<tr>
							<td class="heading" colspan="2">Online Trigger Properties</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Trigger Type</td>
							<td class="evenrow-l" width="70%">
								<select name="type" style="width:190" onchange="javascript:displayTrigger(this.value)">
									<option value="JMS">JMS Trigger</option>
									<option value="MES">webMethods Messaging Trigger</option>								
								</select>
								<script language="javascript">
									document.pform.type.value = "%value type%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Trigger Name</td>
							<td class="evenrow-l" width="70%">
								%ifvar type equals('JMS')%
									<select name="jmsTrigger" id="jmsTrigger">
										%loop triggerDataList%
											<option value="%value node_nsName%">%value node_nsName%</option>
										%endloop%
									</select>
									<script language="javascript">
										document.pform.jmsTrigger.value = "%value trgName%";
									</script>
									<select name="mesTrigger" id="mesTrigger" style="display:none">
										%loop triggers%
											<option value="%value name%">%value name%</option>
										%endloop%
									</select>
								%else%
									<select name="jmsTrigger" id="jmsTrigger" style="display:none">
										%loop triggerDataList%
											<option value="%value node_nsName%">%value node_nsName%</option>
										%endloop%
									</select>										
									<select name="mesTrigger" id="mesTrigger">
										%loop triggers%
											<option value="%value name%">%value name%</option>
										%endloop%
									</select>
									<script language="javascript">
										document.pform.mesTrigger.value = "%value trgName%";
									</script>
								%endifvar%
								<input type="hidden" name="trgName" value="%value trgName%">
							</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Provider System Name</td>
							<td class="evenrow-l" width="70%">%value systemName%</td>
						</tr>
						<tr>
							<td class="evenrow" width="30%">Business Name</td>
							<td class="evenrow-l" width="70%">
								<select name="businessName" style="width:190">
									%loop onlineBusinessNameList%
										<option value="%value onlineBusinessNameList%">%value onlineBusinessNameList%</option>
									%endloop%
								</select>						
								<script language="javascript">
									document.pform.businessName.value = "%value businessName%";
								</script>
							</td>
						</tr>
						<tr>
							<td class="action" colspan="2">
								<input type="button" name="SUBMIT" value="Save Properties"  onclick="return doAction('update', '')"></input>
							</td>
						</tr>
					</table>
				%else%

<table width="100%">
  <tbody>
    <tr>
      <td>
      <table width="100%" class="tableForm">
        <tbody>
          <tr>
            <td class="heading" colspan="10">Individual webMethods Messaging Trigger Controls<br>
            </td>
          </tr>
        </tbody>
        <tbody>
          <tr class="subheading2">
            <td colspan="1" rowspan="1"><br>
            </td>
            <td colspan="2">Document Retrieval</td>
            <td colspan="4">Document Processing<br>
            </td>
            <td colspan="3" rowspan="1"><br>
            </td>
          </tr>
          <tr class="subheading2">
            <td>Name</td>            
            <td>Active</td>
            <td>Queue Capacity</td>
            <td>Active</td>
            <td>Processing Mode</td>
            <td>Maximum Threads</td>
            <td>Current Threads</td>
            <td>Business Name</td>
            <td>Edit</td>
						<td>Delete</td>
          </tr>
          
          %ifvar -notempty triggers%
              <script>resetRows();</script>
            %loop triggers%    
              <tr>
                <script>writeTD("row-l");</script>
                  %value name%<br>
                </td>
              </td>

              <!-- ----------------------- -->
              <!-- Document Retrieval info -->  
              <!-- ----------------------- -->
              
              %ifvar retrievalStatus/state -notempty%
	            
	            %ifvar retrievalStatus/state equals('active')%
                  <script>writeTD("rowdata");</script>
	              <img style="width: 13px; height: 13px;" alt="active" border="0" src="%value ../designPath%images/green_check.png">Yes&nbsp;</td>
	            
	            %else% %ifvar retrievalStatus/state equals('active-temp')%
                  <script>writeTD("rowdata");</script>
	              <img style="width: 13px; height: 13px;" alt="active" border="0" src="%value ../designPath%images/green_check.png">Yes*</td>
	            
	            %else% %ifvar retrievalStatus/state equals('suspended')%
	              <script>writeTD("rowdata");</script>No&nbsp;</td>
	            
	            %else% <!-- else suspended-temp -->
	              <script>writeTD("rowdata");</script>No*</td>
	            
	            %endif%
	            %endif%
	            %endif%
	          
	          %else%
                <script>writeTD("rowdata-l");</script>N/A</TD>
              %endif%     

              %ifvar retrievalStatus/state matches('active*')%
                %ifvar properties/queueCapacity vequals(properties/queueCapacityThrottle)%
                  <script>writeTD("rowdata-l");</script>%value properties/queueCapacity%</td>
                %else%
                  <script>writeTD("rowdata-l");</script>%value properties/queueCapacityThrottle%&nbsp;(%value properties/queueCapacity%)</td>
                %endif%   
              %else%
                <script>writeTD("rowdata-l");</script>0&nbsp;(%value properties/queueCapacity%)</td>
              %endif%
              
              <!-- <script>writeTD("rowdata-l");</script>%value properties/ackQueueSize%</td> -->
            
              <!-- ------------------------ -->
              <!-- Document Processing info -->
              <!-- ------------------------ -->
              
              %ifvar processingStatus/state -notempty%
	            
	            %ifvar processingStatus/state equals('active')%
                  <script>writeTD("rowdata");</script>
	              <img style="width: 13px; height: 13px;" alt="active" border="0" src="%value ../designPath%images/green_check.png">Yes&nbsp;</td>
	            
	            %else% %ifvar processingStatus/state equals('active-temp')%
                  <script>writeTD("rowdata");</script>
	              <img style="width: 13px; height: 13px;" alt="active" border="0" src="%value ../designPath%images/green_check.png">Yes*</td>
	           
	            %else% %ifvar processingStatus/state equals('suspended')%
	              <script>writeTD("rowdata");</script>No&nbsp;</td>
	            
	            %else% <!-- else suspended-temp -->
	            <script>writeTD("rowdata");</script>No*</td>
	              
	            %endif%
	            %endif%
	            %endif%
	          
	          %else%
                <script>writeTD("rowdata-l");</script>N/A</TD>
              %endif% 
              
              %ifvar properties/isConcurrent equals('true')%
                <script>writeTD("rowdata-l");</script>Concurrent</td>
                %ifvar processingStatus/state matches('active*')%
                  %ifvar properties/maxExecutionThreads vequals(properties/maxExecutionThreadsThrottle)%
                    <script>writeTD("rowdata-l");</script>%value properties/maxExecutionThreads%</td>
                  %else%
                    <script>writeTD("rowdata-l");</script>%value properties/maxExecutionThreadsThrottle%&nbsp;(%value properties/maxExecutionThreads%)</td>
                  %endif%
                %else%
                  <script>writeTD("rowdata-l");</script>0&nbsp;(%value properties/maxExecutionThreads%)</td> 
                %endif%
             
              %else%
                <script>writeTD("rowdata-l");</script>Serial</td>
                %ifvar processingStatus/state matches('active*')%
                  <script>writeTD("rowdata-l");</script>1</td>
                %else%
                  <script>writeTD("rowdata-l");</script>0 (1)</td>
                %endif%
                <!-- <script>writeTD("rowdata-l");</script>%value properties/serialAutoSuspend%</td> -->
              %endif%
              
              <script>writeTD("rowdata-l");</script>%value processingStatus/activeThreadCount%</td>
              <script>writeTD("rowdata-l");</script>%value businessName%</td>
              <script>writeTD("rowdata-l");</script><a href="javascript:doAction('read', '%value name%')"><img src="%value ../designPath%icons/copy.gif" alt="Edit" border="0"></a></td>
              <script>writeTD("rowdata-l");</script><a href="javascript:doAction('delete', '%value name%')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a></td>
              
            <script>swapRows();</script>
            </tr>
            %endloop% 
         %else%
         		<tr><td colspan=10>No triggers are currently registered</td></tr>
         %endif%
            
          <tr>                    
          </tr>
        </tbody>
      </table>      
      </td>
      </tr>
      
      <tr>
      <td>      
      <table width="100%" class="tableForm">
        <tbody>
          <tr>
            <td class="heading" colspan="8">Individual Standard JMS Trigger Controls<br>
            </td>
          </tr>
        </tbody>
        <tbody>
      		<tr class="subheading2">
      			<td>Trigger Name</td>
        	  <td>Processing Mode</td>
        	  <td>Maximum Threads</td>
        	  <td>Current Threads</td>
        	  <td>Enabled</td>
        	  <td>Business Name</td>
        	  <td>Edit</td>
						<td>Delete</td>
        	</tr>
        
     %ifvar -notempty triggerDataList%
        <script>resetRows();</script>
        %loop triggerDataList%
          
              %ifvar trigger/jmsTriggerType equals('0')%
         
                <tr>
                  <script>writeTD("row-l");</script>%value node_nsName encode(html)%</td>
                  <script>writeTD("row-l");</script>%value trigger/processingModeLocalizedString encode(html)%</td>
                  <script>writeTD("row-l");</script>%value trigger/maxThreadsString encode(html)%</td>
                  <script>writeTDnowrap("row-l");</script>%value trigger/currentThreadsLocalizedString encode(html)%</td>
                  <script>writeTD("rowdata");</script>

                  %switch trigger/state%
                    %case '0'%
                    
                      %ifvar trigger/currentThreads equals('-1')%
                        <img style="width: 13px; height: 13px;" alt="active" border="0" src="%value ../designPath%images/yellow_check.png">Yes
                      %else%
                        <img style="width: 13px; height: 13px;" alt="active" border="0" src="%value ../designPath%images/green_check.png">Yes
                      %endif%
                    
                    %case '1'%
                      No
                    %case '2'%
                      <img style="width: 13px; height: 13px;" alt="suspended" border="0" src="%value ../designPath%images/yellow_check.png">Suspended
                  %end%
                
                  </td>
                  
                  <script>writeTD("row-l");</script>%value businessName%</td>
                  <script>writeTD("row-l");</script><a href="javascript:doAction('read', '%value node_nsName%')"><img src="%value ../designPath%icons/copy.gif" alt="Edit" border="0"></a></td>
                  <script>writeTD("row-l");</script><a href="javascript:doAction('delete', '%value node_nsName%')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a></td>
                </tr>		
                <script>swapRows();</script>
		
		<!-- Error Message --> 
                %ifvar trigger/lastError%
                <tr name="Standard" style="display: none;">
                  <script>writeTDspan("row-l", 8);</script>
                    <font color="red">%value trigger/lastError encode(html)%</font><br> 
                  </td>
                </tr>
		<script>swapRows();</script>
              %endif%
		
              %endif%
            %endloop%
         %else%
         		<tr><td colspan=8>No triggers are currently registered</td></tr>
         %endif%
         
      	</tbody>
      </table>
      </td>
      </tr>
      
      <tr>
      <td>
      <table width="100%" class="tableForm">
        <tbody>
          <tr>
            <td class="heading" colspan="8">Individual SOAP JMS Trigger Controls<br>
            </td>
          </tr>
        </tbody>
        <tbody>
      		<tr class="subheading2">
      			<td>Trigger Name</td>
        	  <td>Processing Mode</td>
        	  <td>Maximum Threads</td>
        	  <td>Current Threads</td>
        	  <td>Enabled</td>
        	  <td>Business Name</td>
        	  <td>Edit</td>
						<td>Delete</td>
        	</tr>
        
     %ifvar -notempty triggerDataList%
        <script>resetRows();</script>
        %loop triggerDataList%
          
           %ifvar trigger/jmsTriggerType equals('1')%
         
        <tr>
          <script>writeTD("row-l");</script>%value node_nsName encode(html)%</td>
			  	<script>writeTD("row-l");</script>%value trigger/processingModeLocalizedString encode(html)%</td>
			  	<script>writeTD("row-l");</script>%value trigger/maxThreadsString encode(html)%</td>
			  	<script>writeTDnowrap("row-l");</script>%value trigger/currentThreadsLocalizedString encode(html)%</td>
			  	<script>writeTD("rowdata");</script>

			  %switch trigger/state%
			    %case '0'%
			    
			      %ifvar trigger/currentThreads equals('-1')%
				<img style="width: 13px; height: 13px;" alt="active" border="0" src="%value ../designPath%images/yellow_check.png">Yes
			      %else%
				<img style="width: 13px; height: 13px;" alt="active" border="0" src="%value ../designPath%images/green_check.png">Yes
			      %endif%
			    
			    %case '1'%
			      No
			    %case '2'%
			      <img style="width: 13px; height: 13px;" alt="suspended" border="0" src="%value ../designPath%images/yellow_check.png">Suspended
			  %end%
			
			  </td>
			  
			  <script>writeTD("row-l");</script>%value businessName%</td>
        <script>writeTD("row-l");</script><a href="javascript:doAction('read', '%value node_nsName%')"><img src="%value ../designPath%icons/copy.gif" alt="Edit" border="0"></a></td>
        <script>writeTD("row-l");</script><a href="javascript:doAction('delete', '%value node_nsName%')"><img src="%value ../designPath%icons/delete.png" alt="Delete" border="0"></a></td>
			</tr>		
                <script>swapRows();</script>
		
		<!-- Error Message --> 
                %ifvar trigger/lastError%
                <tr name="Standard" style="display: none;">
                  <script>writeTDspan("row-l", 8);</script>
                    <font color="red">%value trigger/lastError encode(html)%</font><br> 
                  </td>
                </tr>
		<script>swapRows();</script>
              %endif%
		
              %endif%
            %endloop%
         %else%
         		<tr><td class="evenrow-l" colspan=8>No triggers are currently registered</td></tr>
         %endif%
      	
      	</tbody>
      </table>
      </td>
    </tr>
  </tbody>
</table>
%endifvar%
%endifvar%
<br>
<br>
</body>
</html>

%endinvoke%