<%@ page import="smartcommunity.Street" %>



<div class="control-group">
	<label class="control-label"><g:message code="street.name.label" default="Name" />*</label>
	<div class="controls">
		<g:textField name="name" maxlength="250" required="" value="${streetInstance?.name}"/>
	</div>
</div>
<div class="control-group">
	<label class="control-label"><g:message code="street.description.label" default="Description" />*</label>
	<div class="controls">
		<g:textArea name="description" cols="40" rows="5" maxlength="2000" required="" value="${streetInstance?.description}"/>
	</div>
</div>
<div class="control-group">
	<label class="control-label"><g:message code="street.code.label" default="Code" />*</label>
	<div class="controls">
		<g:textField name="code" maxlength="50" required="" value="${streetInstance?.code}"/>
		编码中不允许使用中文
	</div>
</div>
<div class="control-group">
	<label class="control-label"><g:message code="street.charger.label" default="Charger" />*</label>
	<div class="controls">
		<g:textField id="charger" name="charger" required="" value="${streetInstance?.charger}" />
	</div>
</div>
<div class="control-group">
	<label class="control-label"><g:message code="street.charger_mobile.label" default="Charger_mobile" />*</label>
	<div class="controls">
		<g:textField id="charger_mobile" name="charger_mobile" required="" value="${streetInstance?.charger_mobile}" />
	</div>
</div>





%{--<div class="fieldcontain ${hasErrors(bean: streetInstance, field: 'charger', 'error')} ">--}%
	%{--<label for="charger">--}%
		%{--<g:message code="street.charger.label" default="Charger" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:textField id="charger" name="charger" value="${streetInstance?.charger}" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: streetInstance, field: 'charger_mobile', 'error')} ">--}%
	%{--<label for="charger_mobile">--}%
		%{--<g:message code="street.charger_mobile.label" default="Charger_mobile" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:textField id="charger_mobile" name="charger_mobile"  value="${streetInstance?.charger_mobile}" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: streetInstance, field: 'create_time', 'error')} ">--}%
	%{--<label for="create_time">--}%
		%{--<g:message code="street.create_time.label" default="Createtime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="create_time" precision="day"  value="${streetInstance?.create_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: streetInstance, field: 'update_time', 'error')} ">--}%
	%{--<label for="update_time">--}%
		%{--<g:message code="street.update_time.label" default="Updatetime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="update_time" precision="day"  value="${streetInstance?.update_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

