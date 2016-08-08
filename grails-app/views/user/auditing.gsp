<%@ page import="smartcommunity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layoutHome">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>

<g:if test="${flash.message}">
    <div class="alert alert-info alert-block"><a class="close" data-dismiss="alert" href="#">×</a>
        <h4 class="alert-heading">信息!</h4>
        ${flash.message}
    </div>

</g:if>

<g:hasErrors bean="${userInstance}">

    <div class="alert alert-error alert-block"> <a class="close" data-dismiss="alert" href="#">×</a>
        <h4 class="alert-heading">错误!</h4>

    <g:eachError bean="${userInstance}" var="error">
        <g:message error="${error}"/></br>
    </g:eachError>

    </div>
</g:hasErrors>

<div id="content">
    <div id="content-header">
        <div id="breadcrumb">
            %{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
            <g:include controller="inc" action="incHome"/>
            <a href="<g:createLink controller="user" action="index" params="[roleLv: 2, status: 1]"/>"
               class="current">用户管理</a>
            <a href="#" class="current">用户审核</a>
        </div>
        %{--<h1>Tables</h1>--}%

    </div>


    <div class="container-fluid"><hr>

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
                                    <tr>
                                        <td><g:message code="user.nick_name.label"
                                                       default="Nickname"/></td>
                                        <td><strong><g:fieldValue
                                                bean="${userInstance}" field="nick_name"/></strong></td>
                                    </tr>
                                    <tr>
                                        <td><g:message code="user.identity_id.label"
                                                       default="Identityid"/></td>
                                        <td><strong><g:fieldValue
                                                bean="${userInstance}" field="identity_id"/></strong></td>
                                    </tr>


                                    <tr>
                                        <td><g:message code="user.mobile.label"
                                                       default="Mobile"/>

                                        </td>
                                        <td><strong><g:fieldValue bean="${userInstance}"
                                                                  field="mobile"/>

                                        </strong></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <g:message code="user.address.label"
                                                       default="Address"/>
                                        </td>
                                        <td><strong>
                                            <g:fieldValue
                                                    bean="${userInstance}" field="address"/>
                                        </strong></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <g:message code="user.community.label"
                                                       default="Community"/>
                                        </td>
                                        <td><strong>
                                            ${userInstance?.community?.street?.name} -
                                            ${userInstance?.community?.name}
                                        </strong></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <g:message
                                                    code="user.social_security_card_id.label"
                                                    default="Socialsecuritycardid"/>
                                        </td>
                                        <td><strong>
                                            <g:fieldValue
                                                    bean="${userInstance}" field="social_security_card_id"/>
                                        </strong></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <g:message code="user.head_url.label"
                                                       default="Headurl"/>
                                        </td>
                                        <td><strong>
                                            <g:if test="${userInstance.potrait_id!=null}">
                                                <img src="<g:createLink controller="image" action="getSingleImage" id="${userInstance.potrait_id}"/> " height="150px" width="150px">
                                            </g:if>
                                            %{--<g:fieldValue--}%
                                                    %{--bean="${userInstance}" field="head_url"/>--}%
                                        </strong></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <g:message code="user.status.label"
                                                       default="Status"/>
                                        </td>
                                        <td><strong>
                                            <g:set var="lab" value=""/>
                                            <g:if test="${userInstance.status==0}">
                                                <g:set var="lab" value="label-success"/>
                                            </g:if>
                                            <g:elseif test="${userInstance.status==1}">
                                                <g:set var="lab" value="label-warning"/>
                                            </g:elseif>
                                            <g:elseif test="${userInstance.status==2}">
                                                <g:set var="lab" value="label-success"/>
                                            </g:elseif>
                                            <g:elseif test="${userInstance.status==3}">
                                                <g:set var="lab" value="label-important"/>
                                            </g:elseif>
                                            <span class="label ${lab}">
                                                <g:message message="user.status.${userInstance.status}"/>
                                            </span>
                                        </strong></td>
                                    </tr>



                                    <tr>
                                        <td>
                                            <g:message code="user.create_time.label"
                                                       default="Createtime"/>
                                        </td>
                                        <td><strong>
                                            <g:formatDate
                                                    date="${userInstance?.create_time}" format="yyyy-MM-dd HH:mm:ss"/>
                                        </strong></td>
                                    </tr>
                                    <g:form url="[resource: userInstance, action: 'update']" method="POST">
                                        <g:hiddenField name="version" value="${userInstance?.version}" />
                                        <g:hiddenField name="id" value="${userInstance?.id}" />
                                    <tr>
                                        <td>
                                            <g:message code="user.auditing.label" default="Status"/>
                                        </td>
                                        <td><strong>
                                            <g:select name="status" from="${2..3}" required=""
                                                      value="${fieldValue(bean: userInstance, field: 'status')}"
                                                      valueMessagePrefix="user.status"/>
                                        </strong></td>
                                    </tr>

                                        <tr>
                                            <td>
                                                <g:message code="user.auditing_desc.label" default="Auditingdesc"/>
                                            </td>
                                            <td><strong>
                                                <g:textArea name="auditing_desc" cols="40" rows="5" maxlength="200"
                                                            required=""
                                                            value="${userInstance?.auditing_desc}"/>
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








</div>
</body>
</html>
