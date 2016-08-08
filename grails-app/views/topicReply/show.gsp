
<%@ page import="smartcommunity.TopicReply" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'topicReply.label', default: 'TopicReply')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-topicReply" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-topicReply" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list topicReply">
			
				<g:if test="${topicReplyInstance?.topic_id}">
				<li class="fieldcontain">
					<span id="topic_id-label" class="property-label"><g:message code="topicReply.topic_id.label" default="Topicid" /></span>
					
						<span class="property-value" aria-labelledby="topic_id-label"><g:fieldValue bean="${topicReplyInstance}" field="topic_id"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${topicReplyInstance?.publisher}">
				<li class="fieldcontain">
					<span id="publisher-label" class="property-label"><g:message code="topicReply.publisher.label" default="Publisher" /></span>
					
						<span class="property-value" aria-labelledby="publisher-label"><g:fieldValue bean="${topicReplyInstance}" field="publisher"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${topicReplyInstance?.content}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="topicReply.content.label" default="Content" /></span>
					
						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${topicReplyInstance}" field="content"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${topicReplyInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="topicReply.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${topicReplyInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${topicReplyInstance?.create_time}">
				<li class="fieldcontain">
					<span id="create_time-label" class="property-label"><g:message code="topicReply.create_time.label" default="Createtime" /></span>
					
						<span class="property-value" aria-labelledby="create_time-label"><g:formatDate date="${topicReplyInstance?.create_time}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${topicReplyInstance?.update_time}">
				<li class="fieldcontain">
					<span id="update_time-label" class="property-label"><g:message code="topicReply.update_time.label" default="Updatetime" /></span>
					
						<span class="property-value" aria-labelledby="update_time-label"><g:formatDate date="${topicReplyInstance?.update_time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:topicReplyInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${topicReplyInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
