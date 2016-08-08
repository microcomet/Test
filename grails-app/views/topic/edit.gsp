<%@ page import="smartcommunity.Topic" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'topic.label', default: 'Topic')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#edit-topic" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-topic" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${topicInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${topicInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:topicInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${topicInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>

                    <div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'status', 'error')} required">
                    <label for="status">
                    <g:message code="topic.status.label" default="Status" />
                    <span class="required-indicator">*</span>
                    </label>
                    <g:field name="status" type="number" value="${topicInstance.status}" required=""/>

                    </div>
                    %{--<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'close_time', 'error')} ">--}%
                    %{--<label for="close_time">--}%
                    %{--<g:message code="topic.close_time.label" default="Closetime" />--}%

                    %{--</label>--}%
                    %{--<g:datePicker name="close_time" precision="day"  value="${topicInstance?.close_time}" default="none" noSelection="['': '']" />--}%

                    %{--</div>--}%

                    %{--<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'closer', 'error')} ">--}%
                    %{--<label for="closer">--}%
                    %{--<g:message code="topic.closer.label" default="Closer" />--}%

                    %{--</label>--}%
                    %{--<g:select id="closer" name="closer.id" from="${smartcommunity.User.list()}" optionKey="id" value="${topicInstance?.closer?.id}" class="many-to-one" noSelection="['null': '']"/>--}%

                    %{--</div>--}%
                    <div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'auditing_desc', 'error')} ">
                    <label for="auditing_desc">
                    <g:message code="topic.auditing_desc.label" default="Auditingdesc" />

                    </label>
                    <g:textField name="auditing_desc" value="${topicInstance?.auditing_desc}"/>

                    </div>

                    %{--<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'auditing_time', 'error')} ">--}%
                    %{--<label for="auditing_time">--}%
                    %{--<g:message code="topic.auditing_time.label" default="Auditingtime" />--}%

                    %{--</label>--}%
                    %{--<g:datePicker name="auditing_time" precision="day"  value="${topicInstance?.auditing_time}" default="none" noSelection="['': '']" />--}%

                    %{--</div>--}%
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
