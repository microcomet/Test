
<%@ page import="smartcommunity.ServiceReservation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'serviceReservation.label', default: 'ServiceReservation')}" />
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
				<g:form controller="suggestion" action="indexOpining">
					%{--<input type="hidden" name="roleLv" class="span2" placeholder="用户类型" value="${params.roleLv}">--}%
					<input type="text" name="reserve_person" class="span2" placeholder="预约人" value="${params.name}">
				%{--<input type="text" name="identity_id" class="span2" placeholder="身份证号" value="${params.identity_id}">--}%
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
									<th><g:message code="serviceReservation.serviceItem.label" default="Service Item" /></th>
									<th><g:message code="serviceReservation.reserve_person.label" default="Reserveperson" /></th>
									<th>${message(code: 'serviceReservation.order_date.label', default: 'Order_date')}</th>
									<th>${message(code: 'serviceReservation.status.label', default: 'Status')}</th>
									<th>操作</th>
								</tr>
								</thead>

								<g:each in="${serviceReservationInstanceList}" status="i" var="serviceReservationInstance">
									<tr class="${(i % 2) == 0 ? 'even gradeC' : 'odd gradeX'}">
										<td>${serviceReservationInstance.id}</td>
										<td>${serviceReservationInstance.serviceItem.name}</td>
										<td>${serviceReservationInstance.reserve_person.name}</td>
										<td>${serviceReservationInstance.order_date}</td>

										<td>


											<g:set var="lab" value=""/>
											<g:if test="${serviceReservationInstance.status == "1"}">
												<g:set var="lab" value="label-success"/>
											</g:if>
											<g:elseif test="${serviceReservationInstance.status == "2"}">
												<g:set var="lab" value="label-warning"/>
											</g:elseif>

											<span class="label ${lab}">
												<g:message code="serviceReservation.status.${serviceReservationInstance.status}"/>
											</span>

										</td>
										<td>

											<div class="fr">


												<a href="<g:createLink controller="serviceReservation" action="edit" id="${serviceReservationInstance.id}"/> " class="btn btn-success btn-mini">详情</a>
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

					<div class="pagination alternate">
						<g:paginate total="${serviceReservationInstanceCount ?: 0}" params="${params}"/>
					</div>

				</div>
			</div>
		</div>
	</div>



	</body>
</html>
