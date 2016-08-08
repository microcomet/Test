
<%@ page import="smartcommunity.PollRecord" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'pollRecord.label', default: 'PollRecord')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-pollRecord" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-pollRecord" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list pollRecord">
			
				<g:if test="${pollRecordInstance?.poll}">
				<li class="fieldcontain">
					<span id="poll-label" class="property-label"><g:message code="pollRecord.poll.label" default="Poll" /></span>
					
						<span class="property-value" aria-labelledby="poll-label"><g:link controller="poll" action="show" id="${pollRecordInstance?.poll?.id}">${pollRecordInstance?.poll?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollRecordInstance?.voter}">
				<li class="fieldcontain">
					<span id="voter-label" class="property-label"><g:message code="pollRecord.voter.label" default="Voter" /></span>
					
						<span class="property-value" aria-labelledby="voter-label"><g:link controller="user" action="show" id="${pollRecordInstance?.voter?.id}">${pollRecordInstance?.voter?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollRecordInstance?.vote_time}">
				<li class="fieldcontain">
					<span id="vote_time-label" class="property-label"><g:message code="pollRecord.vote_time.label" default="Votetime" /></span>
					
						<span class="property-value" aria-labelledby="vote_time-label"><g:formatDate date="${pollRecordInstance?.vote_time}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollRecordInstance?.pollOption}">
				<li class="fieldcontain">
					<span id="pollOption-label" class="property-label"><g:message code="pollRecord.pollOption.label" default="Poll Option" /></span>
					
						<span class="property-value" aria-labelledby="pollOption-label"><g:link controller="pollOption" action="show" id="${pollRecordInstance?.pollOption?.id}">${pollRecordInstance?.pollOption?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollRecordInstance?.score}">
				<li class="fieldcontain">
					<span id="score-label" class="property-label"><g:message code="pollRecord.score.label" default="Score" /></span>
					
						<span class="property-value" aria-labelledby="score-label"><g:fieldValue bean="${pollRecordInstance}" field="score"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollRecordInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="pollRecord.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${pollRecordInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollRecordInstance?.create_time}">
				<li class="fieldcontain">
					<span id="create_time-label" class="property-label"><g:message code="pollRecord.create_time.label" default="Createtime" /></span>
					
						<span class="property-value" aria-labelledby="create_time-label"><g:formatDate date="${pollRecordInstance?.create_time}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollRecordInstance?.update_time}">
				<li class="fieldcontain">
					<span id="update_time-label" class="property-label"><g:message code="pollRecord.update_time.label" default="Updatetime" /></span>
					
						<span class="property-value" aria-labelledby="update_time-label"><g:formatDate date="${pollRecordInstance?.update_time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:pollRecordInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${pollRecordInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
