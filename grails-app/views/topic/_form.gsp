<%@ page import="smartcommunity.Topic" %>



<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="topic.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" maxlength="250" required="" value="${topicInstance?.title}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'content', 'error')} required">
	<label for="content">
		<g:message code="topic.content.label" default="Content" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="content" cols="40" rows="5" maxlength="2000" required="" value="${topicInstance?.content}"/>

</div>

%{--<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'status', 'error')} required">--}%
	%{--<label for="status">--}%
		%{--<g:message code="topic.status.label" default="Status" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:field name="status" type="number" value="${topicInstance.status}" required=""/>--}%

%{--</div>--}%

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'promoter', 'error')} required">
	<label for="promoter">
		<g:message code="topic.promoter.label" default="Promoter" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="promoter" name="promoter.id" from="${smartcommunity.User.list()}" optionKey="id" required="" value="${topicInstance?.promoter?.id}" class="many-to-one"/>

</div>

%{--<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'auditing_desc', 'error')} ">--}%
	%{--<label for="auditing_desc">--}%
		%{--<g:message code="topic.auditing_desc.label" default="Auditingdesc" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:textField name="auditing_desc" value="${topicInstance?.auditing_desc}"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'auditing_time', 'error')} ">--}%
	%{--<label for="auditing_time">--}%
		%{--<g:message code="topic.auditing_time.label" default="Auditingtime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="auditing_time" precision="day"  value="${topicInstance?.auditing_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'clerk', 'error')} ">--}%
	%{--<label for="clerk">--}%
		%{--<g:message code="topic.clerk.label" default="Clerk" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:select id="clerk" name="clerk.id" from="${smartcommunity.User.list()}" optionKey="id" value="${topicInstance?.clerk?.id}" class="many-to-one" noSelection="['null': '']"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'close_time', 'error')} ">--}%
	%{--<label for="close_time">--}%
		%{--<g:message code="topic.close_time.label" default="Closetime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="close_time" precision="day"  value="${topicInstance?.close_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'closer', 'error')} ">--}%
	%{--<label for="closer">--}%
		%{--<g:message code="topic.closer.label" default="Closer" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:select id="closer" name="closer.id" from="${smartcommunity.User.list()}" optionKey="id" value="${topicInstance?.closer?.id}" class="many-to-one" noSelection="['null': '']"/>--}%

%{--</div>--}%

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'community', 'error')} ">
	<label for="community">
		<g:message code="topic.community.label" default="Community" />
		
	</label>
	<g:select id="community" name="community.id" from="${smartcommunity.Community.list()}" optionKey="id" value="${topicInstance?.community?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

%{--<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'create_time', 'error')} ">--}%
	%{--<label for="create_time">--}%
		%{--<g:message code="topic.create_time.label" default="Createtime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="create_time" precision="day"  value="${topicInstance?.create_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'update_time', 'error')} ">--}%
	%{--<label for="update_time">--}%
		%{--<g:message code="topic.update_time.label" default="Updatetime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="update_time" precision="day"  value="${topicInstance?.update_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

