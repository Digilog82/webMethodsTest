<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>WmSAP - DDIC Cache</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
	<link REL="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js"></script>
	<script type="text/javascript" src="/WmART/csrfGuard.js"></script>
	<script type="text/javascript" src="sap.js"></script>
	<script type="text/javascript">
		function addCSRFTokenIfNeeded(elemId)
		{
			if(!is_csrf_guard_enabled && !needToInsertToken)
			{
				return;
			}
			
			var elem = document.getElementById(elemId);
			if(elem == undefined || elem == null)
			{
				return;
			}
			
			var url = elem.href;
			if(url && url.indexOf(_csrfTokenNm_) == -1)
			{
				url = url + "&" + _csrfTokenNm_ + "=" + _csrfTokenVal_;
				elem.setAttribute("href", url);
			}			
		}
	</script>
  </head>
  <body onLoad="setNavigation('/WmSAP/ddic.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_DD', 'foo');">
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; DDIC Cache 
	  %switch what%
	  %case 'functions'%
	    &gt; Functions
	  %case 'structures'%
	    &gt; Structures
	  %case 'businessObjects'%
	    &gt; Business Objects
	  %case 'aleMappings'%
	    &gt; ALE Mappings
	  %case 'iDocs'%
	    &gt; IDocs
	  %case 'viewFunction'%
	    &gt; Functions &gt; Function Interface
	  %case 'viewStructure'%
	    &gt; Structures &gt; Structure Definition
	  %case%
	  %endswitch%
	</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <!-- %switch what% -->
	    <!-- %case 'functions'% -->
	    <li><a id="return_to_ddic_cache1" href="ddic.dsp?adapterTypeName=WmSAP">Return to DDIC Cache</a>
		<script>addCSRFTokenIfNeeded("return_to_ddic_cache1")</script>
		<script>updateURL("return_to_ddic_cache1", "Return to DDIC Cache");</script>
		</li>
	    <!-- %case 'structures'% -->
	    <li><a id="return_to_ddic_cache2" href="ddic.dsp?adapterTypeName=WmSAP">Return to DDIC Cache</a>
		<script>addCSRFTokenIfNeeded("return_to_ddic_cache2")</script>
		<script>updateURL("return_to_ddic_cache2", "Return to DDIC Cache");</script>
		</li>
	    <!-- %case 'businessObjects'% -->
	    <li><a id="return_to_ddic_cache3" href="ddic.dsp?adapterTypeName=WmSAP">Return to DDIC Cache</a>
		<script>addCSRFTokenIfNeeded("return_to_ddic_cache3")</script>
		<script>updateURL("return_to_ddic_cache3", "Return to DDIC Cache");</script>
		</li>
	    <!-- %case 'aleMappings'% -->
	    <li><a id="return_to_ddic_cache4" href="ddic.dsp?adapterTypeName=WmSAP">Return to DDIC Cache</a>
		<script>addCSRFTokenIfNeeded("return_to_ddic_cache4")</script>
		<script>updateURL("return_to_ddic_cache4", "Return to DDIC Cache");</script>
		</li>
	    <!-- %case 'iDocs'% -->
	    <li><a id="return_to_ddic_cache5" href="ddic.dsp?adapterTypeName=WmSAP">Return to DDIC Cache</a>
		<script>addCSRFTokenIfNeeded("return_to_ddic_cache5")</script>
		<script>updateURL("return_to_ddic_cache5", "Return to DDIC Cache");</script>
		</li>
	    <!-- %case 'viewFunction'% -->
	    <li><a id="return_to_ddic_cache6" href="ddic.dsp?adapterTypeName=WmSAP">Return to DDIC Cache</a>
		<script>addCSRFTokenIfNeeded("return_to_ddic_cache6")</script>
		<script>updateURL("return_to_ddic_cache1", "Return to DDIC Cache");</script>
		</li>
	    <li><a id="return_to_cached_functions" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;what=functions">Return to Cached Functions</a>
		<script>addCSRFTokenIfNeeded("return_to_cached_functions")</script>
		<script>updateURL("return_to_cached_functions", "Return to Cached Functions");</script>
		</li>
	    <!-- %case 'viewStructure'% -->
	    <li><a id="return_to_ddic_cache7" href="ddic.dsp?adapterTypeName=WmSAP">Return to DDIC Cache</a>
		<script>addCSRFTokenIfNeeded("return_to_ddic_cache7")</script>
		<script>updateURL("return_to_ddic_cache7", "Return to DDIC Cache");</script>
		</li>
	    <li><a id="return_to_cached_structures" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;what=structures">Return to Cached Structures</a>
		<script>addCSRFTokenIfNeeded("return_to_cached_structures")</script>
		<script>updateURL("return_to_cached_structures", "Return to Cached Structures");</script>
		</li>
	    <!-- %case% -->
	    <!-- %endswitch% -->
	  </ul>
	</td>
      </tr>
      <!-- 
      %switch what%
        %case 'functions'%
          %ifvar delete%
            %invoke wm.sap.Cache:removeFunction%
            %endinvoke%
          %endif%
          %invoke wm.sap.Cache:listFunctions%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="2">Cached Functions</td>
	      </tr>
	      <tr>
		<td class="oddcol">Function Module</td>
		<td class="oddcol">Remove</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata-l">
		  <a id="%value functionName%" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;functionName=%value -urlencode functionName%&amp;what=viewFunction">%value functionName%</a>
		  <script>addCSRFTokenIfNeeded("%value functionName%")</script>
		  <script>updateURL("%value functionName%", "%value functionName%");</script>
		</td>
		<td class="evenrowdata">
		  <a id="delete_icon_%value functionName%" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;functionName=%value -urlencode functionName%&amp;what=functions&amp;delete=1"><img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img></a>
		  <script>addCSRFTokenIfNeeded("delete_icon_%value functionName%")</script>
		  <script>updateURL("delete_icon_%value functionName%", '<img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img>');</script>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!--
        %endinvoke%
      %case 'structures'%
        %ifvar delete%
          %invoke wm.sap.Cache:removeStructure%
          %endinvoke%
        %endif%
        %invoke wm.sap.Cache:listStructures%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="2">Cached Structures</td>
	      </tr>
	      <tr class="heading">
		<td class="oddcol">Structure</td>
		<td class="oddcol">Remove</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata-l">
		  <a id="%value structName%" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode structName%&amp;what=viewStructure">%value structName%</a>
		  <script>addCSRFTokenIfNeeded("%value structName%")</script>
		  <script>updateURL("%value structName%", "%value structName%");</script>
		</td>
		<td class="evenrowdata">
		  %switch structName%
		  %case 'RFC_FIELDS'%&nbsp;
		  %case 'SBC_FIELDS'%&nbsp;
		  %case 'RFC_FUNINT'%&nbsp;
		  %case 'SBCCALLENV'%&nbsp;
		  %case 'SBC_TABLEN'%&nbsp;
		  %case%
		  <a id="delete_icon_%value structName%" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode structName%&amp;what=structures&amp;delete=1"><img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img></a>
		  <script>addCSRFTokenIfNeeded("delete_icon_%value structName%")</script>
		  <script>updateURL("delete_icon_%value structName%", '<img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img>');</script>
		  %endswitch%
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!--
        %endinvoke%
      %case 'businessObjects'%
        %ifvar delete%
          %invoke wm.sap.Cache:removeBusinessObject%
          %endinvoke%
        %endif%
        %invoke wm.sap.Cache:listBusinessObjects%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="3">Cached Business Objects</td>
	      </tr>
	      <tr>
		<td class="oddcol">Business Object</td>
		<td class="oddcol">Internal Name</td>
		<td class="oddcol">Remove</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata-l">    	
		  %value objectName% 
		</td>
		<td class="evenrowdata-l">    	
		  %value internalName% 
		</td>
		<td class="evenrowdata">
		  <a id="delete_icon_%value objectName%" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;internalName=%value -urlencode internalName%&amp;what=businessObjects&amp;delete=1"><img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img></a>
		  <script>addCSRFTokenIfNeeded("delete_icon_%value objectName%")</script>
		  <script>updateURL("delete_icon_%value objectName%", '<img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img>');</script>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!--
        %endinvoke%
      %case 'aleMappings'%
        %ifvar delete%
          %invoke wm.sap.Cache:removeALEMapping%
          %endinvoke%
        %endif%
        %invoke wm.sap.Cache:listALEMappings%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="2">Cached ALE Mappings</td>
	      </tr>
	      <tr>
		<td class="oddcol">BAPI</td>
		<td class="oddcol">Remove</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata-l">    	
		  %value bapiName%
		</td>
		<td class="evenrowdata">
		  <a id="delete_icon_%value bapiName%" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;bapiName=%value -urlencode bapiName%&amp;what=aleMappings&amp;delete=1"><img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img></a>
		  <script>addCSRFTokenIfNeeded("delete_icon_%value bapiName%")</script>
		  <script>updateURL("delete_icon_%value bapiName%", '<img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img>');</script>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!--
        %endinvoke%
      %case 'iDocs'%
        %ifvar delete%
          %invoke wm.sap.Cache:removeIDoc%
          %endinvoke%
        %endif%
        %invoke wm.sap.Cache:listIDocs%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="4">Cached IDocs</td>
	      </tr>
	      <tr>
		<td class="oddcol">IDoc Type</td>
		<td class="oddcol">IDoc Type Extension</td>
		<td class="oddcol">Release</td>
		<td class="oddcol">Remove</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata-l">    	
		  %value iDocType%
		</td>
		<td class="evenrowdata-l">    	
		  %value cimType%
		</td>
		<td class="evenrowdata-l">    	
		  %value iDocRelease%
		</td>
		<td class="evenrowdata">
		  <a id="delete_icon_%value iDocType%_%value iDocRelease%" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;iDocType=%value -urlencode iDocType%&amp;cimType=%value -urlencode cimType%&amp;iDocRelease=%value -urlencode iDocRelease%&amp;what=iDocs&amp;delete=1"><img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img></a>
		  <script>addCSRFTokenIfNeeded("delete_icon_%value iDocType%_%value iDocRelease%")</script>
		  <script>updateURL("delete_icon_%value iDocType%_%value iDocRelease%", '<img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img>');</script>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!--
        %endinvoke%
      %case 'viewStructure'%
        %invoke wm.sap.Cache:getStructureDefinition%
        %ifvar values%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="5">Structure definition for %value structName%</td>
	      </tr>
	      <tr>
		<td class="oddcol">Field</td>
		<td class="oddcol">Length</td>
		<td class="oddcol">Decimals</td>
		<td class="oddcol">Type</td>
		<td class="oddcol">Description</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata-l">%value fieldName%</td>
		<td class="evenrowdata-r">%value length%</td>
		<td class="evenrowdata-r">%value decimals%</td>
		<td class="evenrowdata">
		<!-- %switch type% -->
		<!-- %case 'STRUCTURE'% -->
		  <a id="%value fieldName%structure_%value type%" class="leftnav" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode tabName%&amp;what=viewStructure">%value type%</a>
		  <script>addCSRFTokenIfNeeded("%value fieldName%structure_%value type%")</script>
		  <script>updateURL("%value fieldName%structure_%value type%", "%value type%");</script>
		<!-- %case 'TABLE'% -->
		  <a id="%value fieldName%table_%value type%" class="leftnav" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode tabName%&amp;what=viewStructure">%value type%</a>
		  <script>addCSRFTokenIfNeeded("%value fieldName%table_%value type%")</script>
		  <script>updateURL("%value fieldName%table_%value type%", "%value type%");</script>
		<!-- %case% -->
		  %value type%
		<!-- %endswitch% -->
		</td>
		<td class="evenrowdata-l">%value description%</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!--
        %endif%
        %onerror%
          %include error.html%
        %endinvoke%
      %case 'viewFunction'%
        %invoke wm.sap.Cache:getFunctionInterface%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="7">Function interface for %value functionName%</td>
	      </tr>
	      <tr>
		<td class="oddcol">Class</td>
		<td class="oddcol">Parameter</td>
		<td class="oddcol">Table</td>
		<td class="oddcol">Type</td>
		<td class="oddcol">Length</td>
		<td class="oddcol">Decimals</td>
		<td class="oddcol">Optional</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata">%value parameterType%</td>
		<td class="evenrowdata-l">%value parameterName%</td>
		<!-- %switch type% -->
		<!-- %case 'STRUCTURE'% -->
		<td class="evenrowdata-l"><a id="%value parameterName%structure_%value tabName%" class="leftnav" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode tabName%&amp;what=viewStructure">%value tabName%</a>
		<script>addCSRFTokenIfNeeded("%value parameterName%structure_%value tabName%")</script>
		<script>updateURL("%value parameterName%structure_%value tabName%", "%value tabName%");</script>
		</td>
		<!-- %case 'TABLE'% -->
		<td class="evenrowdata-l"><a id="%value parameterName%table_%value tabName%" class="leftnav" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode tabName%&amp;what=viewStructure">%value tabName%</a>
		<script>addCSRFTokenIfNeeded("%value parameterName%table_%value tabName%")</script>
		<script>updateURL("%value parameterName%table_%value tabName%", "%value tabName%");</script>
		</td>
		<!-- %case% -->
		<td class="evenrowdata-l">%value tabName%</td>
		<!-- %endswitch% -->
		<td class="evenrowdata-l">%value type%</td>
		<td class="evenrowdata-r">%value length%</td>
		<td class="evenrowdata">%value decimals%</td>
		<td class="evenrowdata">%value optional%</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!--
        %endinvoke%
      %case%
        %ifvar clear%
          %invoke wm.sap.Cache:clear%
          %endinvoke%
        %endif%
        %invoke wm.sap.Cache:listSystems%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <div class="space">&nbsp;</div>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="7">SAP Repository Cache</td>
	      </tr>
	      <tr>
		<td class="oddcol">System ID</td>
		<td class="oddcol">Functions</td>
		<td class="oddcol">Structures</td>
		<td class="oddcol">Business Objects</td>    
		<td class="oddcol">ALE Mappings</td>    
		<td class="oddcol">IDocs</td>    
		<td class="oddcol">Clear Cache</td>    
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop systemIds% -->
	      <tr>
		<td class="oddrowdata-l">%value systemId%</td>
		<td class="oddrowdata">
		  <a id="%value systemId%_function_%value functionCount%" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;what=functions">%value functionCount%</a>
		  <script>addCSRFTokenIfNeeded("%value systemId%_function_%value functionCount%")</script>
		  <script>updateURLSAP("%value systemId%_function_%value functionCount%", "%value functionCount%");</script>
		  
		</td>
		<td class="oddrowdata">
		  <a id="%value systemId%_structure_%value structureCount%" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;what=structures">%value structureCount%</a>
		  <script>addCSRFTokenIfNeeded("%value systemId%_structure_%value structureCount%")</script>
		  <script>updateURLSAP("%value systemId%_structure_%value structureCount%", "%value structureCount%");</script>
		</td>
		<td class="oddrowdata">
		  <a id="%value systemId%_bo_%value businessObjectCount%" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;what=businessObjects">%value businessObjectCount%</a>
		  <script>addCSRFTokenIfNeeded("%value systemId%_bo_%value businessObjectCount%")</script>
		  <script>updateURLSAP("%value systemId%_bo_%value businessObjectCount%", "%value businessObjectCount%");</script>
		</td>
		<td class="oddrowdata">
		  <a id="%value systemId%_ALE_%value aleMappingCount%" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;what=aleMappings">%value aleMappingCount%</a>
		  <script>addCSRFTokenIfNeeded("%value systemId%_ALE_%value aleMappingCount%")</script>
		  <script>updateURLSAP("%value systemId%_ALE_%value aleMappingCount%", "%value aleMappingCount%");</script>
		</td>
		<td class="oddrowdata">
		  <a id="%value systemId%_idoc_%value iDocCount%" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;what=iDocs">%value iDocCount%</a>
		  <script>addCSRFTokenIfNeeded("%value systemId%_idoc_%value iDocCount%")</script>
		  <script>updateURLSAP("%value systemId%_idoc_%value iDocCount%", "%value iDocCount%");</script>
		</td>
		<td class="oddrowdata">
		  <a id="delete_icon_%value systemId%" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;clear=1"><img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img></a>
		  <script>addCSRFTokenIfNeeded("delete_icon_%value systemId%")</script>
		  <script>updateURLSAP("delete_icon_%value systemId%", '<img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img>');</script>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
        %endinvoke%
      %endswitch%
    </table>
  </body>
</html>