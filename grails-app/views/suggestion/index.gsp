
<%@ page import="smartcommunity.Suggestion" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'suggestion.label', default: 'Suggestion')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>






		<a href="#list-suggestion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-suggestion" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="title" title="${message(code: 'suggestion.title.label', default: 'Title')}" />
					
						<g:sortableColumn property="content" title="${message(code: 'suggestion.content.label', default: 'Content')}" />
					
						<g:sortableColumn property="close_time" title="${message(code: 'suggestion.close_time.label', default: 'Closetime')}" />
					
						<th><g:message code="suggestion.closer.label" default="Closer" /></th>
					
						<th><g:message code="suggestion.community.label" default="Community" /></th>
					
						<g:sortableColumn property="create_time" title="${message(code: 'suggestion.create_time.label', default: 'Createtime')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${suggestionInstanceList}" status="i" var="suggestionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${suggestionInstance.id}">${fieldValue(bean: suggestionInstance, field: "title")}</g:link></td>
					
						<td>${fieldValue(bean: suggestionInstance, field: "content")}</td>
					
						<td><g:formatDate date="${suggestionInstance.close_time}" /></td>
					
						<td>${fieldValue(bean: suggestionInstance, field: "closer")}</td>
					
						<td>${fieldValue(bean: suggestionInstance, field: "community")}</td>
					
						<td><g:formatDate date="${suggestionInstance.create_time}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="paginationpage">
				<g:paginate total="${suggestionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
