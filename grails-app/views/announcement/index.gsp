
<%@ page import="smartcommunity.Announcement" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'announcement.label', default: 'Announcement')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>



	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="#" class="current">公告管理</a>
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
				<a href="<g:createLink controller="announcement" action="create"/> " class="btn btn-primary">发布公告</a>
			</p>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
							<h5>公告列表</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped">
								<thead>
								<tr>
									<th>ID</th>
									<th>标题</th>
									<th>所属街道</th>
									<th>所属社区</th>
									<th>创建时间</th>
									<th>状态</th>
									<th>操作</th>
								</tr>
								</thead>

								<g:each in="${announcementInstanceList}" status="i" var="announcement">
									<tr class="${(i % 2) == 0 ? 'even gradeC' : 'odd gradeX'}" >
										<td>${announcement.id}</td>
										<td>${announcement.title}</td>
										<td>${announcement.street?.name}</td>
										<td>${announcement.community?.name}</td>
										<td>${announcement.create_time.format("yyyy-MM-dd HH:mm:ss")}</td>
										<td>
											<g:set var="lab" value=""/>
											<g:if test="${announcement.status==1}">
												<g:set var="lab" value="label-success"/>
											</g:if>
											<g:elseif test="${announcement.status==2}">
												<g:set var="lab" value="label-warning"/>
											</g:elseif>

											<span class="label ${lab}">
												<g:message message="announcement.status.${announcement.status}"/>
											</span>
										</td>
										<td>
											<div class="fr">
												<a href="<g:createLink controller="announcement" action="edit" id="${announcement.id}"/>" class="btn btn-primary btn-mini">修改</a>
												<a href="<g:createLink controller="announcement" action="show" id="${announcement.id}"/>" class="btn btn-success btn-mini">详情</a>
												<g:if test="${announcement.status==1}">
													<a href="<g:createLink controller="announcement" action="update" id="${announcement.id}" params="[status:2]"/>" class="btn btn-danger btn-mini">关闭</a>
												</g:if>
												<g:else>
													<a href="<g:createLink controller="announcement" action="update" id="${announcement.id}" params="[status:1]"/>" class="btn btn-warning btn-mini">恢复</a>
												</g:else>
											</div>
										</td>
									</tr>
								</g:each>

							</tbody>
							</table>
						</div>
					</div>
					<div class="pagination">
						<g:paginate total="${announcementInstanceCount ?: 0}" />
					</div>
				</div>
			</div>
		</div>
	</div>














	%{--<a href="#list-announcement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--}%
		%{--<div class="nav" role="navigation">--}%
			%{--<ul>--}%
				%{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
				%{--<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
			%{--</ul>--}%
		%{--</div>--}%
		%{--<div id="list-announcement" class="content scaffold-list" role="main">--}%
			%{--<h1><g:message code="default.list.label" args="[entityName]" /></h1>--}%
			%{--<g:if test="${flash.message}">--}%
				%{--<div class="message" role="status">${flash.message}</div>--}%
			%{--</g:if>--}%
			%{--<table>--}%
			%{--<thead>--}%
					%{--<tr>--}%
					%{----}%
						%{--<g:sortableColumn property="title" title="${message(code: 'announcement.title.label', default: 'Title')}" />--}%
					%{----}%
						%{--<g:sortableColumn property="content" title="${message(code: 'announcement.content.label', default: 'Content')}" />--}%
					%{----}%
						%{--<g:sortableColumn property="close_time" title="${message(code: 'announcement.close_time.label', default: 'Closetime')}" />--}%
					%{----}%
						%{--<th><g:message code="announcement.closer.label" default="Closer" /></th>--}%
					%{----}%
						%{--<th><g:message code="announcement.community.label" default="Community" /></th>--}%
					%{----}%
						%{--<g:sortableColumn property="create_time" title="${message(code: 'announcement.create_time.label', default: 'Createtime')}" />--}%
					%{----}%
					%{--</tr>--}%
				%{--</thead>--}%
				%{--<tbody>--}%
				%{--<g:each in="${announcementInstanceList}" status="i" var="announcementInstance">--}%
					%{--<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">--}%
					%{----}%
						%{--<td><g:link action="show" id="${announcementInstance.id}">${fieldValue(bean: announcementInstance, field: "title")}</g:link></td>--}%
					%{----}%
						%{--<td>${fieldValue(bean: announcementInstance, field: "content")}</td>--}%
					%{----}%
						%{--<td><g:formatDate date="${announcementInstance.close_time}" /></td>--}%
					%{----}%
						%{--<td>${fieldValue(bean: announcementInstance, field: "closer")}</td>--}%
					%{----}%
						%{--<td>${fieldValue(bean: announcementInstance, field: "community")}</td>--}%
					%{----}%
						%{--<td><g:formatDate date="${announcementInstance.create_time}" /></td>--}%
					%{----}%
					%{--</tr>--}%
				%{--</g:each>--}%
				%{--</tbody>--}%
			%{--</table>--}%
			%{--<div class="pagination">--}%
				%{--<g:paginate total="${announcementInstanceCount ?: 0}" />--}%
			%{--</div>--}%
		%{--</div>--}%
	</body>
</html>
