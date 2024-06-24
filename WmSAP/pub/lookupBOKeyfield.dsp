<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>SAP - Lookup</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    <link rel="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js"></script>
	<script type="text/javascript" src="/WmART/csrfGuard.js"></script>
	<script src="sap.js"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/lookup.dsp', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LP_BOKEY', 'foo');">
    <!-- %invoke wm.sap.Bapi:getKeyfieldDefinition% -->
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup
	  &gt; Key field
	</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a id="return_to_lookup" href="lookup.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;objectName=%value -urlencode defObjectName%">Return to Lookup</a>
		<script>updateURL("return_to_lookup", "Return to Lookup");</script>
		</li>
	    <li><a id="return_to_bo" href="lookupBO.dsp?systemId=%value -urlencode systemId%&amp;internalName=%value -urlencode defObjectTypeName%">Return to Business Object %value defObjectName%</a>
		<script>updateURL("return_to_bo", "Return to Business Object %value defObjectName%");</script>
		</li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <tr>
	      <td class="subheading2" colspan="2">Key field %value keyfieldName%</td>
	    </tr>
	    <tr>
	      <td class="rowlabel">Declaration object name</td>
	      <td class="oddrowdata-l">%value defObjectName% (%value defObjectTypeName%)</td>
	    </tr>
	    <tr>
	      <td class="rowlabel">Internal name</td>
	      <td class="oddrowdata-l">%value internalName%</td>
	    </tr>
	    <tr>
	      <td class="rowlabel"> ABAP dictionary type</td>
	      <td class="evenrowdata-l">
		<!-- %ifvar ddicStructure% -->
		<a id="ddic_ref_%value ddicReference%" href="lookupRFCStructure.dsp?structName=%value -urlencode ddicStructure%&amp;systemId=%value -urlencode systemId%&amp;keyfieldName=%value -urlencode keyfieldName%&amp;defObjectTypeName=%value -urlencode defObjectTypeName%&amp;defObjectName=%value -urlencode defObjectName%">%value ddicReference%</a>
		<script>updateURLSAP("ddic_ref_%value ddicReference%", "%value ddicReference%");</script>
		<!-- %else% -->
   		%value ddicReference%
		<!-- %endif% -->
	      </td>
	    </tr>
	  </table>
	</td>
      </tr>
    </table>
    <!-- %onerror% -->
    %include error.html%
    <!-- %endinvoke% -->
  </body>
</html>