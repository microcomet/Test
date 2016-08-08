
<%@ page import="smartcommunity.Poll" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome">
		<g:set var="entityName" value="${message(code: 'poll.label', default: 'Poll')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>








	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
				<a href="<g:createLink controller="poll" action="index"/>"
				   class="current">征询管理</a>
				<a href="#" class="current">征询详情</a>
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
				<div class="widget-box">
					<div class="widget-title"> <span class="icon"> <i class="icon-heart"></i> </span>
						<h5><g:fieldValue bean="${pollInstance}" field="title"/></h5>
					</div>
					<div class="widget-content">
						<g:fieldValue bean="${pollInstance}" field="description"/>


					</div>
				</div>
			</div>


			<div class="row-fluid">

				<div class="span6">



					<div class="widget-box">
						<div class="widget-title"><span class="icon"><i class="icon-list"></i></span>
							<h5>征询详情</h5>
						</div>

						<div class="widget-content">
							<div class="row-fluid">

								<div class="">
									<table class="table table-bordered table-invoice">
										<tbody>
										<tr>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="poll.rule.label" default="Rule" />
											</td>
											<td class="width70">
												<strong>
													${message(code:'poll.check.'+pollInstance.rule)}
												</strong>
											</td>
										</tr>

										<tr>
											<td class="width30">
												<g:message code="poll.score.label" default="Score" />
											</td>
											<td class="width70">
												<strong>
													<g:fieldValue bean="${pollInstance}" field="score"/>
												</strong>
											</td>
										</tr>

										<tr>
											<td class="width30">
												<g:message code="poll.create_time.label" default="Createtime" />
											</td>
											<td class="width70">
												<strong>
													<g:formatDate date="${pollInstance?.create_time}" format="yyyy-MM-dd HH:mm:ss"/>
												</strong>
											</td>
										</tr>
										<tr>
											<td class="width30">
												<g:message code="poll.status.label" default="Status" />
											</td>
											<td class="width70">
												<strong>
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
													<g:elseif test="${pollInstance.status==4}">
														<g:set var="lab" value="label-warning"/>
													</g:elseif>
													<g:elseif test="${pollInstance.status==5}">
														<g:set var="lab" value="label-inverse"/>
													</g:elseif>


													<span class="label ${lab}">
														<g:message message="poll.status.${pollInstance.status}"/>
													</span>
												</strong>
											</td>
										</tr>

										<tr>
											<td class="width30">
												<g:message code="poll.max_select_num.label" default="Maxselectnum" />
											</td>
											<td class="width70">
												<strong>
													<g:fieldValue bean="${pollInstance}" field="max_select_num"/>
												</strong>
											</td>
										</tr>



										<tr>
											<td class="width30">
												<g:message code="poll.start_time.label" default="Starttime" />
											</td>
											<td class="width70">
												<strong>
													<g:formatDate date="${pollInstance?.start_time}" format="yyyy-MM-dd"/>
												</strong>
											</td>
										</tr>

										<tr>
											<td class="width30">
												<g:message code="poll.end_time.label" default="Endtime" />
											</td>
											<td class="width70">
												<strong>
													<g:formatDate date="${pollInstance?.end_time}" format="yyyy-MM-dd"/>
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


				<div class="span6">
					<div class="widget-box">
						<div class="widget-title"> <span class="icon"><i class="icon-ok"></i></span>
							<h5>投票列表</h5>
						</div>
						<div class="widget-content">
							<ul class="unstyled">

								<g:if test="${optionList}">

									<g:each in="${optionList}" var="option" status="i">

										<g:set var="lab" value=""/>

										<g:if test="${(i+1)%4==2}">
											<g:set var="lab" value="progress-success"/>
										</g:if>
										<g:elseif test="${(i+1)%4==3}">
											<g:set var="lab" value="progress-warning"/>
										</g:elseif>
										<g:elseif test="${(i+1)%4==4}">
											<g:set var="lab" value="progress-danger"/>
										</g:elseif>




										<li> <span class="icon24 icomoon-icon-arrow-up-2 green"></span>
											${option.option.option_text}
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											[<a href="#" onclick="
											if (document.getElementById('voterDiv${i}').style.display=='block'){

												document.getElementById('voterDiv${i}').style.display='none';

														 } else {

												document.getElementById('voterDiv${i}').style.display='block';

														 }

											">查看投票人</a>]
											<span class="pull-right strong">${option.optionVoteNum}</span>
											<div class="progress progress-striped ${lab}">
												<div style="width: ${option.optionVotePercentage}%;" class="bar"></div>
											</div>
											<div id="voterDiv${i}" style="display:none" class="widget-content nopadding">
												<table class="table table-striped table-bordered">
													<thead>
													<tr>
														<th>投票人</th>
														<th>投票时间</th>
													</tr>
													</thead>
													<tbody>
										<g:each in="${option.recordList}" var="voter_record">
													<tr>
														<td class="taskDesc"><i class="icon-info-sign"></i> ${voter_record.voter.name}</td>
														<td class="taskStatus"><span class="in-progress">
															<g:formatDate date="${voter_record.vote_time}" format="yyyy-MM-dd HH:mm:ss"/>
														</span></td>
													</tr>
										</g:each>
													</tbody>
												</table>
											</div>
										</li>





									</g:each>

								</g:if>







								%{----}%
								%{--<li> <span class="icon24 icomoon-icon-arrow-up-2 green"></span> 72% Uniquie Clicks <span class="pull-right strong">507</span>--}%
									%{--<div class="progress progress-success progress-striped ">--}%
										%{--<div style="width: 72%;" class="bar"></div>--}%
									%{--</div>--}%
								%{--</li>--}%
								%{--<li> <span class="icon24 icomoon-icon-arrow-down-2 red"></span> 53% Impressions <span class="pull-right strong">457</span>--}%
									%{--<div class="progress progress-warning progress-striped ">--}%
										%{--<div style="width: 53%;" class="bar"></div>--}%
									%{--</div>--}%
								%{--</li>--}%
								%{--<li> <span class="icon24 icomoon-icon-arrow-up-2 green"></span> 3% Online Users <span class="pull-right strong">8</span>--}%
									%{--<div class="progress progress-danger progress-striped ">--}%
										%{--<div style="width: 3%;" class="bar"></div>--}%
									%{--</div>--}%
								%{--</li>--}%
							</ul>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>




	</body>
</html>
