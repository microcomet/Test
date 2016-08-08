
<%@ page import="smartcommunity.Yyfw" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'yyfw.label', default: 'Yyfw')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-yyfw" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-yyfw" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list yyfw">
			
				<g:if test="${yyfwInstance?.reservePerson}">
				<li class="fieldcontain">
					<span id="reservePerson-label" class="property-label"><g:message code="yyfw.reservePerson.label" default="Reserve Person" /></span>
					
						<span class="property-value" aria-labelledby="reservePerson-label"><g:link controller="user" action="show" id="${yyfwInstance?.reservePerson?.id}">${yyfwInstance?.reservePerson?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${yyfwInstance?.checkPerson}">
				<li class="fieldcontain">
					<span id="checkPerson-label" class="property-label"><g:message code="yyfw.checkPerson.label" default="Check Person" /></span>
					
						<span class="property-value" aria-labelledby="checkPerson-label"><g:link controller="user" action="show" id="${yyfwInstance?.checkPerson?.id}">${yyfwInstance?.checkPerson?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${yyfwInstance?.orderTime}">
				<li class="fieldcontain">
					<span id="orderTime-label" class="property-label"><g:message code="yyfw.orderTime.label" default="Order Time" /></span>
					
						<span class="property-value" aria-labelledby="orderTime-label"><g:formatDate date="${yyfwInstance?.orderTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${yyfwInstance?.serverTime}">
				<li class="fieldcontain">
					<span id="serverTime-label" class="property-label"><g:message code="yyfw.serverTime.label" default="Server Time" /></span>
					
						<span class="property-value" aria-labelledby="serverTime-label"><g:formatDate date="${yyfwInstance?.serverTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${yyfwInstance?.serverDesc}">
				<li class="fieldcontain">
					<span id="serverDesc-label" class="property-label"><g:message code="yyfw.serverDesc.label" default="Server Desc" /></span>
					
						<span class="property-value" aria-labelledby="serverDesc-label"><g:fieldValue bean="${yyfwInstance}" field="serverDesc"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${yyfwInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="yyfw.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${yyfwInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${yyfwInstance?.createTime}">
				<li class="fieldcontain">
					<span id="createTime-label" class="property-label"><g:message code="yyfw.createTime.label" default="Create Time" /></span>
					
						<span class="property-value" aria-labelledby="createTime-label"><g:formatDate date="${yyfwInstance?.createTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${yyfwInstance?.updateTime}">
				<li class="fieldcontain">
					<span id="updateTime-label" class="property-label"><g:message code="yyfw.updateTime.label" default="Update Time" /></span>
					
						<span class="property-value" aria-labelledby="updateTime-label"><g:formatDate date="${yyfwInstance?.updateTime}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:yyfwInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${yyfwInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
