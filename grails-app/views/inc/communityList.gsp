<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="layoutHome"/>
	<title></title>

</head>
<body>
<div id="content">

	<div id="content-header">
		<div id="breadcrumb">
			%{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
			<g:include controller="inc" action="incHome"/>
			<a href="#" class="current">街道管理</a>
		</div>
		%{--<h1>Tables</h1>--}%

	</div>

	<div class="container-fluid">
		%{--<hr>--}%
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
						<h5>社区列表</h5>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered table-striped">
							<thead>
							<tr>
								<th>社区名称</th>
								<th>联系人</th>
								<th>联系电话</th>
								<th>预留</th>
								<th>操作</th>
							</tr>
							</thead>
							<tbody>
							<tr class="odd gradeX">
								<td>Trident</td>
								<td>Internet
								Explorer 4.0</td>
								<td>Win 95+</td>
								<td class="center"> 4</td>
								<td class="center">X</td>
							</tr>
							<tr class="even gradeC">
								<td>Trident</td>
								<td>Internet
								Explorer 5.0</td>
								<td>Win 95+</td>
								<td class="center">5</td>
								<td class="center">C</td>
							</tr>

							</tbody>
						</table>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>
</body>
</html>
