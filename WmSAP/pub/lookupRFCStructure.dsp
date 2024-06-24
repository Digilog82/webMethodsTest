<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>SAP - Lookup</title>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    <link rel="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js"></script>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
	<script type="text/javascript" src="/WmART/csrfGuard.js"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/lookup.dsp', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LP_STRUCT', 'foo');">
    <!-- %invoke pub.sap.client:getStructureDefinition% -->
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; Lookup
	  &gt; %ifvar /keyfieldName%Key Field%else%%ifvar /parameterName%Parameter%else%RFC Signature%endif%%endif% &gt; Table</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a id="return_to_lookup" href="lookup.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;$rfcname=%value -urlencode $rfcname%&amp;objectName=%value -urlencode defObjectName%&amp;structName=%value -urlencode structName%">Return to Lookup</a>
		<script>updateURL("return_to_lookup", "Return to Lookup");</script>
		</li>
	    <!-- %ifvar /keyfieldName% -->
	    <li><a id="return_to_key_field" href="lookupBOKeyfield.dsp?systemId=%value -urlencode systemId%&amp;defObjectTypeName=%value -urlencode defObjectTypeName%&amp;defObjectName=%value -urlencode defObjectName%&amp;keyfieldName=%value -urlencode /keyfieldName%">Return to Key Field %value /keyfieldName%</a>
		<script>updateURL("return_to_key_field", "Return to Key Field %value /keyfieldName%");</script>
		</li>
	    <!-- %else%%ifvar /parameterName% -->
	    <li><a id="return_to_param" href="lookupBOParameter.dsp?systemId=%value -urlencode systemId%&amp;defObjectTypeName=%value -urlencode defObjectTypeName%&amp;defObjectName=%value -urlencode defObjectName%&amp;%ifvar eventName%eventName=%value -urlencode eventName%%else%bapiName=%value -urlencode bapiName%%endif%&amp;parameterName=%value -urlencode /parameterName%">Return to Parameter %value /parameterName%</a>
		<script>updateURL("return_to_param", "Return to Parameter %value /parameterName%");</script>
		</li>
	    <!-- %else%%ifvar -notempty $rfcname% -->
	    <li><a id="return_to_rfc_signature" href="lookupRFC.dsp?$rfcname=%value -urlencode $rfcname%&amp;systemId=%value -urlencode /systemId%">Return to RFC Signature for %value $rfcname%</a>
		<script>updateURL("return_to_rfc_signature", "Return to RFC Signature for %value $rfcname%");</script>
		</li>
	    <!-- %endif% -->
	    <!-- %endif% -->
	    <!-- %endif% -->
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="6">%value structName%</td>
	      </tr>
	      <tr>
		<td class="oddcol">Field</td>
		<td class="oddcol">Position</td>
		<td class="oddcol">Length</td>
		<td class="oddcol">Decimals</td>
		<td class="oddcol">Type</td>
		<td class="oddcol">Description</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop fields% -->
	      <tr>
		<td class="evenrowdata-l">%value fieldName%</td>
		<td class="evenrowdata-r">%value position%</td>
		<td class="evenrowdata-r">%value length%</td>
		<td class="evenrowdata">%value decimals%</td>
		<td class="evenrowdata-l">
		<!-- %switch type% -->
		<!-- %case 'STRUCTURE'% -->
	    <!-- %ifvar /keyfieldName% -->
		  <a id="field_type_%value type%" class="leftnav" href="lookupRFCStructure.dsp?systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode tabName%&amp;defObjectTypeName=%value -urlencode /defObjectTypeName%&amp;defObjectName=%value -urlencode /defObjectName%&amp;keyfieldName=%value -urlencode /keyfieldName%">%value type%</a>
		  <script>updateURL("field_type_%value type%", "%value type%");</script>
	    <!-- %else%%ifvar /parameterName% -->
		  <a id="field_type_%value type%" class="leftnav" href="lookupRFCStructure.dsp?systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode tabName%&amp;defObjectTypeName=%value -urlencode /defObjectTypeName%&amp;defObjectName=%value -urlencode /defObjectName%&amp;%ifvar eventName%eventName=%value -urlencode /eventName%%else%bapiName=%value -urlencode /bapiName%%endif%&amp;parameterName=%value -urlencode /parameterName%">%value type%</a>
		  <script>updateURL("field_type_%value type%", "%value type%");</script>
	    <!-- %else% -->
		  <a id="field_type_%value type%" class="leftnav" href="lookupRFCStructure.dsp?systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode tabName%&amp;$rfcname=%value -urlencode /$rfcname%">%value type%</a>
		  <script>updateURL("field_type_%value type%", "%value type%");</script>
	    <!-- %endif% -->
	    <!-- %endif% -->
		<!-- %case 'TABLE'% -->
	    <!-- %ifvar /keyfieldName% -->
		  <a id="field_type_%value type%" class="leftnav" href="lookupRFCStructure.dsp?systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode tabName%&amp;defObjectTypeName=%value -urlencode /defObjectTypeName%&amp;defObjectName=%value -urlencode /defObjectName%&amp;keyfieldName=%value -urlencode /keyfieldName%">%value type%</a>
		  <script>updateURL("field_type_%value type%", "%value type%");</script>
	    <!-- %else%%ifvar /parameterName% -->
		  <a id="field_type_%value type%" class="leftnav" href="lookupRFCStructure.dsp?systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode tabName%&amp;defObjectTypeName=%value -urlencode /defObjectTypeName%&amp;defObjectName=%value -urlencode /defObjectName%&amp;%ifvar eventName%eventName=%value -urlencode /eventName%%else%bapiName=%value -urlencode /bapiName%%endif%&amp;parameterName=%value -urlencode /parameterName%">%value type%</a>
		  <script>updateURL("field_type_%value type%", "%value type%");</script>
	    <!-- %else% -->
		  <a id="field_type_%value type%" class="leftnav" href="lookupRFCStructure.dsp?systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode tabName%&amp;$rfcname=%value -urlencode /$rfcname%">%value type%</a>
		  <script>updateURL("field_type_%value type%", "%value type%");</script>
	    <!-- %endif% -->
	    <!-- %endif% -->
		<!-- %case% -->
		  %value type%
		<!-- %endswitch% -->
		</td>
		<td class="evenrowdata-l">%value description%</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	    <tbody>
	      <tr>
		<td class="subHeading">Length</td>
		<td class="oddrowdata-r" colspan="5">%value tabLength%</td>
	      </tr>
	    </tbody>
	  </table>
	</td>
      </tr>
      <script>swapColor('tbodyNode', false);</script>
    </table>
    <!-- %onerror% -->
    %include error.html%
    <!-- %endinvoke% -->
  </body>
</html>