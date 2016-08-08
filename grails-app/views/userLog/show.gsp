
<%@ page import="smartcommunity.UserLog" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userLog.label', default: 'UserLog')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-userLog" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-userLog" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list userLog">
			
				<g:if test="${userLogInstance?.operator}">
				<li class="fieldcontain">
					<span id="operator-label" class="property-label"><g:message code="userLog.operator.label" default="Operator" /></span>
					
						<span class="property-value" aria-labelledby="operator-label"><g:fieldValue bean="${userLogInstance}" field="operator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userLogInstance?.operate}">
				<li class="fieldcontain">
					<span id="operate-label" class="property-label"><g:message code="userLog.operate.label" default="Operate" /></span>
					
						<span class="property-value" aria-labelledby="operate-label"><g:fieldValue bean="${userLogInstance}" field="operate"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userLogInstance?.table_name}">
				<li class="fieldcontain">
					<span id="table_name-label" class="property-label"><g:message code="userLog.table_name.label" default="Tablename" /></span>
					
						<span class="property-value" aria-labelledby="table_name-label"><g:fieldValue bean="${userLogInstance}" field="table_name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userLogInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="userLog.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${userLogInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userLogInstance?.operate_time}">
				<li class="fieldcontain">
					<span id="operate_time-label" class="property-label"><g:message code="userLog.operate_time.label" default="Operatetime" /></span>
					
						<span class="property-value" aria-labelledby="operate_time-label"><g:formatDate date="${userLogInstance?.operate_time}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${userLogInstance?.create_time}">
				<li class="fieldcontain">
					<span id="create_time-label" class="property-label"><g:message code="userLog.create_time.label" default="Createtime" /></span>
					
						<span class="property-value" aria-labelledby="create_time-label"><g:formatDate date="${userLogInstance?.create_time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:userLogInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${userLogInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
