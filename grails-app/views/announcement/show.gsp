
<%@ page import="smartcommunity.Announcement" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'announcement.label', default: 'Announcement')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>





	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="<g:createLink controller="announcement" action="index"/>"
				   class="current">公告管理</a>
				<a href="#" class="current">公告详情</a>
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
						<div class="widget-title"><span class="icon"><i class="icon-bullhorn"></i></span>
							<h5>公告详情</h5>
						</div>

						<div class="widget-content">
							<div class="row-fluid">

								<div class="span11">
									<table class="table table-bordered table-invoice">
										<tbody>
										<tr>
										</tr>
										<tr>
											<td class="width30" width="150px">
												<g:message code="announcement.title.label" default="Title" />
											</td>
											<td class="width70">
												<strong>
													<g:fieldValue bean="${announcementInstance}" field="title"/>
												</strong>
											</td>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="announcement.content.label" default="Content" />
											</td>
											<td class="width70">
												<strong>
													<g:fieldValue bean="${announcementInstance}" field="content"/>
												</strong>
											</td>
										</tr>

										<tr>
											<td class="width30">
												<g:message code="announcement.community.label" default="Community" />
											</td>
											<td class="width70">
												<strong>
													${announcementInstance?.community?.street?.name} -
													${announcementInstance?.community?.name}
												</strong>
											</td>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="announcement.create_time.label" default="Createtime" />
											</td>
											<td class="width70">
												<strong>
													<g:formatDate date="${announcementInstance?.create_time}" format="yyyy-MM-dd HH:mm:ss"/>
												</strong>
											</td>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="announcement.publisher.label" default="Publisher" />
											</td>
											<td class="width70">
												<strong>
													${announcementInstance?.publisher?.name}
												</strong>
											</td>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="announcement.status.label" default="Status" />
											</td>
											<td class="width70">
												<strong>
													%{--<g:fieldValue bean="${announcementInstance}" field="status"/>--}%

													<g:set var="lab" value=""/>
													<g:if test="${announcementInstance.status==1}">
														<g:set var="lab" value="label-success"/>
													</g:if>
													<g:elseif test="${announcementInstance.status==2}">
														<g:set var="lab" value="label-warning"/>
													</g:elseif>

													<span class="label ${lab}">
														<g:message message="announcement.status.${announcementInstance.status}"/>
													</span>

												</strong>
											</td>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="announcement.image_ids.label" default="Updatetime" />
											</td>
											<td class="width70">
												<g:each var="image_id" in="${announcementInstance.image_ids}">
													<span class="property-value" aria-labelledby="image_ids-label">
														<img src="<g:createLink controller="image" action="getSingleImage" id="${image_id}"/>" />
													</span>
												</g:each>
											</td>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="announcement.close_time.label" default="Closetime" />
											</td>
											<td class="width70">
												<strong>
													<g:formatDate date="${announcementInstance?.close_time}" format="yyyy-MM-dd HH:mm:ss"/>
												</strong>
											</td>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="announcement.closer.label" default="Closer" />
											</td>
											<td class="width70">
												<strong>
													${announcementInstance?.closer?.name}
												</strong>
											</td>
										</tr>

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
