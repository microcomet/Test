<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>



	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="<g:createLink controller="user" action="index" params="[roleLv:params.roleLv]"/>" class="current">用户管理</a>
				<a href="#" class="current">新建用户</a>
			</div>
			%{--<h1>Tables</h1>--}%

		</div>

		<div class="container-fluid">
			<hr>

			<g:if test="${flash.message}">
				<div class="alert alert-info alert-block"> <a class="close" data-dismiss="alert" href="#">×</a>
					<h4 class="alert-heading">信息!</h4>
					${flash.message}
				</div>

			</g:if>

			<g:hasErrors bean="${userInstance}">

				<div class="alert alert-error alert-block"> <a class="close" data-dismiss="alert" href="#">×</a>
					<h4 class="alert-heading">错误!</h4>

				<g:eachError bean="${userInstance}" var="error">
					<g:message error="${error}"/></br>
				</g:eachError>

				</div>
			</g:hasErrors>


			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title"> <span class="icon"> <i class="icon-info-sign"></i> </span>
							<h5>新建用户</h5>
						</div>
						<div class="widget-content nopadding">
							<g:form url="[resource:userInstance, action:'save']" class="form-horizontal">
								<input type="hidden" name="roleLv" value="${params.roleLv}">
							%{--<form class="form-horizontal" method="post" action="#" name="basic_validate" id="basic_validate" novalidate="novalidate">--}%
								<g:render template="form"/>


								<div class="form-actions">
									%{--<input type="submit" value="Validate" class="btn btn-success">--}%
									<g:submitButton name="create" class="btn btn-success" value="新建" />
								</div>
							</g:form>

						</div>
					</div>
				</div>
			</div>

		</div>
	</div>






		%{--<a href="#create-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--}%
		%{--<div class="nav" role="navigation">--}%
			%{--<ul>--}%
				%{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
				%{--<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>--}%
			%{--</ul>--}%
		%{--</div>--}%
		%{--<div id="create-user" class="content scaffold-create" role="main">--}%
			%{--<h1><g:message code="default.create.label" args="[entityName]" /></h1>--}%
			%{--<g:if test="${flash.message}">--}%
			%{--<div class="message" role="status">${flash.message}</div>--}%
			%{--</g:if>--}%
			%{--<g:hasErrors bean="${userInstance}">--}%
			%{--<ul class="errors" role="alert">--}%
				%{--<g:eachError bean="${userInstance}" var="error">--}%
				%{--<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>--}%
				%{--</g:eachError>--}%
			%{--</ul>--}%
			%{--</g:hasErrors>--}%
			%{--<g:form url="[resource:userInstance, action:'save']" >--}%
			%{--<g:form url="[ action:'save']" >--}%
				%{--<fieldset class="form">--}%
					%{--<g:render template="form"/>--}%
				%{--</fieldset>--}%
				%{--<fieldset class="buttons">--}%
					%{--<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />--}%
				%{--</fieldset>--}%
			%{--</g:form>--}%
		%{--</div>--}%





	</body>
</html>
