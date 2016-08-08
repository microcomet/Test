
<%@ page import="smartcommunity.ServiceItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'serviceItem.label', default: 'ServiceItem')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-serviceItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-serviceItem" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list serviceItem">
			
				<g:if test="${serviceItemInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="serviceItem.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${serviceItemInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceItemInstance?.detail}">
				<li class="fieldcontain">
					<span id="detail-label" class="property-label"><g:message code="serviceItem.detail.label" default="Detail" /></span>
					
						<span class="property-value" aria-labelledby="detail-label"><g:fieldValue bean="${serviceItemInstance}" field="detail"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceItemInstance?.department}">
				<li class="fieldcontain">
					<span id="department-label" class="property-label"><g:message code="serviceItem.department.label" default="Department" /></span>
					
						<span class="property-value" aria-labelledby="department-label"><g:link controller="serviceDepartment" action="show" id="${serviceItemInstance?.department?.id}">${serviceItemInstance?.department?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceItemInstance?.create_time}">
				<li class="fieldcontain">
					<span id="create_time-label" class="property-label"><g:message code="serviceItem.create_time.label" default="Createtime" /></span>
					
						<span class="property-value" aria-labelledby="create_time-label"><g:formatDate date="${serviceItemInstance?.create_time}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceItemInstance?.update_time}">
				<li class="fieldcontain">
					<span id="update_time-label" class="property-label"><g:message code="serviceItem.update_time.label" default="Updatetime" /></span>
					
						<span class="property-value" aria-labelledby="update_time-label"><g:formatDate date="${serviceItemInstance?.update_time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:serviceItemInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${serviceItemInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
