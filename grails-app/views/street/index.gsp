
<%@ page import="smartcommunity.Street" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'street.label', default: 'Street')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>


	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="#" class="current">街道管理</a>
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
			<p>
				<a href="<g:createLink controller="street" action="create"/> " class="btn btn-primary">新建街道</a>
			</p>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
							<h5>街道列表</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped">
								<thead>
								<tr>
									<th>ID</th>
									<th>街道名称</th>
									<th>编码</th>
									<th>负责人</th>
									<th>电话</th>
									<th>创建时间</th>
									<th>操作</th>
								</tr>
								</thead>

								<g:each in="${streetInstanceList}" status="i" var="street">
								<tr class="${(i % 2) == 0 ? 'even gradeC' : 'odd gradeX'}" >
									<td>${street.id}</td>
									<td>${street.name}</td>
									<td>${street.code}</td>
									<td>${street.charger}</td>
									<td>${street.charger_mobile}</td>
									<td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${street.create_time}"/>  </td>
									<td>
										<div class="fr">
											<a href="<g:createLink controller="street" action="edit" id="${street.id}"/>" class="btn btn-primary btn-mini">修改</a>
											<a href="<g:createLink controller="community" action="index" id="${street.id}"/>" class="btn btn-success btn-mini">社区管理</a>
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
						<g:paginate total="${streetInstanceCount ?: 0}" />
					</div>
				</div>
			</div>
		</div>
	</div>




		%{--<a href="#list-street" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--}%
		%{--<div class="nav" role="navigation">--}%
			%{--<ul>--}%
				%{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
				%{--<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
			%{--</ul>--}%
		%{--</div>--}%
		%{--<div id="list-street" class="content scaffold-list" role="main">--}%
			%{--<h1><g:message code="default.list.label" args="[entityName]" /></h1>--}%
			%{--<g:if test="${flash.message}">--}%
				%{--<div class="message" role="status">${flash.message}</div>--}%
			%{--</g:if>--}%
			%{--<table>--}%
			%{--<thead>--}%
					%{--<tr>--}%
					%{----}%
						%{--<g:sortableColumn property="name" title="${message(code: 'street.name.label', default: 'Name')}" />--}%
					%{----}%
						%{--<g:sortableColumn property="description" title="${message(code: 'street.description.label', default: 'Description')}" />--}%
					%{----}%
						%{--<g:sortableColumn property="code" title="${message(code: 'street.code.label', default: 'Code')}" />--}%
					%{----}%
						%{--<th><g:message code="street.charger.label" default="Charger" /></th>--}%
					%{----}%
						%{--<g:sortableColumn property="create_time" title="${message(code: 'street.create_time.label', default: 'Createtime')}" />--}%
					%{----}%
						%{--<g:sortableColumn property="update_time" title="${message(code: 'street.update_time.label', default: 'Updatetime')}" />--}%
					%{----}%
					%{--</tr>--}%
				%{--</thead>--}%
				%{--<tbody>--}%
				%{--<g:each in="${streetInstanceList}" status="i" var="streetInstance">--}%
					%{--<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">--}%
					%{----}%
						%{--<td><g:link action="show" id="${streetInstance.id}">${fieldValue(bean: streetInstance, field: "name")}</g:link></td>--}%
					%{----}%
						%{--<td>${fieldValue(bean: streetInstance, field: "description")}</td>--}%
					%{----}%
						%{--<td>${fieldValue(bean: streetInstance, field: "code")}</td>--}%
					%{----}%
						%{--<td>${fieldValue(bean: streetInstance, field: "charger")}</td>--}%
					%{----}%
						%{--<td><g:formatDate date="${streetInstance.create_time}" /></td>--}%
					%{----}%
						%{--<td><g:formatDate date="${streetInstance.update_time}" /></td>--}%
					%{----}%
					%{--</tr>--}%
				%{--</g:each>--}%
				%{--</tbody>--}%
			%{--</table>--}%
			%{--<div class="pagination">--}%
				%{--<g:paginate total="${streetInstanceCount ?: 0}" />--}%
			%{--</div>--}%
		%{--</div>--}%
	</body>
</html>
