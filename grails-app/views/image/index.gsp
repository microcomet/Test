
<%@ page import="smartcommunity.Image" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'image.label', default: 'Image')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-image" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-image" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'image.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="storage_url" title="${message(code: 'image.storage_url.label', default: 'Storageurl')}" />
					
						<g:sortableColumn property="upload_time" title="${message(code: 'image.upload_time.label', default: 'Uploadtime')}" />
					
						<g:sortableColumn property="create_time" title="${message(code: 'image.create_time.label', default: 'Createtime')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'image.status.label', default: 'Status')}" />
					
						<g:sortableColumn property="update_time" title="${message(code: 'image.update_time.label', default: 'Updatetime')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${imageInstanceList}" status="i" var="imageInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${imageInstance.id}">${fieldValue(bean: imageInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: imageInstance, field: "storage_url")}</td>
					
						<td><g:formatDate date="${imageInstance.upload_time}" /></td>
					
						<td><g:formatDate date="${imageInstance.create_time}" /></td>
					
						<td>${fieldValue(bean: imageInstance, field: "status")}</td>
					
						<td><g:formatDate date="${imageInstance.update_time}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="paginationpage">
				<g:paginate total="${imageInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
