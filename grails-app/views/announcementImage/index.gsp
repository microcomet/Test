
<%@ page import="smartcommunity.AnnouncementImage" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'announcementImage.label', default: 'AnnouncementImage')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-announcementImage" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-announcementImage" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="announcementImage.announcement.label" default="Announcement" /></th>
					
						<th><g:message code="announcementImage.image.label" default="Image" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${announcementImageInstanceList}" status="i" var="announcementImageInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${announcementImageInstance.id}">${fieldValue(bean: announcementImageInstance, field: "announcement")}</g:link></td>
					
						<td>${fieldValue(bean: announcementImageInstance, field: "image")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${announcementImageInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
