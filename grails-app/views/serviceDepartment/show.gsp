
<%@ page import="smartcommunity.ServiceDepartment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'serviceDepartment.label', default: 'ServiceDepartment')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-serviceDepartment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-serviceDepartment" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list serviceDepartment">
			
				<g:if test="${serviceDepartmentInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="serviceDepartment.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${serviceDepartmentInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceDepartmentInstance?.street}">
				<li class="fieldcontain">
					<span id="street-label" class="property-label"><g:message code="serviceDepartment.street.label" default="Street" /></span>
					
						<span class="property-value" aria-labelledby="street-label"><g:link controller="street" action="show" id="${serviceDepartmentInstance?.street?.id}">${serviceDepartmentInstance?.street?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceDepartmentInstance?.address}">
				<li class="fieldcontain">
					<span id="address-label" class="property-label"><g:message code="serviceDepartment.address.label" default="Address" /></span>
					
						<span class="property-value" aria-labelledby="address-label"><g:fieldValue bean="${serviceDepartmentInstance}" field="address"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceDepartmentInstance?.community}">
				<li class="fieldcontain">
					<span id="community-label" class="property-label"><g:message code="serviceDepartment.community.label" default="Community" /></span>
					
						<span class="property-value" aria-labelledby="community-label"><g:link controller="community" action="show" id="${serviceDepartmentInstance?.community?.id}">${serviceDepartmentInstance?.community?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceDepartmentInstance?.create_time}">
				<li class="fieldcontain">
					<span id="create_time-label" class="property-label"><g:message code="serviceDepartment.create_time.label" default="Createtime" /></span>
					
						<span class="property-value" aria-labelledby="create_time-label"><g:formatDate date="${serviceDepartmentInstance?.create_time}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceDepartmentInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="serviceDepartment.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${serviceDepartmentInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceDepartmentInstance?.update_time}">
				<li class="fieldcontain">
					<span id="update_time-label" class="property-label"><g:message code="serviceDepartment.update_time.label" default="Updatetime" /></span>
					
						<span class="property-value" aria-labelledby="update_time-label"><g:formatDate date="${serviceDepartmentInstance?.update_time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:serviceDepartmentInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${serviceDepartmentInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
