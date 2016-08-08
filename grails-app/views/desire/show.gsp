
<%@ page import="smartcommunity.Desire" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'desire.label', default: 'Desire')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>





	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="<g:createLink controller="desire" action="index"/>"
				   class="current">心愿管理</a>
				<a href="#" class="current">心愿详情</a>
			</div>
			%{--<h1>Tables</h1>--}%

		</div>


		<div class="container-fluid"><hr>

			<g:if test="${flash.message}">
				<div class="alert alert-info alert-block"><a class="close" data-dismiss="alert" href="#">×</a>
					<h4 class="alert-heading">信息!</h4>
					${flash.message}
				</div>

			</g:if>




			<div class="row-fluid">

				<div class="span12">

					<div class="widget-box">
						<div class="widget-title"> <span class="icon"> <i class="icon-heart"></i> </span>
							<h5>心愿内容</h5>
						</div>
						<div class="widget-content">
							${desireInstance?.description}

						</br>
							<g:if test="${desireInstance?.image_ids}">
									<g:each var="image_id" in="${desireInstance.image_ids}">

											<img src="${request.getContextPath()}/image/getSingleImage/${image_id}" />

									</g:each>

							</g:if>
						</div>
					</div>

					<div class="widget-box">
						<div class="widget-title"><span class="icon"><i class="icon-list"></i></span>
							<h5>心愿详情</h5>
						</div>

						<div class="widget-content">
							<div class="row-fluid">

								<div class="span6">
									<table class="table table-bordered table-invoice">
										<tbody>
										<tr>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="desire.requester.label" default="Requester" />
											</td>
											<td class="width70">
												<strong>
													${desireInstance?.requester?.name}
												</strong>
											</td>
										</tr>

										<tr>
											<td class="width30">
												<g:message code="desire.score.label" default="Score" />
											</td>
											<td class="width70">
												<strong>
													<g:fieldValue bean="${desireInstance}" field="score"/>
												</strong>
											</td>
										</tr>

										<tr>
											<td class="width30">
												<g:message code="desire.create_time.label" default="Createtime" />
											</td>
											<td class="width70">
												<strong>
													<g:formatDate date="${desireInstance?.create_time}" format="yyyy-MM-dd HH:mm:ss"/>
												</strong>
											</td>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="desire.status.label" default="Status" />
											</td>
											<td class="width70">
												<strong>
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
												</strong>
											</td>
										</tr>

										<tr>
											<td class="width30">
												<g:message code="desire.helper.label" default="Helper" />
											</td>
											<td class="width70">
												<strong>
													${desireInstance?.helper?.name}
												</strong>
											</td>
										</tr>

										<tr>
											<td class="width30">
												领取心愿时间
											</td>
											<td class="width70">
												<strong>
													<g:formatDate date="${desireInstance?.received_time}" format="yyyy-MM-dd HH:mm:ss"/>
												</strong>
											</td>
										</tr>

										<tr>
											<td class="width30">
												提交完成时间
											</td>
											<td class="width70">
												<strong>
													<g:formatDate date="${desireInstance?.submit_time}" format="yyyy-MM-dd HH:mm:ss"/>
												</strong>
											</td>
										</tr>

										<tr>
											<td class="width30">
												确认完成时间
											</td>
											<td class="width70">
												<strong>
													<g:formatDate date="${desireInstance?.finish_time}" format="yyyy-MM-dd HH:mm:ss"/>
												</strong>
											</td>
										</tr>


										%{--<tr>--}%
											%{--<td class="width30">--}%
												%{--<g:message code="announcement.status.label" default="Status" />--}%
											%{--</td>--}%
											%{--<td class="width70">--}%
												%{--<strong>--}%
													%{--<g:fieldValue bean="${announcementInstance}" field="status"/>--}%

													%{--<g:set var="lab" value=""/>--}%
													%{--<g:if test="${announcementInstance.status==1}">--}%
														%{--<g:set var="lab" value="label-success"/>--}%
													%{--</g:if>--}%
													%{--<g:elseif test="${announcementInstance.status==2}">--}%
														%{--<g:set var="lab" value="label-warning"/>--}%
													%{--</g:elseif>--}%

													%{--<span class="label ${lab}">--}%
														%{--<g:message message="announcement.status.${announcementInstance.status}"/>--}%
													%{--</span>--}%

												%{--</strong>--}%
											%{--</td>--}%
										%{--</tr>--}%
										%{----}%

										</tbody>

									</table>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>









	</body>
</html>
