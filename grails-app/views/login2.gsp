<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 16/6/1
  Time: 下午2:23
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">

<head>
    <title>克拉玛依社区服务平台</title><meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="<g:resource dir="system/css" file="bootstrap.min.css"/>" />
    <link rel="stylesheet" href="<g:resource dir="system/css" file="bootstrap-responsive.min.css"/>" />
    <link rel="stylesheet" href="<g:resource dir="system/css" file="matrix-login.css"/>" />
    <link rel="stylesheet" href="<g:resource dir="system/font-awesome/css" file="font-awesome.css"/>" />
    %{--<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>--}%

</head>
<body>
<div id="loginbox">
    <g:if test="${flash.message}">

        <script>
            alert("${flash.message}");
        </script>
        %{--<div class="message" role="status"></div>--}%
    </g:if>
    <g:form class="form-vertical" controller="user" action="login" method="post">
        <div class="control-group normal_text"> <h3><img src="<g:resource dir="system/images" file="login.png"/>" alt="Logo" /></h3></div>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_lg"><i class="icon-user"></i></span>
                    <input name="name" type="text" placeholder="用户名" />
                    %{--<g:textField name="name" maxlength="100" required="" value="${userInstance?.name}"/>--}%
                </div>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_ly"><i class="icon-lock"></i></span>
                    <input name="password" type="password" placeholder="密码" />
                    %{--<g:passwordField name="password" maxlength="50" required="" value="${userInstance?.password}" type="password"/>--}%
                </div>
            </div>
        </div>
        <div class="form-actions">
            %{--<span class="pull-left"><a href="#" class="flip-link btn btn-info" id="to-recover">Lost password?</a></span>--}%
            <span class="pull-right">
                %{--<a type="submit" href="user/login" class="btn btn-success" > 登录</a>--}%
            <input type="submit" value="登录" class="btn btn-success"/>
            </span>
        </div>
    </g:form>

    %{--<form id="recoverform" action="#" class="form-vertical">--}%
        %{--<p class="normal_text">Enter your e-mail address below and we will send you instructions how to recover a password.</p>--}%

        %{--<div class="controls">--}%
            %{--<div class="main_input_box">--}%
                %{--<span class="add-on bg_lo"><i class="icon-envelope"></i></span><input type="text" placeholder="E-mail address" />--}%
            %{--</div>--}%
        %{--</div>--}%

        %{--<div class="form-actions">--}%
            %{--<span class="pull-left"><a href="#" class="flip-link btn btn-success" id="to-login">&laquo; Back to login</a></span>--}%
            %{--<span class="pull-right"><a class="btn btn-info"/>Reecover</a></span>--}%
        %{--</div>--}%
    %{--</form>--}%
</div>

<script src="<g:resource dir="system/js" file="jquery.min.js"/>"></script>
<script src="<g:resource dir="system/js" file="matrix.login.js"/>"></script>

</body>

</html>
