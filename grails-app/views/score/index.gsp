
<%@ page import="smartcommunity.Score" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'score.label', default: 'Score')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>


	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="#" class="current">积分配置管理</a>
			</div>
			%{--<h1>Tables</h1>--}%

		</div>
		<div class="container-fluid">
			<hr>
			<g:if test="${flash.message}">
				<div class="alert alert-info alert-block"><a class="close" data-dismiss="alert" href="#">×</a>
					<h4 class="alert-heading">信息!</h4>
					${flash.message}
				</div>

			</g:if>

			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
							<h5>积分列表</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped">
								<thead>
								<tr>
									<th>积分名称</th>
									<th>积分类型</th>
									<th>积分值</th>
									<th>操作</th>
								</tr>
								</thead>

								<g:each in="${scoreInstanceList}" status="i" var="score">
									<tr class="${(i % 2) == 0 ? 'even gradeC' : 'odd gradeX'}" >
										<td>${score.name}</td>
										<td>${score.type}</td>
										<td>${score.score}</td>
										<td>
											<div class="fr">
												<a href="<g:createLink controller="score" action="edit" id="${score.id}"/>" class="btn btn-primary btn-mini">修改</a>
												%{--<a href="<g:createLink controller="community" action="index" id="${street.id}"/>" class="btn btn-success btn-mini">社区管理</a>--}%
												%{--<a href="#" class="btn btn-danger btn-mini">Delete</a>--}%
											</div>
										</td>
									</tr>
								</g:each>

							</tbody>
							</table>
						</div>
					</div>
					<div class="paginationpage">
						<g:paginate total="${scoreInstanceListCount ?: 0}" />
					</div>
				</div>
			</div>
		</div>
	</div>














	%{--<a href="#list-score" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--}%
		%{--<div class="nav" role="navigation">--}%
			%{--<ul>--}%
				%{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
				%{--<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
			%{--</ul>--}%
		%{--</div>--}%
		%{--<div id="list-score" class="content scaffold-list" role="main">--}%
			%{--<h1><g:message code="default.list.label" args="[entityName]" /></h1>--}%
			%{--<g:if test="${flash.message}">--}%
				%{--<div class="message" role="status">${flash.message}</div>--}%
			%{--</g:if>--}%
			%{--<table>--}%
			%{--<thead>--}%
					%{--<tr>--}%

						%{--<g:sortableColumn property="name" title="${message(code: 'score.name.label', default: 'Name')}" />--}%

						%{--<g:sortableColumn property="type" title="${message(code: 'score.type.label', default: 'Type')}" />--}%

						%{--<g:sortableColumn property="score" title="${message(code: 'score.score.label', default: 'Score')}" />--}%

					%{--</tr>--}%
				%{--</thead>--}%
				%{--<tbody>--}%
				%{--<g:each in="${scoreInstanceList}" status="i" var="scoreInstance">--}%
					%{--<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">--}%

						%{--<td><g:link action="show" id="${scoreInstance.id}">${fieldValue(bean: scoreInstance, field: "name")}</g:link></td>--}%

						%{--<td>${fieldValue(bean: scoreInstance, field: "type")}</td>--}%

						%{--<td>${fieldValue(bean: scoreInstance, field: "score")}</td>--}%

					%{--</tr>--}%
				%{--</g:each>--}%
				%{--</tbody>--}%
			%{--</table>--}%
			%{--<div class="pagination">--}%
				%{--<g:paginate total="${scoreInstanceCount ?: 0}" />--}%
			%{--</div>--}%
		%{--</div>--}%




	</body>
</html>
