<%@ page import="smartcommunity.ServiceDepartment" %>



<div class="control-group">
	<label class="control-label"><g:message code="serviceDepartment.name.label" default="Name" />*</label>
	<div class="controls">
		<g:textField name="name" maxlength="250" required="" value="${serviceDepartmentInstance?.name}"/>
	</div>
</div>

<div class="control-group">
	<label class="control-label"><g:message code="serviceDepartment.description.label" default="Description" /></label>
	<div class="controls">
		<g:textArea name="description" value="${serviceDepartmentInstance?.description}"/>
	</div>
</div>




%{--<div class="fieldcontain ${hasErrors(bean: serviceDepartmentInstance, field: 'name', 'error')} required">--}%
	%{--<label for="name">--}%
		%{--<g:message code="serviceDepartment.name.label" default="Name" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:textField name="name" maxlength="250" required="" value="${serviceDepartmentInstance?.name}"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: serviceDepartmentInstance, field: 'street', 'error')} required">--}%
	%{--<label for="street">--}%
		%{--<g:message code="serviceDepartment.street.label" default="Street" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:select id="street" name="street.id" from="${smartcommunity.Street.list()}" optionKey="id" required="" value="${serviceDepartmentInstance?.street?.id}" class="many-to-one"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: serviceDepartmentInstance, field: 'address', 'error')} ">--}%
	%{--<label for="address">--}%
		%{--<g:message code="serviceDepartment.address.label" default="Address" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:textField name="address" value="${serviceDepartmentInstance?.address}"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: serviceDepartmentInstance, field: 'community', 'error')} ">--}%
	%{--<label for="community">--}%
		%{--<g:message code="serviceDepartment.community.label" default="Community" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:select id="community" name="community.id" from="${smartcommunity.Community.list()}" optionKey="id" value="${serviceDepartmentInstance?.community?.id}" class="many-to-one" noSelection="['null': '']"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: serviceDepartmentInstance, field: 'create_time', 'error')} ">--}%
	%{--<label for="create_time">--}%
		%{--<g:message code="serviceDepartment.create_time.label" default="Createtime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="create_time" precision="day"  value="${serviceDepartmentInstance?.create_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: serviceDepartmentInstance, field: 'description', 'error')} ">--}%
	%{--<label for="description">--}%
		%{--<g:message code="serviceDepartment.description.label" default="Description" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:textArea name="description" value="${serviceDepartmentInstance?.description}"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: serviceDepartmentInstance, field: 'update_time', 'error')} ">--}%
	%{--<label for="update_time">--}%
		%{--<g:message code="serviceDepartment.update_time.label" default="Updatetime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="update_time" precision="day"  value="${serviceDepartmentInstance?.update_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

