<%@ page import="smartcommunity.TopicReply" %>



<div class="fieldcontain ${hasErrors(bean: topicReplyInstance, field: 'topic', 'error')} required">
	<label for="topic">
		<g:message code="topicReply.topic.label" default="Topic" />
		<span class="required-indicator">*</span>
	</label>
    <g:select id="topic" name="topic.id" from="${smartcommunity.Topic.list()}" optionKey="id" value="${topicReplyInstance?.topic?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: topicReplyInstance, field: 'publisher', 'error')} required">
	<label for="publisher">
		<g:message code="topicReply.publisher.label" default="Publisher" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="publisher" type="number" value="${topicReplyInstance.publisher}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: topicReplyInstance, field: 'content', 'error')} required">
	<label for="content">
		<g:message code="topicReply.content.label" default="Content" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="content" cols="40" rows="5" maxlength="2000" required="" value="${topicReplyInstance?.content}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: topicReplyInstance, field: 'status', 'error')} required">
	<label for="status">
		<g:message code="topicReply.status.label" default="Status" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="status" type="number" value="${topicReplyInstance.status}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: topicReplyInstance, field: 'cancel_or_shield_description', 'error')} required">
	<label for="cancel_or_shield_description">
		<g:message code="topicReply.cancel_or_shield_description.label" default="Cancel_or_shield_description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="cancel_or_shield_description" cols="40" rows="5" maxlength="2000" required="" value="${topicReplyInstance?.cancel_or_shield_description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: topicReplyInstance, field: 'create_time', 'error')} required">
	<label for="create_time">
		<g:message code="topicReply.create_time.label" default="Createtime" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="create_time" precision="day"  value="${topicReplyInstance?.create_time}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: topicReplyInstance, field: 'update_time', 'error')} required">
	<label for="update_time">
		<g:message code="topicReply.update_time.label" default="Updatetime" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="update_time" precision="day"  value="${topicReplyInstance?.update_time}"  />

</div>

