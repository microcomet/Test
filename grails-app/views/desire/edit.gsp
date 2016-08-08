<%@ page import="smartcommunity.Desire" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'desire.label', default: 'Desire')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#edit-desire" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-desire" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${desireInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${desireInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:desireInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${desireInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
					<div class="fieldcontain ${hasErrors(bean: desireInstance, field: 'helper', 'error')} ">
						<label for="helper">
							<g:message code="desire.helper.label" default="Helper" />

						</label>
						<g:select id="helper" name="helper.id" from="${smartcommunity.User.list()}" optionKey="id" value="${desireInstance?.helper?.id}" class="many-to-one" noSelection="['null': '']"/>

					</div>

				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
