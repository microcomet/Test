
<%@ page import="smartcommunity.Image" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'image.label', default: 'Image')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-image" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-image" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list image">
			
				<g:if test="${imageInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="image.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${imageInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${imageInstance?.storage_url}">
				<li class="fieldcontain">
					<span id="storage_url-label" class="property-label"><g:message code="image.storage_url.label" default="Storageurl" /></span>
					
						<span class="property-value" aria-labelledby="storage_url-label"><g:fieldValue bean="${imageInstance}" field="storage_url"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${imageInstance?.upload_time}">
				<li class="fieldcontain">
					<span id="upload_time-label" class="property-label"><g:message code="image.upload_time.label" default="Uploadtime" /></span>
					
						<span class="property-value" aria-labelledby="upload_time-label"><g:formatDate date="${imageInstance?.upload_time}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${imageInstance?.create_time}">
				<li class="fieldcontain">
					<span id="create_time-label" class="property-label"><g:message code="image.create_time.label" default="Createtime" /></span>
					
						<span class="property-value" aria-labelledby="create_time-label"><g:formatDate date="${imageInstance?.create_time}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${imageInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="image.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${imageInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${imageInstance?.update_time}">
				<li class="fieldcontain">
					<span id="update_time-label" class="property-label"><g:message code="image.update_time.label" default="Updatetime" /></span>
					
						<span class="property-value" aria-labelledby="update_time-label"><g:formatDate date="${imageInstance?.update_time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:imageInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${imageInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
