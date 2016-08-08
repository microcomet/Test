<%@ page import="smartcommunity.Suggestion" %>



<div class="fieldcontain ${hasErrors(bean: suggestionInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="suggestion.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="title" cols="40" rows="5" maxlength="500" required="" value="${suggestionInstance?.title}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: suggestionInstance, field: 'content', 'error')} required">
	<label for="content">
		<g:message code="suggestion.content.label" default="Content" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="content" required="" value="${suggestionInstance?.content}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: suggestionInstance, field: 'close_time', 'error')} ">
	<label for="close_time">
		<g:message code="suggestion.close_time.label" default="Closetime" />
		
	</label>
	<g:datePicker name="close_time" precision="day"  value="${suggestionInstance?.close_time}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: suggestionInstance, field: 'closer', 'error')} ">
	<label for="closer">
		<g:message code="suggestion.closer.label" default="Closer" />
		
	</label>
	<g:select id="closer" name="closer.id" from="${smartcommunity.User.list()}" optionKey="id" value="${suggestionInstance?.closer?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: suggestionInstance, field: 'community', 'error')} ">
	<label for="community">
		<g:message code="suggestion.community.label" default="Community" />
		
	</label>
	<g:select id="community" name="community.id" from="${smartcommunity.Community.list()}" optionKey="id" value="${suggestionInstance?.community?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: suggestionInstance, field: 'create_time', 'error')} ">
	<label for="create_time">
		<g:message code="suggestion.create_time.label" default="Createtime" />
		
	</label>
	<g:datePicker name="create_time" precision="day"  value="${suggestionInstance?.create_time}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: suggestionInstance, field: 'publisher', 'error')} ">
	<label for="publisher">
		<g:message code="suggestion.publisher.label" default="Publisher" />
		
	</label>
	<g:select id="publisher" name="publisher.id" from="${smartcommunity.User.list()}" optionKey="id" value="${suggestionInstance?.publisher?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: suggestionInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="suggestion.status.label" default="Status" />
		
	</label>
	<g:field name="status" type="number" value="${suggestionInstance.status}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: suggestionInstance, field: 'street', 'error')} ">
	<label for="street">
		<g:message code="suggestion.street.label" default="Street" />
		
	</label>
	<g:select id="street" name="street.id" from="${smartcommunity.Street.list()}" optionKey="id" value="${suggestionInstance?.street?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: suggestionInstance, field: 'update_time', 'error')} ">
	<label for="update_time">
		<g:message code="suggestion.update_time.label" default="Updatetime" />
		
	</label>
	<g:datePicker name="update_time" precision="day"  value="${suggestionInstance?.update_time}" default="none" noSelection="['': '']" />

</div>

