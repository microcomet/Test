
<%@ page import="smartcommunity.PollOption" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'pollOption.label', default: 'PollOption')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-pollOption" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-pollOption" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="pollOption.poll.label" default="Poll" /></th>
					
						<g:sortableColumn property="option_text" title="${message(code: 'pollOption.option_text.label', default: 'Optiontext')}" />
					
						<g:sortableColumn property="option_desc" title="${message(code: 'pollOption.option_desc.label', default: 'Optiondesc')}" />
					
						<g:sortableColumn property="create_time" title="${message(code: 'pollOption.create_time.label', default: 'Createtime')}" />
					
						<g:sortableColumn property="update_time" title="${message(code: 'pollOption.update_time.label', default: 'Updatetime')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${pollOptionInstanceList}" status="i" var="pollOptionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${pollOptionInstance.id}">${fieldValue(bean: pollOptionInstance, field: "poll")}</g:link></td>
					
						<td>${fieldValue(bean: pollOptionInstance, field: "option_text")}</td>
					
						<td>${fieldValue(bean: pollOptionInstance, field: "option_desc")}</td>
					
						<td><g:formatDate date="${pollOptionInstance.create_time}" /></td>
					
						<td><g:formatDate date="${pollOptionInstance.update_time}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="paginationpage">
				<g:paginate total="${pollOptionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
