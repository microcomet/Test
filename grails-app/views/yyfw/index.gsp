
<%@ page import="smartcommunity.Yyfw" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>







	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="#" class="current">服务预约管理</a>
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
				<g:form controller="yyfw" action="index">
				%{--<input type="hidden" name="roleLv" class="span2" placeholder="用户类型" value="${params.roleLv}">--}%
				<input type="text" name="reserve_person" class="span2" placeholder="预约人" value="${params.reserve_person}">
				<input type="text" name="fwmc" class="span2" placeholder="服务" value="${params.fwmc}">
				%{--<g:include controller="userInc" action="createUser" params="[search:1]"/>--}%


					<select name="status" style="width:120px;">
						<option value=" " selected="selected">选择状态</option>
						<g:each in="${1..3}" var="idx">
							<option value="${idx}" <g:if test="${params.int('status')==idx}">selected</g:if> ><g:message code="serviceReservation.status.${idx}"/> </option>
						</g:each>
					</select>
					<button type="submit" style="margin-top: -10px" class="btn btn-success">搜索</button>
				</g:form>

			</div>

			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title"><span class="icon"><i class="icon-th"></i></span>
							<h5>服务预约列表</h5>
						</div>

						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped">
								<thead>
								<tr>
									<th>ID</th>
									<th width="200px">预约服务</th>
									<th>预约用户</th>
									<th>预约时间</th>
									<th>创建时间</th>
									<th>预约状态</th>
									<th>操作</th>
								</tr>
								</thead>

								<g:each in="${yyfwInstanceList}" status="i" var="yyfwInstance">
									<tr class="${(i % 2) == 0 ? 'even gradeC' : 'odd gradeX'}">
										<td>${yyfwInstance.id}</td>
										<td>${yyfwInstance.fwmc}</td>
										<td>${yyfwInstance.reservePerson.name}</td>
										<td>
											<g:formatDate date="${yyfwInstance.orderTime}" format="yyyy-MM-dd"/>

											${yyfwInstance.timeSlot}
										</td>
										<td>
											<g:formatDate date="${yyfwInstance.createTime}" format="yyyy-MM-dd HH:mm:ss"/>
										</td>

										<td>


											<g:set var="lab" value=""/>
											<g:if test="${yyfwInstance.status == "1"}">
												<g:set var="lab" value="label-success"/>
											</g:if>
											<g:elseif test="${yyfwInstance.status == "2"}">
												<g:set var="lab" value="label-warning"/>
											</g:elseif>

											<span class="label ${lab}">
												<g:message code="serviceReservation.status.${yyfwInstance.status}"/>
											</span>

										</td>
										<td>

											<div class="fr">


												<g:if test="${yyfwInstance.status == "1"}">
													<a href="<g:createLink controller="yyfw" action="edit" id="${yyfwInstance.id}"/> " class="btn btn-success btn-mini">审核</a>

												</g:if>
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
						<g:paginate total="${yyfwInstanceCount ?: 0}" />
					</div>

				</div>
			</div>
		</div>
	</div>
	</body>
</html>
