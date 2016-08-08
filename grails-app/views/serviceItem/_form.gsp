<%@ page import="smartcommunity.ServiceItem" %>


<div class="control-group">
	<label class="control-label"><g:message code="serviceItem.name.label" default="Name" />*</label>
	<div class="controls">
		<g:textField name="name" cols="40" rows="5" maxlength="500" required="" value="${serviceItemInstance?.name}"/>
	</div>
</div>

<div class="control-group">
	<label class="control-label"><g:message code="serviceItem.detail.label" default="Detail" />*</label>
	<div class="controls">
		<g:textArea name="detail" required="" value="${serviceItemInstance?.detail}"/>
	</div>
</div>

<div class="control-group">
	<label class="control-label"><g:message code="serviceItem.department.label" default="Department" /></label>
	<div class="controls">
		<g:select id="department" name="department.id" from="${smartcommunity.ServiceDepartment.list()}" optionKey="id" optionValue="name" required="" value="${serviceItemInstance?.department?.id}" class="many-to-one"/>
	</div>
</div>




%{--<div class="fieldcontain ${hasErrors(bean: serviceItemInstance, field: 'create_time', 'error')} ">--}%
	%{--<label for="create_time">--}%
		%{--<g:message code="serviceItem.create_time.label" default="Createtime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="create_time" precision="day"  value="${serviceItemInstance?.create_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: serviceItemInstance, field: 'update_time', 'error')} ">--}%
	%{--<label for="update_time">--}%
		%{--<g:message code="serviceItem.update_time.label" default="Updatetime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="update_time" precision="day"  value="${serviceItemInstance?.update_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

