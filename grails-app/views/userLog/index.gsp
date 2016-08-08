
<%@ page import="smartcommunity.UserLog" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userLog.label', default: 'UserLog')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-userLog" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-userLog" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="operator" title="${message(code: 'userLog.operator.label', default: 'Operator')}" />
					
						<g:sortableColumn property="operate" title="${message(code: 'userLog.operate.label', default: 'Operate')}" />
					
						<g:sortableColumn property="table_name" title="${message(code: 'userLog.table_name.label', default: 'Tablename')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'userLog.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="operate_time" title="${message(code: 'userLog.operate_time.label', default: 'Operatetime')}" />
					
						<g:sortableColumn property="create_time" title="${message(code: 'userLog.create_time.label', default: 'Createtime')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${userLogInstanceList}" status="i" var="userLogInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${userLogInstance.id}">${fieldValue(bean: userLogInstance, field: "operator")}</g:link></td>
					
						<td>${fieldValue(bean: userLogInstance, field: "operate")}</td>
					
						<td>${fieldValue(bean: userLogInstance, field: "table_name")}</td>
					
						<td>${fieldValue(bean: userLogInstance, field: "description")}</td>
					
						<td><g:formatDate date="${userLogInstance.operate_time}" /></td>
					
						<td><g:formatDate date="${userLogInstance.create_time}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="paginationpage">
				<g:paginate total="${userLogInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
