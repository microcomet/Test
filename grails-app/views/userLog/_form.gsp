<%@ page import="smartcommunity.UserLog" %>



<div class="fieldcontain ${hasErrors(bean: userLogInstance, field: 'operator', 'error')} required">
	<label for="operator">
		<g:message code="userLog.operator.label" default="Operator" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="operator" type="number" value="${userLogInstance.operator}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: userLogInstance, field: 'operate', 'error')} required">
	<label for="operate">
		<g:message code="userLog.operate.label" default="Operate" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="operate" type="number" value="${userLogInstance.operate}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: userLogInstance, field: 'table_name', 'error')} required">
	<label for="table_name">
		<g:message code="userLog.table_name.label" default="Tablename" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="table_name" maxlength="30" required="" value="${userLogInstance?.table_name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userLogInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="userLog.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="2000" required="" value="${userLogInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userLogInstance, field: 'operate_time', 'error')} required">
	<label for="operate_time">
		<g:message code="userLog.operate_time.label" default="Operatetime" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="operate_time" precision="day"  value="${userLogInstance?.operate_time}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: userLogInstance, field: 'create_time', 'error')} required">
	<label for="create_time">
		<g:message code="userLog.create_time.label" default="Createtime" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="create_time" precision="day"  value="${userLogInstance?.create_time}"  />

</div>

