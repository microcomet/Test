
<%@ page import="smartcommunity.Street" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'street.label', default: 'Street')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-street" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-street" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list street">
			
				<g:if test="${streetInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="street.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${streetInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${streetInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="street.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${streetInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${streetInstance?.code}">
				<li class="fieldcontain">
					<span id="code-label" class="property-label"><g:message code="street.code.label" default="Code" /></span>
					
						<span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${streetInstance}" field="code"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${streetInstance?.charger}">
				<li class="fieldcontain">
					<span id="charger-label" class="property-label"><g:message code="street.charger.label" default="Charger" /></span>
					
						<span class="property-value" aria-labelledby="charger-label"><g:link controller="user" action="show" id="${streetInstance?.charger?.id}">${streetInstance?.charger?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${streetInstance?.create_time}">
				<li class="fieldcontain">
					<span id="create_time-label" class="property-label"><g:message code="street.create_time.label" default="Createtime" /></span>
					
						<span class="property-value" aria-labelledby="create_time-label"><g:formatDate date="${streetInstance?.create_time}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${streetInstance?.update_time}">
				<li class="fieldcontain">
					<span id="update_time-label" class="property-label"><g:message code="street.update_time.label" default="Updatetime" /></span>
					
						<span class="property-value" aria-labelledby="update_time-label"><g:formatDate date="${streetInstance?.update_time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:streetInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${streetInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
