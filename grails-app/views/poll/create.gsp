<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'poll.label', default: 'Poll')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>


	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="<g:createLink controller="poll" action="index"/>" class="current">民意征询管理</a>
				<a href="#" class="current">新建征询</a>
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

			<g:hasErrors bean="${pollInstance}">

				<div class="alert alert-error alert-block"> <a class="close" data-dismiss="alert" href="#">×</a>
					<h4 class="alert-heading">错误!</h4>

				<g:eachError bean="${pollInstance}" var="error">
					<g:message error="${error}"/></br>
				</g:eachError>

				</div>
			</g:hasErrors>


			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title"> <span class="icon"> <i class="icon-info-sign"></i> </span>
							<h5>新建征询</h5>
						</div>
						<div class="widget-content nopadding">
							<g:uploadForm url="[resource:pollInstance, action:'save']" class="form-horizontal">
							%{--<form class="form-horizontal" method="post" action="#" name="basic_validate" id="basic_validate" novalidate="novalidate">--}%
								<g:render template="form"/>


								<div class="form-actions">
									%{--<input type="submit" value="Validate" class="btn btn-success">--}%
									<g:submitButton name="create" class="btn btn-success" value="新建" />
								</div>
							</g:uploadForm>

						</div>
					</div>
				</div>
			</div>

		</div>
	</div>








	</body>
</html>
