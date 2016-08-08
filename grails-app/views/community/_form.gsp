<%@ page import="smartcommunity.Community" %>


<div class="control-group" style="display: ">
	<label class="control-label"><g:message code="community.street.label" default="Street" />*</label>
	<div class="controls">
		<g:select id="street" name="street.id" from="${smartcommunity.Street.list()}" optionKey="id" optionValue="name" required="" value="${sid}" class="many-to-one"/>

	</div>
</div>
<div class="control-group">
	<label class="control-label"><g:message code="community.name.label" default="Name" />*</label>
	<div class="controls">
		<g:textField name="name" cols="40" rows="5" maxlength="500" required="" value="${communityInstance?.name}"/>
	</div>
</div>
<div class="control-group">
	<label class="control-label"><g:message code="community.code.label" default="Code" />*</label>
	<div class="controls">
		<g:textField name="code" maxlength="50" required="" value="${communityInstance?.code}"/>

	</div>
</div>

<div class="control-group">
	<label class="control-label"><g:message code="community.charger.label" default="Charger" />*</label>
	<div class="controls">
		<g:textField id="charger" name="charger" from="${smartcommunity.User.list()}" required="" value="${communityInstance?.charger}" />

	</div>
</div>
<div class="control-group">
	<label class="control-label"><g:message code="community.charger_mobile.label" default="Charger" />*</label>
	<div class="controls">
		<g:textField id="charger_mobile" name="charger_mobile" from="${smartcommunity.User.list()}" required="" value="${communityInstance?.charger_mobile}" />
	</div>
</div>
<div class="control-group">
	<label class="control-label"><g:message code="community.description.label" default="Description" /></label>
	<div class="controls">
		<g:textArea name="description" value="${communityInstance?.description}"/>
	</div>
</div>





%{--<div class="fieldcontain ${hasErrors(bean: communityInstance, field: 'create_time', 'error')} ">--}%
	%{--<label for="create_time">--}%
		%{--<g:message code="community.create_time.label" default="Createtime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="create_time" precision="day"  value="${communityInstance?.create_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%


%{--<div class="fieldcontain ${hasErrors(bean: communityInstance, field: 'update_time', 'error')} ">--}%
	%{--<label for="update_time">--}%
		%{--<g:message code="community.update_time.label" default="Updatetime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="update_time" precision="day"  value="${communityInstance?.update_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

