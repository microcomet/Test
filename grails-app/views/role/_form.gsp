<%@ page import="smartcommunity.Role" %>



<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="role.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="50" required="" value="${roleInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'role', 'error')} required">
	<label for="role">
		<g:message code="role.role.label" default="Role" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="role" type="number" value="${roleInstance.role}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'create_time', 'error')} required">
	<label for="create_time">
		<g:message code="role.create_time.label" default="Createtime" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="create_time" precision="day"  value="${roleInstance?.create_time}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'update_time', 'error')} required">
	<label for="update_time">
		<g:message code="role.update_time.label" default="Updatetime" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="update_time" precision="day"  value="${roleInstance?.update_time}"  />

</div>

