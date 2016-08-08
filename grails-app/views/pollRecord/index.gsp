
<%@ page import="smartcommunity.PollRecord" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'pollRecord.label', default: 'PollRecord')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-pollRecord" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-pollRecord" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="pollRecord.poll.label" default="Poll" /></th>
					
						<th><g:message code="pollRecord.voter.label" default="Voter" /></th>
					
						<g:sortableColumn property="vote_time" title="${message(code: 'pollRecord.vote_time.label', default: 'Votetime')}" />
					
						<th><g:message code="pollRecord.pollOption.label" default="Poll Option" /></th>
					
						<g:sortableColumn property="score" title="${message(code: 'pollRecord.score.label', default: 'Score')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'pollRecord.status.label', default: 'Status')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${pollRecordInstanceList}" status="i" var="pollRecordInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${pollRecordInstance.id}">${fieldValue(bean: pollRecordInstance, field: "poll")}</g:link></td>
					
						<td>${fieldValue(bean: pollRecordInstance, field: "voter")}</td>
					
						<td><g:formatDate date="${pollRecordInstance.vote_time}" /></td>
					
						<td>${fieldValue(bean: pollRecordInstance, field: "pollOption")}</td>
					
						<td>${fieldValue(bean: pollRecordInstance, field: "score")}</td>
					
						<td>${fieldValue(bean: pollRecordInstance, field: "status")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="paginationpage">
				<g:paginate total="${pollRecordInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
