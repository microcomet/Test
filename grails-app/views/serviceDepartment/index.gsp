
<%@ page import="smartcommunity.ServiceDepartment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'serviceDepartment.label', default: 'ServiceDepartment')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>



	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="#" class="current">部门管理</a>
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
				<a href="<g:createLink controller="serviceDepartment" action="create"/> " class="btn btn-primary">新建部门</a>
			</p>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
							<h5>部门列表</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped">
								<thead>
								<tr>
									<th>ID</th>
									<th>部门名称</th>

									<th>操作</th>
								</tr>
								</thead>

								<g:each in="${serviceDepartmentInstanceList}" status="i" var="serviceDepartment">
									<tr class="${(i % 2) == 0 ? 'even gradeC' : 'odd gradeX'}" >
										<td>${serviceDepartment.id}</td>
										<td>${serviceDepartment.name}</td>

										<td>
											<div class="fr">
												<a href="<g:createLink controller="serviceDepartment" action="edit" id="${serviceDepartment.id}"/>" class="btn btn-primary btn-mini">修改</a>
												<a href="<g:createLink controller="serviceItem" action="index" id="${serviceDepartment.id}"/>" class="btn btn-success btn-mini">业务管理</a>
												<a onclick="if (confirm('确认删除吗?删除后无法恢复!') == false)return false;"
												   href="<g:createLink controller="serviceDepartment" action="delete"
																	   id="${serviceDepartment.id}"/>"
												   class="btn btn-danger btn-mini">删除</a>
											</div>
										</td>
									</tr>
								</g:each>

							</tbody>
							</table>
						</div>
					</div>
					<div class="paginationpage">
						<g:paginate total="${serviceDepartmentInstanceCount ?: 0}" />
					</div>
				</div>
			</div>
		</div>
	</div>
















	%{--<a href="#list-serviceDepartment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--}%
		%{--<div class="nav" role="navigation">--}%
			%{--<ul>--}%
				%{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
				%{--<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
			%{--</ul>--}%
		%{--</div>--}%
		%{--<div id="list-serviceDepartment" class="content scaffold-list" role="main">--}%
			%{--<h1><g:message code="default.list.label" args="[entityName]" /></h1>--}%
			%{--<g:if test="${flash.message}">--}%
				%{--<div class="message" role="status">${flash.message}</div>--}%
			%{--</g:if>--}%
			%{--<table>--}%
			%{--<thead>--}%
					%{--<tr>--}%

						%{--<g:sortableColumn property="name" title="${message(code: 'serviceDepartment.name.label', default: 'Name')}" />--}%

						%{--<th><g:message code="serviceDepartment.street.label" default="Street" /></th>--}%

						%{--<g:sortableColumn property="address" title="${message(code: 'serviceDepartment.address.label', default: 'Address')}" />--}%

						%{--<th><g:message code="serviceDepartment.community.label" default="Community" /></th>--}%

						%{--<g:sortableColumn property="create_time" title="${message(code: 'serviceDepartment.create_time.label', default: 'Createtime')}" />--}%

						%{--<g:sortableColumn property="description" title="${message(code: 'serviceDepartment.description.label', default: 'Description')}" />--}%

					%{--</tr>--}%
				%{--</thead>--}%
				%{--<tbody>--}%
				%{--<g:each in="${serviceDepartmentInstanceList}" status="i" var="serviceDepartmentInstance">--}%
					%{--<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">--}%

						%{--<td><g:link action="show" id="${serviceDepartmentInstance.id}">${fieldValue(bean: serviceDepartmentInstance, field: "name")}</g:link></td>--}%

						%{--<td>${fieldValue(bean: serviceDepartmentInstance, field: "street")}</td>--}%

						%{--<td>${fieldValue(bean: serviceDepartmentInstance, field: "address")}</td>--}%

						%{--<td>${fieldValue(bean: serviceDepartmentInstance, field: "community")}</td>--}%

						%{--<td><g:formatDate date="${serviceDepartmentInstance.create_time}" /></td>--}%

						%{--<td>${fieldValue(bean: serviceDepartmentInstance, field: "description")}</td>--}%

					%{--</tr>--}%
				%{--</g:each>--}%
				%{--</tbody>--}%
			%{--</table>--}%
			%{--<div class="pagination">--}%
				%{--<g:paginate total="${serviceDepartmentInstanceCount ?: 0}" />--}%
			%{--</div>--}%
		%{--</div>--}%
	</body>
</html>
