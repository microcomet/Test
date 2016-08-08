<%@ page import="smartcommunity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layoutHome">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>



<div id="content">
    <div id="content-header">
        <div id="breadcrumb">
            %{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
            <g:include controller="inc" action="incHome"/>
            <a href="<g:createLink controller="user" action="index" params="[roleLv: 2, status: 1]"/>"
               class="current">修改密码</a>
        </div>
        %{--<h1>Tables</h1>--}%

    </div>


    <div class="container-fluid"><hr>


        <g:if test="${flash.message}">
            <div class="alert alert-error alert-block"> <a class="close" data-dismiss="alert" href="#">×</a>
                <h4 class="alert-heading">错误!</h4>
                ${flash.message}
            </div>

        </g:if>

        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"><i class="icon-briefcase"></i></span>
                        <h5>用户资料</h5>
                    </div>

                    <div class="widget-content">
                        <div class="row-fluid">

                            <div class="span6">
                                <table class="table table-bordered table-invoice">
                                    <tbody>
                                    <tr>
                                    </tr><tr>
                                        <td class="width30">
                                            <g:message code="user.name.label" default="Name"/>
                                        </td>
                                        <td class="width70">
                                            <strong>
                                                <g:fieldValue bean="${userInstance}" field="name"/>
                                            </strong>
                                        </td>
                                    </tr>
                                    <g:form url="[resource: userInstance, action: 'confirmNewPassword']" method="POST">
                                        <g:hiddenField name="version" value="${userInstance?.version}" />
                                        <g:hiddenField name="id" value="${userInstance?.id}" />
                                    <tr>
                                        <td>
                                            <g:message code="user.oldPwd.label" default="Old Password"/>
                                        </td>
                                        <td><strong>
                                            <g:passwordField name="oldPwd" cols="40" rows="5" maxlength="200"
                                                        required="" />
                                        </strong></td>
                                    </tr>

                                        <tr>
                                            <td>
                                                <g:message code="user.newPwd.label" default="New Password"/>
                                            </td>
                                            <td><strong>
                                                <g:passwordField name="newPwd" cols="40" maxlength="200"
                                                            required="" />
                                            </strong></td>
                                        </tr>

                                        <tr>
                                            <td></td>
                                            <td><g:actionSubmit class="btn btn-success" action="confirmNewPassword"
                                                                value="提交"/></td>
                                        </tr>

                                    </g:form>

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








</div>
</body>
</html>
