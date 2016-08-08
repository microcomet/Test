
<%@ page import="smartcommunity.PollOption" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'pollOption.label', default: 'PollOption')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-pollOption" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-pollOption" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list pollOption">
			
				<g:if test="${pollOptionInstance?.poll}">
				<li class="fieldcontain">
					<span id="poll-label" class="property-label"><g:message code="pollOption.poll.label" default="Poll" /></span>
					
						<span class="property-value" aria-labelledby="poll-label"><g:link controller="poll" action="show" id="${pollOptionInstance?.poll?.id}">${pollOptionInstance?.poll?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollOptionInstance?.option_text}">
				<li class="fieldcontain">
					<span id="option_text-label" class="property-label"><g:message code="pollOption.option_text.label" default="Optiontext" /></span>
					
						<span class="property-value" aria-labelledby="option_text-label"><g:fieldValue bean="${pollOptionInstance}" field="option_text"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollOptionInstance?.option_desc}">
				<li class="fieldcontain">
					<span id="option_desc-label" class="property-label"><g:message code="pollOption.option_desc.label" default="Optiondesc" /></span>
					
						<span class="property-value" aria-labelledby="option_desc-label"><g:fieldValue bean="${pollOptionInstance}" field="option_desc"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollOptionInstance?.create_time}">
				<li class="fieldcontain">
					<span id="create_time-label" class="property-label"><g:message code="pollOption.create_time.label" default="Createtime" /></span>
					
						<span class="property-value" aria-labelledby="create_time-label"><g:formatDate date="${pollOptionInstance?.create_time}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollOptionInstance?.update_time}">
				<li class="fieldcontain">
					<span id="update_time-label" class="property-label"><g:message code="pollOption.update_time.label" default="Updatetime" /></span>
					
						<span class="property-value" aria-labelledby="update_time-label"><g:formatDate date="${pollOptionInstance?.update_time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:pollOptionInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${pollOptionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
