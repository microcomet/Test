
<%@ page import="smartcommunity.AnnouncementImage" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'announcementImage.label', default: 'AnnouncementImage')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-announcementImage" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-announcementImage" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list announcementImage">
			
				<g:if test="${announcementImageInstance?.announcement}">
				<li class="fieldcontain">
					<span id="announcement-label" class="property-label"><g:message code="announcementImage.announcement.label" default="Announcement" /></span>
					
						<span class="property-value" aria-labelledby="announcement-label"><g:link controller="announcement" action="show" id="${announcementImageInstance?.announcement?.id}">${announcementImageInstance?.announcement?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${announcementImageInstance?.image}">
				<li class="fieldcontain">
					<span id="image-label" class="property-label"><g:message code="announcementImage.image.label" default="Image" /></span>
					
						<span class="property-value" aria-labelledby="image-label"><g:link controller="image" action="show" id="${announcementImageInstance?.image?.id}">${announcementImageInstance?.image?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:announcementImageInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${announcementImageInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
