<%@ page import="smartcommunity.Announcement" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'announcement.label', default: 'Announcement')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>

	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="<g:createLink controller="announcement" action="index"/>" class="current">公告管理</a>
				<a href="#" class="current">修改公告</a>
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

			<g:hasErrors bean="${announcementInstance}">

				<div class="alert alert-error alert-block"> <a class="close" data-dismiss="alert" href="#">×</a>
					<h4 class="alert-heading">错误!</h4>

				<g:eachError bean="${announcementInstance}" var="error">
					<g:message error="${error}"/></br>
				</g:eachError>

				</div>
			</g:hasErrors>


			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title"> <span class="icon"> <i class="icon-info-sign"></i> </span>
							<h5>修改公告</h5>
						</div>
						<div class="widget-content nopadding">
							<g:uploadForm url="[resource:announcementInstance, action:'update']" class="form-horizontal" onsubmit="if(formcheck()==true){return true;}else{return false;};">
								<g:hiddenField name="version" value="${announcementInstance?.version}" />
							%{--<form class="form-horizontal" method="post" action="#" name="basic_validate" id="basic_validate" novalidate="novalidate">--}%
								<g:render template="form"/>

								%{--<g:if test="${announcementInstance?.image_ids}">--}%
									%{--<li class="fieldcontain">--}%
										%{--<span id="image_ids-label" class="property-label"><g:message code="announcement.image_ids.label" default="Updatetime" /></span>--}%

										%{--<g:each var="image_id" in="${announcementInstance.image_ids}">--}%
											%{--<span class="property-value" aria-labelledby="image_ids-label">--}%
												%{--<img src="${request.getContextPath()}/image/getSingleImage/${image_id}" />--}%
											%{--</span>--}%
										%{--</g:each>--}%

									%{--</li>--}%
								%{--</g:if>--}%

								<div class="form-actions">
									%{--<input type="submit" value="Validate" class="btn btn-success">--}%
									<g:submitButton name="create" class="btn btn-success" value="修改" />
								</div>
							</g:uploadForm>

						</div>
					</div>
				</div>
			</div>

		</div>
	</div>













	%{--<a href="#edit-announcement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--}%
		%{--<div class="nav" role="navigation">--}%
			%{--<ul>--}%
				%{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
				%{--<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>--}%
				%{--<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
			%{--</ul>--}%
		%{--</div>--}%
		%{--<div id="edit-announcement" class="content scaffold-edit" role="main">--}%
			%{--<h1><g:message code="default.edit.label" args="[entityName]" /></h1>--}%
			%{--<g:if test="${flash.message}">--}%
			%{--<div class="message" role="status">${flash.message}</div>--}%
			%{--</g:if>--}%
			%{--<g:hasErrors bean="${announcementInstance}">--}%
			%{--<ul class="errors" role="alert">--}%
				%{--<g:eachError bean="${announcementInstance}" var="error">--}%
				%{--<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>--}%
				%{--</g:eachError>--}%
			%{--</ul>--}%
			%{--</g:hasErrors>--}%
			%{--<g:form url="[resource:announcementInstance, action:'update']" method="PUT" >--}%
				%{--<g:hiddenField name="version" value="${announcementInstance?.version}" />--}%
				%{--<fieldset class="form">--}%
					%{--<g:render template="form"/>--}%
				%{--</fieldset>--}%
				%{--<fieldset class="buttons">--}%
					%{--<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />--}%
				%{--</fieldset>--}%
			%{--</g:form>--}%
		%{--</div>--}%
	</body>
</html>
