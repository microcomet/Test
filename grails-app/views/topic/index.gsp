
<%@ page import="smartcommunity.Topic" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'topic.label', default: 'Topic')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>



	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="#" class="current">话题讨论管理</a>
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
				<g:form controller="topic" action="index">
					<input type="text" name="title" class="span2" placeholder="标题" value="${params.title}">
					<input type="text" name="promoter" class="span2" placeholder="发布人" value="${params.promoter}">
				%{--<g:include controller="userInc" action="createUser" params="[search:1]"/>--}%


					<select name="status" style="width:120px;">
						<option>全部状态</option>
						<g:each in="${1..4}" var="idx">
							<option value="${idx}" <g:if test="${params.int('status')==idx}">selected</g:if> ><g:message code="topic.status.${idx}"/> </option>
						</g:each>
					</select>
					<button type="submit" style="margin-top: -10px" class="btn btn-success">搜索</button>
				</g:form>

			</div>


			<div class="row-fluid">
				<div class="span12">

					<div class="widget-box">
						<div class="widget-title"> <span class="icon"><i class="icon-list"></i></span>
							<h5>话题列表</h5>
						</div>
						<div class="widget-content">
							<div class="todo">
								<ul>
									%{--<li class="clearfix">--}%
										%{--<div class="txt">--}%
                                            %{--<span class="by label">Nirav</span>--}%
                                            %{--Luanch This theme on Themeforest--}%
                                            %{--<span class="date badge badge-info">08.03.2013</span>--}%
                                            %{--<span class="date badge badge-important">关闭话题</span>--}%
                                            %{--<span class="date badge badge-success">Tomorrow</span>--}%
                                            %{--<span class="date badge badge-warning">Today</span>--}%
                                        %{--</div>--}%
										%{--<div class="pull-right">--}%
                                            %{--<a class="tip" href="#" >--}%

                                            %{--</a>--}%
                                            %{--<a class="tip" href="#" >--}%
                                                %{--<a href="<g:createLink controller="poll" action="show" id=""/>" class="btn btn-success btn-mini">详情</a>--}%
                                            %{--</a>--}%
                                        %{--</div>--}%
									%{--</li>--}%

                                    <g:each in="${topicInstanceList}" status="i" var="topicInstance">
                                        <li class="clearfix">
                                            <div class="txt">
                                                <span class="by label">${topicInstance.promoter.nick_name}</span>
                                                <a href="<g:createLink controller="topic" action="show" id="${topicInstance.id}"/>">

                                                ${topicInstance.title}
                                                </a>
                                                <span class="date badge badge-info"><g:formatDate date="${topicInstance.create_time}" format="yyyy-MM-dd HH:mm:ss"/> </span>
												<g:if test="${topicInstance.status==4}">
                                                <span class="date badge badge-important">话题关闭</span>
                                                </g:if>

                                                %{--<span class="date badge badge-success">Tomorrow</span>--}%
												<g:if test="${topicInstance.status==1}">
												<span class="date badge badge-warning">审核中</span>

												</g:if>
                                                <g:if test="${topicInstance.status==2}">
                                                    %{--<span class="date badge badge-warning">审核中</span>--}%
												<span class="date badge badge-success">审核通过</span>

                                                </g:if>
                                            </div>
                                            <div class="pull-right">
                                                <a class="tip" href="#" >

                                                </a>

                                                <a class="tip" href="#" >
                                                    <a href="<g:createLink controller="topic" action="show" id="${topicInstance.id}"/>" class="btn btn-success btn-mini">详情操作</a>
                                                </a>
                                            </div>
                                        </li>
                                    </g:each>
								</ul>
							</div>
						</div>
					</div>

                    <div class="paginationpage">
                        <g:paginate total="${topicInstanceCount ?: 0}" />
                    </div>
				</div>

			</div>



		</div>
	</div>















	%{--<a href="#list-topic" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--}%
		%{--<div class="nav" role="navigation">--}%
			%{--<ul>--}%
				%{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
				%{--<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
			%{--</ul>--}%
		%{--</div>--}%
		%{--<div id="list-topic" class="content scaffold-list" role="main">--}%
			%{--<h1><g:message code="default.list.label" args="[entityName]" /></h1>--}%
			%{--<g:if test="${flash.message}">--}%
				%{--<div class="message" role="status">${flash.message}</div>--}%
			%{--</g:if>--}%
			%{--<table>--}%
			%{--<thead>--}%
					%{--<tr>--}%

						%{--<g:sortableColumn property="title" title="${message(code: 'topic.title.label', default: 'Title')}" />--}%

						%{--<g:sortableColumn property="content" title="${message(code: 'topic.content.label', default: 'Content')}" />--}%

						%{--<g:sortableColumn property="status" title="${message(code: 'topic.status.label', default: 'Status')}" />--}%

						%{--<th><g:message code="topic.promoter.label" default="Promoter" /></th>--}%

						%{--<g:sortableColumn property="auditing_desc" title="${message(code: 'topic.auditing_desc.label', default: 'Auditingdesc')}" />--}%

						%{--<g:sortableColumn property="auditing_time" title="${message(code: 'topic.auditing_time.label', default: 'Auditingtime')}" />--}%

					%{--</tr>--}%
				%{--</thead>--}%
				%{--<tbody>--}%
				%{--<g:each in="${topicInstanceList}" status="i" var="topicInstance">--}%
					%{--<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">--}%

						%{--<td><g:link action="show" id="${topicInstance.id}">${fieldValue(bean: topicInstance, field: "title")}</g:link></td>--}%

						%{--<td>${fieldValue(bean: topicInstance, field: "content")}</td>--}%

						%{--<td>${fieldValue(bean: topicInstance, field: "status")}</td>--}%

						%{--<td>${fieldValue(bean: topicInstance, field: "promoter")}</td>--}%

						%{--<td>${fieldValue(bean: topicInstance, field: "auditing_desc")}</td>--}%

						%{--<td><g:formatDate date="${topicInstance.auditing_time}" /></td>--}%

					%{--</tr>--}%
				%{--</g:each>--}%
				%{--</tbody>--}%
			%{--</table>--}%
			%{----}%
		%{--</div>--}%
	</body>
</html>
