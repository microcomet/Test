
<%@ page import="smartcommunity.Suggestion" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'suggestion.label', default: 'Suggestion')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>




	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="#" class="current">社区意见管理</a>
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

			<div class="controls">
				<g:form controller="suggestion" action="indexOpining">
					<input type="hidden" name="roleLv" class="span2" placeholder="用户类型" value="${params.roleLv}">
					<input type="text" name="name" class="span2" placeholder="发布人" value="${params.name}">
					%{--<input type="text" name="identity_id" class="span2" placeholder="身份证号" value="${params.identity_id}">--}%
					<g:include controller="userInc" action="createUser" params="[search:1]"/>


					<select name="status" style="width:120px;">
						<option value=" " selected="selected">选择状态</option>
						<g:each in="${1..2}" var="idx">
							<option value="${idx}" <g:if test="${params.int('status')==idx}">selected</g:if> ><g:message code="suggestion.status.${idx}"/> </option>
						</g:each>
					</select>
					<button type="submit" style="margin-top: -10px" class="btn btn-success">搜索</button>
				</g:form>

			</div>

			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title"><span class="icon"><i class="icon-th"></i></span>
							<h5>意见列表</h5>
						</div>

						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped">
								<thead>
								<tr>
									<th>ID</th>
									%{--<th>${message(code: 'suggestion.title.label', default: 'Title')}</th>--}%
									<th>${message(code: 'suggestion.content.label', default: 'Content')}</th>

									<th>${message(code: 'suggestion.street.label', default: 'Street')}</th>
									<th>${message(code: 'suggestion.community.label', default: 'Community')}</th>
									<th>${message(code: 'suggestion.publisher.label', default: 'Publisher')}</th>
									<th>发布时间</th>
									<th>状态</th>
									<th>操作</th>
								</tr>
								</thead>

								<g:each in="${suggestionInstanceList}" status="i" var="suggestionInstance">
									<tr class="${(i % 2) == 0 ? 'even gradeC' : 'odd gradeX'}">
										<td>${suggestionInstance.id}</td>
										%{--<td>${suggestionInstance.title}</td>--}%
										<td>${suggestionInstance.content}</td>

										<td>${suggestionInstance.street?.name}</td>
										<td>${suggestionInstance.community?.name}</td>
										<td>${suggestionInstance.publisher?.name}</td>
										<td>
											${suggestionInstance.create_time.format("yyyy-MM-dd HH:mm:ss")}

										</td>
										<td>


											<g:set var="lab" value=""/>
											<g:if test="${suggestionInstance.status == 1}">
												<g:set var="lab" value="label-success"/>
											</g:if>
											<g:elseif test="${suggestionInstance.status == 2}">
												<g:set var="lab" value="label-warning"/>
											</g:elseif>

											<span class="label ${lab}">
											<g:message code="suggestion.status.${suggestionInstance.status}"/>
											</span>

										</td>
										<td>

											<div class="fr">

												<g:if test="${suggestionInstance.status == 1}">
													<a href="<g:createLink controller="suggestion" action="closeOpining" id="${suggestionInstance.id}"/> " class="btn btn-primary btn-mini">关闭</a>
												</g:if>

												<a href="<g:createLink controller="suggestion" action="showOpining" id="${suggestionInstance.id}"/> " class="btn btn-success btn-mini">详情</a>
												%{--<a href="#" class="btn btn-danger btn-mini"--}%
												   %{--onClick="return confirm('确定删除?');">删除</a>--}%
											</div>
										</td>
									</tr>
								</g:each>

							</tbody>
							</table>
						</div>
					</div>

					<div class="paginationpage">
						<g:paginate total="${suggestCount ?: 0}" params="${params}"/>
					</div>

				</div>
			</div>
		</div>
	</div>


	</body>
</html>
