
<%@ page import="smartcommunity.Community" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'community.label', default: 'Community')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-community" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-community" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list community">
			
				<g:if test="${communityInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="community.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${communityInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${communityInstance?.code}">
				<li class="fieldcontain">
					<span id="code-label" class="property-label"><g:message code="community.code.label" default="Code" /></span>
					
						<span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${communityInstance}" field="code"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${communityInstance?.street}">
				<li class="fieldcontain">
					<span id="street-label" class="property-label"><g:message code="community.street.label" default="Street" /></span>
					
						<span class="property-value" aria-labelledby="street-label"><g:link controller="street" action="show" id="${communityInstance?.street?.id}">${communityInstance?.street?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${communityInstance?.charger}">
				<li class="fieldcontain">
					<span id="charger-label" class="property-label"><g:message code="community.charger.label" default="Charger" /></span>
					
						<span class="property-value" aria-labelledby="charger-label"><g:link controller="user" action="show" id="${communityInstance?.charger?.id}">${communityInstance?.charger?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${communityInstance?.create_time}">
				<li class="fieldcontain">
					<span id="create_time-label" class="property-label"><g:message code="community.create_time.label" default="Createtime" /></span>
					
						<span class="property-value" aria-labelledby="create_time-label"><g:formatDate date="${communityInstance?.create_time}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${communityInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="community.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${communityInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${communityInstance?.update_time}">
				<li class="fieldcontain">
					<span id="update_time-label" class="property-label"><g:message code="community.update_time.label" default="Updatetime" /></span>
					
						<span class="property-value" aria-labelledby="update_time-label"><g:formatDate date="${communityInstance?.update_time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:communityInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${communityInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
