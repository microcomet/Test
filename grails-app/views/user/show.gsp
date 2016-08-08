<%@ page import="smartcommunity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layoutHome">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div id="content">
    <div id="content-header">
        <div id="breadcrumb">
            %{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
            <g:include controller="inc" action="incHome"/>
            <a href="#" class="current">用户管理</a>
        </div>
        %{--<h1>Tables</h1>--}%

    </div>

    <div class="container-fluid">

        <div class="row-fluid">
            <div class="span8">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"><i class="icon-user"></i></span>
                        <h5>用户信息</h5>
                    </div>

                    <div class="widget-content nopadding">
                        <table class="table table-bordered">
                            %{--<thead>--}%
                            %{--<tr>--}%
                            %{--<th width="">Browser</th>--}%
                            %{--<th>Visits</th>--}%
                            %{--</tr>--}%
                            %{--</thead>--}%
                            <tbody>
                            <tr>
                                <td>姓名</td>
                                <td>${userInstance.name}</td>
                            </tr>
                            <tr>
                                <td>昵称</td>
                                <td>${userInstance.nick_name}</td>
                            </tr>
                            <tr>
                                <td>手机</td>
                                <td>${userInstance.mobile}</td>
                            </tr>
                            <tr>
                                <td>身份证</td>
                                <td>${userInstance.identity_id}</td>
                            </tr>
                            <tr>
                                <td>所在街道</td>
                                <td>${userInstance.community?.street?.name}</td>
                            </tr>
                            <tr>
                                <td>所在社区</td>
                                <td>${userInstance.community?.name}</td>
                            </tr>
                            <tr>
                                <td>状态</td>
                                <td>
                                    <g:set var="lab" value=""/>
                                    <g:if test="${userInstance.status == 0}">
                                        <g:set var="lab" value="label-success"/>
                                    </g:if>
                                    <g:elseif test="${userInstance.status == 1}">
                                        <g:set var="lab" value="label-warning"/>
                                    </g:elseif>
                                    <g:elseif test="${userInstance.status == 2}">
                                        <g:set var="lab" value="label-success"/>
                                    </g:elseif>
                                    <g:elseif test="${userInstance.status == 3}">
                                        <g:set var="lab" value="label-important"/>
                                    </g:elseif>
                                    <span class="label ${lab}">
                                        <g:message message="user.status.${userInstance.status}"/>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td>审核描述</td>
                                <td>${userInstance.auditing_desc}</td>
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
