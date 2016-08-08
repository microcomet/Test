<%@ page import="smartcommunity.Score" %>



<div class="control-group">
	<label class="control-label"><g:message code="score.name.label" default="Name" /></label>
	<div class="controls">
		${scoreInstance?.name}
	</div>
</div>
<div class="control-group">
	<label class="control-label"><g:message code="score.type.label" default="Type" /></label>
	<div class="controls">
		${scoreInstance?.name}
	</div>
</div>
<div class="control-group">
	<label class="control-label">
		<g:message code="score.score.label" default="Score" />
	</label>
	<div class="controls">
		<g:field name="score" type="number" value="${scoreInstance.score}" required=""/>
	</div>
</div>



%{--<div class="fieldcontain ${hasErrors(bean: scoreInstance, field: 'name', 'error')} required">--}%
	%{--<label for="name">--}%
		%{--<g:message code="score.name.label" default="Name" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:textField name="name" maxlength="100" required="" value="${scoreInstance?.name}"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: scoreInstance, field: 'type', 'error')} required">--}%
	%{--<label for="type">--}%
		%{--<g:message code="score.type.label" default="Type" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:field name="type" type="number" value="${scoreInstance.type}" required=""/>--}%

%{--</div>--}%


