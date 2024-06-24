%invoke JSocketAdapter.ADMIN:adminDeploySchedule%

%ifvar deploy equals('target')%
<script language="javascript">	
	parent.setTargetNodes('%value targetNodes%');
</script>
%endifvar%

<html>
	<body>
		<form name="sform" method="post" target="_self">
			<input type="hidden" name="deploy" value="target">
			<input type="hidden" name="remoteAlias" value="">
		</form>		
	</body>
</html>