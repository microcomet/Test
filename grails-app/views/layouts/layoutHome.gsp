<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 16/6/2
  Time: 上午9:42
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>克拉玛依智慧社区</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="<g:resource dir="system/css" file="bootstrap.min.css"/>"/>
    <link rel="stylesheet" href="<g:resource dir="system/css" file="bootstrap-responsive.min.css"/>"/>
    <link rel="stylesheet" href="<g:resource dir="system/css" file="colorpicker.css"/>"/>
    <link rel="stylesheet" href="<g:resource dir="system/css" file="datepicker.css"/>"/>
    <link rel="stylesheet" href="<g:resource dir="system/css" file="uniform.css"/>"/>
    <link rel="stylesheet" href="<g:resource dir="system/css" file="select2.css"/>"/>
    <link rel="stylesheet" href="<g:resource dir="system/css" file="matrix-style.css"/>"/>
    <link rel="stylesheet" href="<g:resource dir="system/css" file="matrix-media.css"/>"/>
    <link rel="stylesheet" href="<g:resource dir="system/css" file="bootstrap-wysihtml5.css"/>"/>

    <link href="<g:resource dir="system/font-awesome/css" file="font-awesome.css"/>" rel="stylesheet"/>
    <link href="<g:resource dir="css" file="page.css"/>" rel="stylesheet"/>

</head>

<body>

<!--Header-part-->
<div id="header">
    <h1><a href="dashboard.html">Matrix Admin</a></h1>
</div>
<!--close-Header-part-->

<!--top-Header-menu-->
<div id="user-nav" class="navbar navbar-inverse">
    <ul class="nav">

        <li class="dropdown" id="profile-messages">
            <a title="" href="#" data-toggle="dropdown" data-target="#profile-messages" class="dropdown-toggle">
                <i class="icon icon-user"></i>
                <span class="text">${session.getAttribute("user").name}【<g:message
                        code="user.role.${session.getAttribute("user").role_role}"/> 】</span>
                <b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
                <li><a href="<g:createLink controller="user" action="modifyPassword"/> "><i class="icon-key"></i> 修改密码
                </a></li>
                <li class="divider"></li>
                %{--<li><a href="#"><i class="icon-check"></i> My Tasks</a></li>--}%
                %{--<li class="divider"></li>--}%

            </ul>
        </li>
        %{--<li class="dropdown" id="menu-messages">--}%
        %{--<a href="#" data-toggle="dropdown" data-target="#menu-messages" class="dropdown-toggle">--}%
        %{--<i class="icon icon-envelope"></i>--}%
        %{--<span class="text">消息</span> <span class="label label-important">5</span>--}%
        %{--<b class="caret"></b>--}%
        %{--</a>--}%
        %{--<ul class="dropdown-menu">--}%
        %{--<li><a class="sAdd" title="" href="#"><i class="icon-plus"></i> new message</a></li>--}%
        %{--<li class="divider"></li>--}%
        %{--<li><a class="sInbox" title="" href="#"><i class="icon-envelope"></i> inbox</a></li>--}%
        %{--<li class="divider"></li>--}%
        %{--<li><a class="sOutbox" title="" href="#"><i class="icon-arrow-up"></i> outbox</a></li>--}%
        %{--<li class="divider"></li>--}%
        %{--<li><a class="sTrash" title="" href="#"><i class="icon-trash"></i> trash</a></li>--}%
        %{--</ul>--}%
        %{--</li>--}%
        %{--<li class=""><a title="" href="#"><i class="icon icon-cog"></i> <span class="text">Settings</span></a></li>--}%
        <li class="">
            <a title="" href="javascript:void(0)" onclick="history.back();">
                <i class="icon icon-arrow-left"></i> <span class="text">返回上一页</span>
                %{--<span class="label label-important">返回上一页</span>--}%
            </a>
        </li>
        <li class="">
            <a title="" href="<g:createLink controller="user" action="logout"/> ">
                <i class="icon icon-share-alt"></i> <span class="text">退出</span>
            </a>
        </li>
    </ul>
</div>

<!--start-top-serch-->
%{--<div id="search">--}%
%{--<input type="text" placeholder="Search here..."/>--}%
%{--<button type="submit" class="tip-bottom" title="Search"><i class="icon-search icon-white"></i></button>--}%
%{--</div>--}%
<!--close-top-serch-->

<!--sidebar-menu-->
<g:set var="ui" value="${session.getAttribute("user")}"></g:set>
<div id="sidebar"><a href="#" class="visible-phone"><i class="icon icon-th"></i>Tables</a>
    <ul>
    <g:if test="${ui.role_role > 8}">

        <li class="<g:if test="${controllerName == 'street' || controllerName == 'community'}">active</g:if>"><a
                href="<g:createLink controller="street" action="index"/>"><i
                    class="icon icon-home"></i> <span>社区街道管理</span></a>
            %{--<ul>--}%
            %{--<li><a href="<g:createLink controller="street" action="index"/>">街道管理</a></li>--}%
            %{--<li><a href="<g:createLink controller="community" action="index"/> ">社区管理</a></li>--}%

            %{--</ul>--}%
        </li>
    </g:if>

        <li class="submenu <g:if test="${controllerName == 'user'}">active</g:if>"><a href="#"><i
                class="icon icon-group"></i> <span>用户管理</span></a>
            <ul <g:if test="${controllerName == 'user'}">style="display: block;"</g:if>>

                <g:if test="${ui.role_role > 8}">
                    <li><a href="<g:createLink controller="user" action="index" params="['roleLv': '8']"/> ">街道管理员管理</a>
                    </li>
                </g:if>
                <g:if test="${ui.role_role > 6}">
                    <li><a href="<g:createLink controller="user" action="index" params="['roleLv': '6']"/>">社区管理员管理</a>
                    </li>
                </g:if>
                <g:if test="${ui.role_role > 4}">
                    <li><a href="<g:createLink controller="user" action="index" params="['roleLv': '4']"/>">社区从业人员管理</a>
                    </li>
                </g:if>
                <g:if test="${ui.role_role > 2}">
                    <li><a href="<g:createLink controller="user" action="index" params="['roleLv': '2']"/>">社区用户管理</a>
                    </li>
                </g:if>
                <li><a href="<g:createLink controller="user" action="index"
                                           params="['status': '1,3', 'roleLv': '2']"/> ">待审核用户</a></li>

            </ul>
        </li>
<g:if test="${ui.role_role > 4}">
        <li class="<g:if test="${controllerName == 'announcement'}">active</g:if>"><a
                href="<g:createLink controller="announcement" action="index"/> "><i
                    class="icon icon-bullhorn"></i> <span>公告管理</span></a></li>
</g:if>
<g:if test="${ui.role_role > 4}">
        <li class="<g:if test="${controllerName == 'poll'}">active</g:if>"><a
                href="<g:createLink controller="poll" action="index"/> "><i
                    class="icon icon-check"></i> <span>民意征询管理</span></a></li>
</g:if>
    <g:if test="${ui.role_role > 4}">
        <li class="<g:if test="${controllerName == 'suggestion'}">active</g:if>"><a
                href="<g:createLink controller="suggestion" action="indexOpining"/> "><i
                    class="icon icon-envelope"></i> <span>居民意见管理</span></a></li>
    </g:if>
<g:if test="${ui.role_role > 8}">
        <li class="<g:if test="${controllerName == 'serviceDepartment'}">active</g:if>"><a
                href="<g:createLink controller="serviceDepartment" action="index"/> "><i
                    class="icon icon-bookmark"></i> <span>社区服务管理</span></a></li>
</g:if>
<g:if test="${ui.role_role > 2}">
        <li class="<g:if test="${controllerName == 'yyfw'}">active</g:if>"><a
                href="<g:createLink controller="yyfw" action="index"/> "><i
                    class="icon icon-calendar"></i> <span>服务预约管理</span></a></li>
</g:if>
<g:if test="${ui.role_role > 4}">
        <li class="<g:if test="${controllerName == 'desire'}">active</g:if>"><a
                href="<g:createLink controller="desire" action="index"/> "><i
                    class="icon icon-heart"></i> <span>心愿管理</span></a></li>
</g:if>
<g:if test="${ui.role_role > 8}">
        <li class="<g:if test="${controllerName == 'score'}">active</g:if>"><a
                href="<g:createLink controller="score" action="index"/> "><i
                    class="icon icon-trophy"></i> <span>积分配置管理</span></a></li>
</g:if>
    <g:if test="${ui.role_role > 4}">
        <li class="<g:if test="${controllerName == 'topic'}">active</g:if>"><a
                href="<g:createLink controller="topic" action="index"/> "><i
                    class="icon icon-comments"></i> <span>话题讨论管理</span></a></li>
    </g:if>
        <li class="submenu"><a href="#"><i class="icon icon-tags"></i> <span>系统日志</span></a>
            <ul>
                <li><a href="<g:createLink controller="inc" action="streetList"/> ">用户日志</a></li>
                <li><a href="<g:createLink controller="inc" action="communityList"/>">操作日志</a></li>
            </ul>
        </li>

    </ul>
</div>

<g:layoutBody/>

<!--Footer-part-->
<div class="row-fluid">
    <div id="footer" class="span12">2016 &copy; 克拉玛依智慧社区平台.</div>
</div>
<!--end-Footer-part-->
<script src="<g:resource dir="system/js" file="jquery.min.js"/>"></script>
<script src="<g:resource dir="system/js" file="jquery.ui.custom.js"/>"></script>
<script src="<g:resource dir="system/js" file="bootstrap.min.js"/>"></script>
<script src="<g:resource dir="system/js" file="bootstrap-colorpicker.js"/>"></script>
<script src="<g:resource dir="system/js" file="masked.js"/>"></script>

<script src="<g:resource dir="system/js" file="jquery.uniform.js"/>"></script>
<script src="<g:resource dir="system/js" file="select2.min.js"/>"></script>
<script src="<g:resource dir="system/js" file="jquery.dataTables.min.js"/>"></script>
<script src="<g:resource dir="system/js" file="matrix.js"/>"></script>
<script src="<g:resource dir="system/js" file="matrix.tables.js"/>"></script>
<script src="<g:resource dir="system/js" file="bootstrap-datepicker.js"/>"></script>
<script src="<g:resource dir="system/js" file="bootstrap-wysihtml5.js"/>"></script>
<script src="<g:resource dir="system/js" file="matrix.form_common.js"/>"></script>
<script src="<g:resource dir="system/js" file="wysihtml5-0.3.0.js"/>"></script>
<script src="<g:resource dir="system/js" file="jquery.peity.min.js"/>"></script>

</body>
</html>
