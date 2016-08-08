
<%@ page import="smartcommunity.Topic" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'topic.label', default: 'Topic')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>

	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="<g:createLink controller="topic" action="index"/>" class="current">话题讨论管理</a>
				<a href="#" class="current">话题内容</a>
			</div>
			%{--<h1>Tables</h1>--}%
			<div class="container-fluid">
				<hr>
				<div class="row-fluid">
					<div class="span12">
						<div class="widget-box">
							<div class="widget-title"> <span class="icon"> <i class="icon-file"></i> </span>
								<h5>标题:<g:fieldValue bean="${topicInstance}" field="title"/></h5>
								<span class="label label-inverse">${topicInstance?.community?.street?.name} - ${topicInstance?.community?.name}</span>
							</div>
							<div class="widget-content nopadding">
								<ul class="recent-posts">
									<li>
										<div class="user-thumb"> <img width="40" height="40" alt="User" src="<g:createLink controller="image" action="getSingleImage" id="${topicInstance.promoter.potrait_id}"/>"> </div>
										<div class="article-post">
											<div class="fr">

												<g:if test="${topicInstance.status==1}">
												<a href="<g:createLink controller="topic" action="update" id="${topicInstance.id}" params="[status:2]"/>" class="btn btn-success btn-mini">审核通过</a>


												<a href="<g:createLink controller="topic" action="update" id="${topicInstance.id}" params="[status:3]"/>" class="btn btn-primary btn-mini">审核不通过</a>
												</g:if>
												<g:if test="${topicInstance.status!=4}">
												<a onclick="if(confirm('确认要关闭话题?话题关闭后无法在打开.?')==false)return false;" href="<g:createLink controller="topic" action="update" id="${topicInstance.id}"  params="[status:4]"/>" class="btn btn-danger btn-mini">关闭话题</a>
												</g:if>
											</div>
											<span class="user-info">
												发布: <strong>${topicInstance.promoter.name}</strong> /
												时间: <strong><g:formatDate date="${topicInstance.create_time}" format="yyyy-MM-dd HH:mm:ss"/></strong>
												<g:if test="${topicInstance.status==4}">
													<span class="date badge badge-important"><g:message code="topic.status.${topicInstance.status}"/></span>
												</g:if>

												<g:if test="${topicInstance.status==2}">
													<span class="date badge badge-success"><g:message code="topic.status.${topicInstance.status}"/> </span>

												</g:if>
												<g:if test="${topicInstance.status==1}">
													<span class="date badge badge-warning"><g:message code="topic.status.${topicInstance.status}"/> </span>

												</g:if>
												<g:if test="${topicInstance.status==3}">
													<span class="date badge badge-important"><g:message code="topic.status.${topicInstance.status}"/></span>
												</g:if>
											</span>
											<p>${topicInstance.content}</p>
										</div>
									</li>

								</li>
								</ul>
							</div>
						</div>
						<div class="widget-box">
							<div class="widget-title"> <span class="icon"> <i class="icon-file"></i> </span>
								<h5>回复</h5>
							</div>
							<div class="widget-content nopadding">
								<ul class="recent-posts">
									<g:if test="${replyList}">

										<g:each in="${replyList}" var="reply">


									<li>
										<div class="user-thumb"> <img width="40" height="40" alt="User" src="<g:createLink controller="image" action="getSingleImage" id="${reply.publisher.potrait_id}"/>"> </div>
										<div class="article-post">
											<div class="fr">
												<g:if test="${reply.status==1}">
													<a href="<g:createLink controller="topicReply" action="update" id="${reply.id}" params="[status:2]"/> " class="btn btn-primary btn-mini">屏蔽</a>
												</g:if>
												<g:elseif test="${reply.status==2}">
													<a href="<g:createLink controller="topicReply" action="update" id="${reply.id}" params="[status:1]"/>" class="btn btn-success btn-mini">恢复</a>

												</g:elseif>
												<g:if test="${reply.status!=3}">

												<a href="<g:createLink controller="topicReply" action="update" id="${reply.id}" params="[status:3]"/>" class="btn btn-danger btn-mini" onclick="if(confirm('确认删除吗?删除后无法恢复!')==false)return false;">删除</a>

												</g:if>
											</div>
											<span class="user-info">
												回复: ${reply.publisher.name}
												/ 时间: <g:formatDate date="${reply.create_time}" format="yyyy-MM-dd HH:mm:ss"/>
												<g:if test="${reply.status==2}">

													<span class="date badge badge-inverse"><g:message code="topicReply.status.${reply.status}"/></span>
												</g:if>
												<g:if test="${reply.status==3}">

													<span class="date badge badge-important"><g:message code="topicReply.status.${reply.status}"/></span>

												</g:if>

											</span>
											<p>${reply.content}</p>
										</div>
									</li>
										</g:each>

									</g:if>

								</li>
								</ul>
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
