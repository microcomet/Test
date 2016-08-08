<%@ page import="smartcommunity.PollOption" %>



<div class="fieldcontain ${hasErrors(bean: pollOptionInstance, field: 'poll', 'error')} required">
	<label for="poll">
		<g:message code="pollOption.poll.label" default="Poll" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="poll" name="poll.id" from="${smartcommunity.Poll.list()}" optionKey="id" required="" value="${pollOptionInstance?.poll?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollOptionInstance, field: 'option_text', 'error')} required">
	<label for="option_text">
		<g:message code="pollOption.option_text.label" default="Optiontext" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="option_text" maxlength="100" required="" value="${pollOptionInstance?.option_text}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollOptionInstance, field: 'option_desc', 'error')} ">
	<label for="option_desc">
		<g:message code="pollOption.option_desc.label" default="Optiondesc" />
		
	</label>
	<g:textArea name="option_desc" cols="40" rows="5" maxlength="500" value="${pollOptionInstance?.option_desc}"/>

</div>

%{--<div class="fieldcontain ${hasErrors(bean: pollOptionInstance, field: 'create_time', 'error')} ">--}%
	%{--<label for="create_time">--}%
		%{--<g:message code="pollOption.create_time.label" default="Createtime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="create_time" precision="day"  value="${pollOptionInstance?.create_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: pollOptionInstance, field: 'update_time', 'error')} ">--}%
	%{--<label for="update_time">--}%
		%{--<g:message code="pollOption.update_time.label" default="Updatetime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="update_time" precision="day"  value="${pollOptionInstance?.update_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

