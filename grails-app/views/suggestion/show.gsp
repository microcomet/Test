
<%@ page import="smartcommunity.Suggestion" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'suggestion.label', default: 'Suggestion')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-suggestion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-suggestion" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list suggestion">
			
				<g:if test="${suggestionInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="suggestion.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${suggestionInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${suggestionInstance?.content}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="suggestion.content.label" default="Content" /></span>
					
						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${suggestionInstance}" field="content"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${suggestionInstance?.close_time}">
				<li class="fieldcontain">
					<span id="close_time-label" class="property-label"><g:message code="suggestion.close_time.label" default="Closetime" /></span>
					
						<span class="property-value" aria-labelledby="close_time-label"><g:formatDate date="${suggestionInstance?.close_time}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${suggestionInstance?.closer}">
				<li class="fieldcontain">
					<span id="closer-label" class="property-label"><g:message code="suggestion.closer.label" default="Closer" /></span>
					
						<span class="property-value" aria-labelledby="closer-label"><g:link controller="user" action="show" id="${suggestionInstance?.closer?.id}">${suggestionInstance?.closer?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${suggestionInstance?.community}">
				<li class="fieldcontain">
					<span id="community-label" class="property-label"><g:message code="suggestion.community.label" default="Community" /></span>
					
						<span class="property-value" aria-labelledby="community-label"><g:link controller="community" action="show" id="${suggestionInstance?.community?.id}">${suggestionInstance?.community?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${suggestionInstance?.create_time}">
				<li class="fieldcontain">
					<span id="create_time-label" class="property-label"><g:message code="suggestion.create_time.label" default="Createtime" /></span>
					
						<span class="property-value" aria-labelledby="create_time-label"><g:formatDate date="${suggestionInstance?.create_time}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${suggestionInstance?.publisher}">
				<li class="fieldcontain">
					<span id="publisher-label" class="property-label"><g:message code="suggestion.publisher.label" default="Publisher" /></span>
					
						<span class="property-value" aria-labelledby="publisher-label"><g:link controller="user" action="show" id="${suggestionInstance?.publisher?.id}">${suggestionInstance?.publisher?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${suggestionInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="suggestion.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${suggestionInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${suggestionInstance?.street}">
				<li class="fieldcontain">
					<span id="street-label" class="property-label"><g:message code="suggestion.street.label" default="Street" /></span>
					
						<span class="property-value" aria-labelledby="street-label"><g:link controller="street" action="show" id="${suggestionInstance?.street?.id}">${suggestionInstance?.street?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${suggestionInstance?.update_time}">
				<li class="fieldcontain">
					<span id="update_time-label" class="property-label"><g:message code="suggestion.update_time.label" default="Updatetime" /></span>
					
						<span class="property-value" aria-labelledby="update_time-label"><g:formatDate date="${suggestionInstance?.update_time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:suggestionInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${suggestionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
