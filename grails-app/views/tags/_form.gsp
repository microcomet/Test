<%@ page import="test.Tags" %>



<div class="fieldcontain ${hasErrors(bean: tagsInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="tags.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="100" required="" value="${tagsInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: tagsInstance, field: 'create_time', 'error')} ">
	<label for="create_time">
		<g:message code="tags.create_time.label" default="Createtime" />
		
	</label>
	<g:datePicker name="create_time" precision="day"  value="${tagsInstance?.create_time}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: tagsInstance, field: 'user_id', 'error')} ">
	<label for="user_id">
		<g:message code="tags.user_id.label" default="Userid" />
		
	</label>
	<g:field name="user_id" type="number" value="${tagsInstance.user_id}"/>

</div>

