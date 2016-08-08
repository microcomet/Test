<%@ page import="smartcommunity.Desire" %>


<div class="fieldcontain ${hasErrors(bean: desireInstance, field: 'requester', 'error')} required">
	<label for="requester">
		<g:message code="desire.requester.label" default="Requester" />
		<span></span>
	</label>
	<g:select id="requester" name="requester.id" from="${smartcommunity.User.list()}" optionKey="id" value="${desireInstance?.requester?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: desireInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="desire.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" maxlength="250" required="" value="${desireInstance?.title}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: desireInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="desire.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="2000" required="" value="${desireInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: desireInstance, field: 'score', 'error')} required">
	<label for="score">
		<g:message code="desire.score.label" default="Score" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="score" type="number" value="${desireInstance.score}" required=""/>

</div>

%{--<div class="fieldcontain ${hasErrors(bean: desireInstance, field: 'create_time', 'error')} ">--}%
	%{--<label for="create_time">--}%
		%{--<g:message code="desire.create_time.label" default="Createtime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="create_time" precision="day"  value="${desireInstance?.create_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: desireInstance, field: 'helper', 'error')} ">--}%
	%{--<label for="helper">--}%
		%{--<g:message code="desire.helper.label" default="Helper" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:select id="helper" name="helper.id" from="${smartcommunity.User.list()}" optionKey="id" value="${desireInstance?.helper?.id}" class="many-to-one" noSelection="['null': '']"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: desireInstance, field: 'status', 'error')} ">--}%
	%{--<label for="status">--}%
		%{--<g:message code="desire.status.label" default="Status" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:field name="status" type="number" value="${desireInstance.status}"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: desireInstance, field: 'update_time', 'error')} ">--}%
	%{--<label for="update_time">--}%
		%{--<g:message code="desire.update_time.label" default="Updatetime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="update_time" precision="day"  value="${desireInstance?.update_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

