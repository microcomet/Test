
<%@ page import="smartcommunity.Desire" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'desire.label', default: 'Desire')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

	<g:if test="${flash.message}">
		<div class="message" role="status">${flash.message}</div>
	</g:if>




	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="#" class="current">心愿管理</a>
			</div>
			%{--<h1>Tables</h1>--}%

		</div>
		<div class="container-fluid">
			<hr>

			<div class="controls">
				<g:form controller="desire" action="index">
					<input type="text" name="description" class="span2" placeholder="心愿" value="${params.description}">
					<input type="text" name="requester" class="span2" placeholder="发布人" value="${params.requester}">
				%{--<g:include controller="userInc" action="createUser" params="[search:1]"/>--}%


					<select name="status" style="width:120px;">
						<option value="">全部状态</option>
						<g:each in="${1..6}" var="idx">
							<option value="${idx}" <g:if test="${params.int('status')==idx}">selected</g:if> ><g:message code="desire.status.${idx}"/> </option>
						</g:each>
					</select>
					<button type="submit" style="margin-top: -10px" class="btn btn-success">搜索</button>
				</g:form>

			</div>
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
									<th width="400px">心愿</th>
									<th>发布人</th>
									<th>发布时间</th>
									<th>领取人</th>
									<th>积分</th>
									<th>状态</th>
									<th>操作</th>
								</tr>
								</thead>

								<g:each in="${desireInstanceList}" status="i" var="desireInstance">
									<tr class="${(i % 2) == 0 ? 'even gradeC' : 'odd gradeX'}" >
										<td>${desireInstance.id}</td>

										<td>${desireInstance.description}</td>

										<td>${desireInstance.requester.name}</td>


										<td><g:formatDate date="${desireInstance.create_time}" format="yyyy-MM-dd HH:mm:ss"/></td>

										<td>${desireInstance.helper?.name}</td>

										<td>${desireInstance.score}</td>

										<td>
											%{--${desireInstance.status}--}%
										<g:set var="lab" value=""/>
										<g:if test="${desireInstance.status==1}">
											<g:set var="lab" value="label-success"/>
										</g:if>
										<g:elseif test="${desireInstance.status==2}">
											<g:set var="lab" value="label-warning"/>
										</g:elseif>
										<g:elseif test="${desireInstance.status==3}">
											<g:set var="lab" value="label-important"/>
										</g:elseif>
										<g:elseif test="${desireInstance.status==4}">
											<g:set var="lab" value="label-warning"/>
										</g:elseif>
										<g:elseif test="${desireInstance.status==5}">
											<g:set var="lab" value="label-inverse"/>
										</g:elseif>


											<span class="label ${lab}">
												<g:message message="desire.status.${desireInstance.status}"/>
											</span>



											%{--<span class="label label-success">--}%
												%{--<g:message message="desire.status.1"/>--}%
											%{--</span>--}%
											%{--<span class="label label-warning">--}%
												%{--<g:message message="desire.status.2"/>--}%
											%{--</span>--}%
											%{--<span class="label label-important">--}%
												%{--<g:message message="desire.status.3"/>--}%
											%{--</span>--}%
											%{--<span class="label label-warning">--}%
												%{--<g:message message="desire.status.4"/>--}%
											%{--</span>--}%
											%{--<span class="label label-inverse">--}%
												%{--<g:message message="desire.status.5"/>--}%
											%{--</span>--}%
											%{--<span class="label">--}%
												%{--<g:message message="desire.status.6"/>--}%
											%{--</span>--}%

										</td>


										<td>
											<div class="fr">
												%{--<a href="<g:createLink controller="street" action="edit" id="${street.id}"/>" class="btn btn-primary btn-mini">修改</a>--}%
												<a href="<g:createLink controller="desire" action="show" id="${desireInstance.id}"/>" class="btn btn-success btn-mini">详情</a>
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
						<g:paginate total="${desireInstanceCount ?: 0}" />
					</div>
				</div>
			</div>
		</div>
	</div>










	%{--<a href="#list-desire" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--}%
		%{--<div class="nav" role="navigation">--}%
			%{--<ul>--}%
				%{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
				%{--<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
			%{--</ul>--}%
		%{--</div>--}%
		%{--<div id="list-desire" class="content scaffold-list" role="main">--}%
			%{--<h1><g:message code="default.list.label" args="[entityName]" /></h1>--}%
			%{--<g:if test="${flash.message}">--}%
				%{--<div class="message" role="status">${flash.message}</div>--}%
			%{--</g:if>--}%
			%{--<table>--}%
			%{--<thead>--}%
					%{--<tr>--}%
					%{----}%
						%{--<th><g:message code="desire.requester.label" default="Requester" /></th>--}%
					%{----}%
						%{--<g:sortableColumn property="title" title="${message(code: 'desire.title.label', default: 'Title')}" />--}%
					%{----}%
						%{--<g:sortableColumn property="description" title="${message(code: 'desire.description.label', default: 'Description')}" />--}%
					%{----}%
						%{--<g:sortableColumn property="score" title="${message(code: 'desire.score.label', default: 'Score')}" />--}%
					%{----}%
						%{--<g:sortableColumn property="create_time" title="${message(code: 'desire.create_time.label', default: 'Createtime')}" />--}%
					%{----}%
						%{--<th><g:message code="desire.helper.label" default="Helper" /></th>--}%
					%{----}%
					%{--</tr>--}%
				%{--</thead>--}%
				%{--<tbody>--}%
				%{--<g:each in="${desireInstanceList}" status="i" var="desireInstance">--}%
					%{--<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">--}%
					%{----}%
						%{--<td><g:link action="show" id="${desireInstance.id}">${fieldValue(bean: desireInstance, field: "requester")}</g:link></td>--}%
					%{----}%
						%{--<td>${fieldValue(bean: desireInstance, field: "title")}</td>--}%
					%{----}%
						%{--<td>${fieldValue(bean: desireInstance, field: "description")}</td>--}%
					%{----}%
						%{--<td>${fieldValue(bean: desireInstance, field: "score")}</td>--}%
					%{----}%
						%{--<td><g:formatDate date="${desireInstance.create_time}" /></td>--}%
					%{----}%
						%{--<td>${fieldValue(bean: desireInstance, field: "helper")}</td>--}%
					%{----}%
					%{--</tr>--}%
				%{--</g:each>--}%
				%{--</tbody>--}%
			%{--</table>--}%
			%{--<div class="pagination">--}%
				%{--<g:paginate total="${desireInstanceCount ?: 0}" />--}%
			%{--</div>--}%
		</div>
	</body>
</html>
