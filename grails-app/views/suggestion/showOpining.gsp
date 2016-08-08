
<%@ page import="smartcommunity.Suggestion" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'suggestion.label', default: 'Suggestion')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>





	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="<g:createLink controller="suggestion" action="indexOpining"/>" class="current">意见管理</a>
				<a href="#" class="current">意见详情</a>
			</div>
			%{--<h1>Tables</h1>--}%

		</div>

		<div class="container-fluid">
			<hr>

			<g:if test="${flash.message}">
				<div class="alert alert-info alert-block"> <a class="close" data-dismiss="alert" href="#">×</a>
					<h4 class="alert-heading">信息!</h4>
					${flash.message}
				</div>

			</g:if>

			<g:hasErrors bean="${suggestionInstance}">

				<div class="alert alert-error alert-block"> <a class="close" data-dismiss="alert" href="#">×</a>
					<h4 class="alert-heading">错误!</h4>

				<g:eachError bean="${suggestionInstance}" var="error">
					<g:message error="${error}"/></br>
				</g:eachError>

				</div>
			</g:hasErrors>


			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title"> <span class="icon"> <i class="icon-info-sign"></i> </span>
							<h5>意见详情</h5>
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
												<g:message code="suggestion.title.label" default="Title" />
											</td>
											<td class="width70">
												<strong>
													<g:fieldValue bean="${suggestionInstance}" field="title"/>
												</strong>
											</td>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="suggestion.content.label" default="Content" />
											</td>
											<td class="width70">
												<strong>
													<g:fieldValue bean="${suggestionInstance}" field="content"/>
												</strong>
											</td>
										</tr>

										<tr>
											<td class="width30">
												<g:message code="suggestion.street.label" default="Street" />
											</td>
											<td class="width70">
												<strong>
													${suggestionInstance.street?.name}
												</strong>
											</td>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="suggestion.community.label" default="Community" />
											</td>
											<td class="width70">
												<strong>
													${suggestionInstance.community?.name}
												</strong>
											</td>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="poll.status.label" default="Status" />
											</td>
											<td class="width70">
												<strong>
													<g:message code="suggestion.status.${suggestionInstance.status}"/>

												</strong>
											</td>
										</tr>


										<tr>
											<td class="width30">
												<g:message code="poll.create_time.label" default="Createtime" />
											</td>
											<td class="width70">
												<strong>

													<g:formatDate date="${suggestionInstance?.create_time}" format="yyyy-MM-dd HH:mm:ss"/>
												</strong>
											</td>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="suggestion.image_ids.label" default="ImageIds" />
											</td>
											<td class="width70">
												<strong>
													<g:each var="image_id" in="${suggestionInstance.image_ids}">
														<span class="property-value" aria-labelledby="image_ids-label">

															<img src="<g:createLink controller="image" action="getSingleImage" id="${image_id}"/> " />
														</span>
													</g:each>
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
