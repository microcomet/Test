
<%@ page import="smartcommunity.TopicReply" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'topicReply.label', default: 'TopicReply')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-topicReply" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-topicReply" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="topic" title="${message(code: 'topicReply.topic.label', default: 'Topicid')}" />
					
						<g:sortableColumn property="publisher" title="${message(code: 'topicReply.publisher.label', default: 'Publisher')}" />
					
						<g:sortableColumn property="content" title="${message(code: 'topicReply.content.label', default: 'Content')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'topicReply.status.label', default: 'Status')}" />
					
						<g:sortableColumn property="create_time" title="${message(code: 'topicReply.create_time.label', default: 'Createtime')}" />
					
						<g:sortableColumn property="update_time" title="${message(code: 'topicReply.update_time.label', default: 'Updatetime')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${topicReplyInstanceList}" status="i" var="topicReplyInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${topicReplyInstance.id}">${fieldValue(bean: topicReplyInstance, field: "topic")}</g:link></td>
					
						<td>${fieldValue(bean: topicReplyInstance, field: "publisher")}</td>
					
						<td>${fieldValue(bean: topicReplyInstance, field: "content")}</td>
					
						<td>${fieldValue(bean: topicReplyInstance, field: "status")}</td>
					
						<td><g:formatDate date="${topicReplyInstance.create_time}" /></td>
					
						<td><g:formatDate date="${topicReplyInstance.update_time}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="paginationpage">
				<g:paginate total="${topicReplyInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
