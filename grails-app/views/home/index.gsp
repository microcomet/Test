<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutHome"/>
		<title>Welcome to Grails</title>

	</head>
	<body>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
				<g:include controller="inc" action="incHome"/>
			</div>
			%{--<h1>Tables</h1>--}%

		</div>
		<div class="container-fluid">
			<div class="widget-box">
				<div class="widget-title"> <span class="icon"> <i class="icon-hand-right"></i> </span>
					<h5>快速操作</h5>
				</div>
				<div class="widget-content">
					<ul class="quick-actions">
						<li class="bg_lb"> <a href="<g:createLink controller="user" action="index"
																  params="['status': '1', 'roleLv': '2']"/>"> <i class="icon-group"></i> 用户审核 </a> </li>
						<li class="bg_lo"> <a href="<g:createLink controller="desire" action="index"/>"> <i class="icon-heart"></i> 心愿市场 </a> </li>
						<li class="bg_ly"> <a href="<g:createLink controller="announcement" action="create"/>"> <i class="icon-bullhorn"></i> 公告发布 </a> </li>
						<li class="bg_ls"> <a href="<g:createLink controller="poll" action="index"/>"> <i class="icon-check"></i> 民意征询</a> </li>

						<li class="bg_lg"> <a href="<g:createLink controller="topic" action="index"/>"> <i class="icon-comments"></i> 话题讨论</a> </li>

					</ul>

					<br><br><br><br>
				</div>
			</div>

			<div class="widget-box">
				<div class="widget-title"> <span class="icon"> <i class="icon-bar-chart"></i> </span>
					<h5>数据分析</h5>
				</div>
				<div class="widget-content">
					<ul class="quick-actions">
						<li class="bg_lh"><a href="#"><i class="icon-user"></i> <strong>${dataAnalysis.totalUserNum}</strong> </br><small>总用户数</small></a> </li>
						<li class="bg_lh"><a href="#"><i class="icon-heart"></i> <strong>${dataAnalysis.totalWishNum}</strong> </br><small>总心愿数</small></a></li>
						<li class="bg_lh"><a href="#"><i class="icon-comments"></i> <strong>${dataAnalysis.totalTopicNum}</strong> </br><small>总话题数</small></a></li>
						<li class="bg_lh"><a href="#"><i class="icon-tag"></i> <strong>${dataAnalysis.totalVoteNum}</strong> </br><small>总征询数</small></a></li>
						<li class="bg_lh"><a href="#"><i class="icon-edit"></i> <strong>${dataAnalysis.totalOrderNum}</strong> </br><small>总预约数</small></a></li>
					</ul>
					<br><br><br><br><br>
				</div>
			</div>

			<!--End-Action boxes-->

			<!--Chart-box-->

			<!--End-Chart-box-->
			%{--<div class="row-fluid">--}%
				%{--<div class="span6">--}%
					%{--<div class="widget-box">--}%
						%{--<div class="widget-title bg_ly" data-toggle="collapse" href="#collapseG2"><span class="icon"><i class="icon-chevron-down"></i></span>--}%
							%{--<h5>Latest Posts</h5>--}%
						%{--</div>--}%
						%{--<div class="widget-content nopadding collapse in" id="collapseG2">--}%
							%{--<ul class="recent-posts">--}%
								%{--<li>--}%
									%{--<div class="user-thumb"> <img width="40" height="40" alt="User" src="img/demo/av1.jpg"> </div>--}%
									%{--<div class="article-post"> <span class="user-info"> By: john Deo / Date: 2 Aug 2012 / Time:09:27 AM </span>--}%
										%{--<p><a href="#">This is a much longer one that will go on for a few lines.It has multiple paragraphs and is full of waffle to pad out the comment.</a> </p>--}%
									%{--</div>--}%
								%{--</li>--}%
								%{--<li>--}%
									%{--<div class="user-thumb"> <img width="40" height="40" alt="User" src="img/demo/av2.jpg"> </div>--}%
									%{--<div class="article-post"> <span class="user-info"> By: john Deo / Date: 2 Aug 2012 / Time:09:27 AM </span>--}%
										%{--<p><a href="#">This is a much longer one that will go on for a few lines.It has multiple paragraphs and is full of waffle to pad out the comment.</a> </p>--}%
									%{--</div>--}%
								%{--</li>--}%
								%{--<li>--}%
									%{--<div class="user-thumb"> <img width="40" height="40" alt="User" src="img/demo/av4.jpg"> </div>--}%
									%{--<div class="article-post"> <span class="user-info"> By: john Deo / Date: 2 Aug 2012 / Time:09:27 AM </span>--}%
										%{--<p><a href="#">This is a much longer one that will go on for a few lines.Itaffle to pad out the comment.</a> </p>--}%
									%{--</div>--}%
								%{--</li><li>--}%
								%{--<button class="btn btn-warning btn-mini">View All</button>--}%
							%{--</li>--}%
							%{--</ul>--}%
						%{--</div>--}%
					%{--</div>--}%




				%{--</div>--}%
				%{--<div class="span6">--}%
					%{--<div class="widget-box">--}%
						%{--<div class="widget-title bg_lo" data-toggle="collapse" href="#collapseG3"> <span class="icon"> <i class="icon-chevron-down"></i> </span>--}%
							%{--<h5>News updates</h5>--}%
						%{--</div>--}%
						%{--<div class="widget-content nopadding updates in collapse" id="collapseG3" style="height: auto;">--}%
							%{--<div class="new-update clearfix"><i class="icon-ok-sign"></i>--}%
								%{--<div class="update-done"><a title="" href="#"><strong>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</strong></a> <span>dolor sit amet, consectetur adipiscing eli</span> </div>--}%
								%{--<div class="update-date"><span class="update-day">20</span>jan</div>--}%
							%{--</div>--}%
							%{--<div class="new-update clearfix"> <i class="icon-gift"></i> <span class="update-notice"> <a title="" href="#"><strong>Congratulation Maruti, Happy Birthday </strong></a> <span>many many happy returns of the day</span> </span> <span class="update-date"><span class="update-day">11</span>jan</span> </div>--}%
							%{--<div class="new-update clearfix"> <i class="icon-move"></i> <span class="update-alert"> <a title="" href="#"><strong>Maruti is a Responsive Admin theme</strong></a> <span>But already everything was solved. It will ...</span> </span> <span class="update-date"><span class="update-day">07</span>Jan</span> </div>--}%
							%{--<div class="new-update clearfix"> <i class="icon-leaf"></i> <span class="update-done"> <a title="" href="#"><strong>Envato approved Maruti Admin template</strong></a> <span>i am very happy to approved by TF</span> </span> <span class="update-date"><span class="update-day">05</span>jan</span> </div>--}%
							%{--<div class="new-update clearfix"> <i class="icon-question-sign"></i> <span class="update-notice"> <a title="" href="#"><strong>I am alwayse here if you have any question</strong></a> <span>we glad that you choose our template</span> </span> <span class="update-date"><span class="update-day">01</span>jan</span> </div>--}%
						%{--</div>--}%
					%{--</div>--}%


				%{--</div>--}%
			%{--</div>--}%
		</div>
	</div>
	</body>
</html>
