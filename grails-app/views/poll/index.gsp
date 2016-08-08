
<%@ page import="smartcommunity.Poll" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'poll.label', default: 'Poll')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>


	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="#" class="current">民意征询管理</a>
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
				<a href="<g:createLink controller="poll" action="create"/> " class="btn btn-primary">发布征询</a>
			</p>

			<div class="controls">
				<g:form controller="poll" action="index">

					<input type="text" name="title" class="span2" placeholder="标题" value="${params.name}">


					<select name="status" style="width:120px;">
						<option>全部状态</option>
						<g:each in="${1..4}" var="idx">
							<option value="${idx}" <g:if test="${params.int('status')==idx}">selected</g:if> ><g:message code="poll.status.${idx}"/> </option>
						</g:each>
					</select>
					<button type="submit" style="margin-top: -10px" class="btn btn-success">搜索</button>
				</g:form>

			</div>

			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
							<h5>征询列表</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped">
								<thead>
								<tr>
									<th>ID</th>
									<th>标题</th>
									<th>类型</th>
									<th>分数</th>
									<th>创建时间</th>
									<th>开始日期</th>
									<th>结束日期</th>
									<th>状态</th>
									<th>操作</th>
								</tr>
								</thead>

								<g:each in="${pollInstanceList}" status="i" var="pollInstance">
									<tr class="${(i % 2) == 0 ? 'even gradeC' : 'odd gradeX'}" >
										<td>${pollInstance.id}</td>
										<td>${pollInstance.title}</td>
										<td>${message(code:'poll.check.'+pollInstance.rule)}</td>
										<td>${pollInstance.score}</td>
										<td>${pollInstance.create_time.format("yyyy-MM-dd HH:mm:ss")}</td>
										<td><g:formatDate format="yyyy-MM-dd" date="${pollInstance.start_time}"/></td>
										<td><g:formatDate format="yyyy-MM-dd" date="${pollInstance.end_time}"/></td>
										%{--<td>${pollInstance.status}</td>--}%
										<td>
											<g:set var="lab" value=""/>
											<g:if test="${pollInstance.status==1}">
												<g:set var="lab" value="label-success"/>
											</g:if>
											<g:elseif test="${pollInstance.status==2}">
												<g:set var="lab" value="label-warning"/>
											</g:elseif>
											<g:elseif test="${pollInstance.status==3}">
												<g:set var="lab" value="label-important"/>
											</g:elseif>


											<span class="label ${lab}">
												<g:message message="poll.status.${pollInstance.status}"/>

											</span>
										</td>
										<td>
											<div class="fr">
												<g:if test="${pollInstance.status==4}">

												</g:if>
												<g:else>
													<a href="<g:createLink controller="poll" action="update" id="${pollInstance.id}" params="[status:4]"/>" class="btn btn-primary btn-mini">关闭</a>

												</g:else>
												<a href="<g:createLink controller="poll" action="show" id="${pollInstance.id}"/>" class="btn btn-success btn-mini">详情</a>
												%{--<g:if test="${pollInstance.status==1}">--}%
													%{--<a href="<g:createLink controller="poll" action="update" id="${pollInstance.id}" params="[status:2]"/>" class="btn btn-danger btn-mini">关闭</a>--}%

												%{--</g:if>--}%
											</div>
										</td>
									</tr>
								</g:each>

							</tbody>
							</table>
						</div>
					</div>
					<div class="paginationpage">
						<g:paginate total="${pollInstanceCount ?: 0}" />
					</div>
				</div>
			</div>
		</div>
	</div>
















	</body>
</html>
