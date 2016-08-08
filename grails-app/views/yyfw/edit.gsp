<%@ page import="smartcommunity.Yyfw" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layoutHome">
    <g:set var="entityName" value="${message(code: 'yyfw.label', default: 'Yyfw')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>

<g:if test="${flash.message}">
    <div class="alert alert-info alert-block"><a class="close" data-dismiss="alert" href="#">×</a>
        <h4 class="alert-heading">信息!</h4>
        ${flash.message}
    </div>

</g:if>

<g:hasErrors bean="${yyfwInstance}">

    <div class="alert alert-error alert-block"> <a class="close" data-dismiss="alert" href="#">×</a>
        <h4 class="alert-heading">错误!</h4>

    <g:eachError bean="${yyfwInstance}" var="error">
        <g:message error="${error}"/></br>
    </g:eachError>

    </div>
</g:hasErrors>




<div id="content">
    <div id="content-header">
        <div id="breadcrumb">
            %{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
            <g:include controller="inc" action="incHome"/>
            <a href="<g:createLink controller="yyfw" action="index"/>"
               class="current">服务预约管理</a>
            <a href="#" class="current">预约操作</a>
        </div>
        %{--<h1>Tables</h1>--}%

    </div>


    <div class="container-fluid"><hr>

        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"><i class="icon-briefcase"></i></span>
                        <h5>预约资料</h5>
                    </div>

                    <div class="widget-content">
                        <div class="row-fluid">

                            <div class="span6">
                                <table class="table table-bordered table-invoice">
                                    <tbody>
                                    <tr>
                                    </tr>
                                    <tr>
                                        <td class="width30">
                                            预约服务
                                        </td>
                                        <td class="width70">
                                            <strong>
                                                ${yyfwInstance.fwmc}
                                            </strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="width30">
                                            预约人

                                        </td>
                                        <td class="width70">
                                            <strong>
                                                ${yyfwInstance.reservePerson.name}
                                            </strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="width30">
                                            预约时间

                                        </td>
                                        <td class="width70">
                                            <strong>
                                                <g:formatDate date="${yyfwInstance.orderTime}" format="yyyy-MM-dd"/>

                                                ${yyfwInstance.timeSlot}
                                            </strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="width30">
                                            发布时间

                                        </td>
                                        <td class="width70">
                                            <strong>
                                                <g:formatDate date="${yyfwInstance.createTime}" format="yyyy-MM-dd HH:mm:ss"/>
                                            </strong>
                                        </td>
                                    </tr>

                                    <g:form url="[resource: yyfwInstance, action: 'update']" method="PUT">
                                        <g:hiddenField name="version" value="${yyfwInstance?.version}"/>
                                        <g:hiddenField name="id" value="${yyfwInstance?.id}"/>

                                        <tr>
                                            <td>
                                                预约结果
                                            </td>
                                            <td><strong>
                                                <g:select name="status" from="${2..3}" required=""
                                                          value="${fieldValue(bean: yyfwInstance, field: 'status')}"
                                                          valueMessagePrefix="yyfw.status"/>
                                            </strong></td>
                                        </tr>

                                        <tr>
                                            <td>
                                                审核意见
                                            </td>
                                            <td><strong>
                                                <g:textArea name="serverDesc" cols="40" rows="5" maxlength="200"
                                                            required=""
                                                            value="${yyfwInstance?.serverDesc}"/>
                                            </strong></td>
                                        </tr>

                                        <tr>
                                            <td></td>
                                            <td><g:actionSubmit class="btn btn-success" action="update"
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

</body>
</html>
