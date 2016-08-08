<%@ page import="smartcommunity.Yyfw" %>



<div class="fieldcontain ${hasErrors(bean: yyfwInstance, field: 'reservePerson', 'error')} ">
	<label for="reservePerson">
		<g:message code="yyfw.reservePerson.label" default="Reserve Person" />
		
	</label>
	<g:select id="reservePerson" name="reservePerson.id" from="${smartcommunity.User.list()}" optionKey="id" value="${yyfwInstance?.reservePerson?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: yyfwInstance, field: 'checkPerson', 'error')} ">
	<label for="checkPerson">
		<g:message code="yyfw.checkPerson.label" default="Check Person" />
		
	</label>
	<g:select id="checkPerson" name="checkPerson.id" from="${smartcommunity.User.list()}" optionKey="id" value="${yyfwInstance?.checkPerson?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: yyfwInstance, field: 'orderTime', 'error')} ">
	<label for="orderTime">
		<g:message code="yyfw.orderTime.label" default="Order Time" />
		
	</label>
	<g:datePicker name="orderTime" precision="day"  value="${yyfwInstance?.orderTime}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: yyfwInstance, field: 'serverTime', 'error')} ">
	<label for="serverTime">
		<g:message code="yyfw.serverTime.label" default="Server Time" />
		
	</label>
	<g:datePicker name="serverTime" precision="day"  value="${yyfwInstance?.serverTime}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: yyfwInstance, field: 'serverDesc', 'error')} ">
	<label for="serverDesc">
		<g:message code="yyfw.serverDesc.label" default="Server Desc" />
		
	</label>
	<g:textField name="serverDesc" value="${yyfwInstance?.serverDesc}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: yyfwInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="yyfw.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${yyfwInstance?.status}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: yyfwInstance, field: 'createTime', 'error')} ">
	<label for="createTime">
		<g:message code="yyfw.createTime.label" default="Create Time" />
		
	</label>
	<g:datePicker name="createTime" precision="day"  value="${yyfwInstance?.createTime}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: yyfwInstance, field: 'updateTime', 'error')} ">
	<label for="updateTime">
		<g:message code="yyfw.updateTime.label" default="Update Time" />
		
	</label>
	<g:datePicker name="updateTime" precision="day"  value="${yyfwInstance?.updateTime}" default="none" noSelection="['': '']" />

</div>

