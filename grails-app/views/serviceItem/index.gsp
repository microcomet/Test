<%@ page import="smartcommunity.ServiceItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layoutHome">
    <g:set var="entityName" value="${message(code: 'serviceItem.label', default: 'ServiceItem')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<div id="content">
    <div id="content-header">
        <div id="breadcrumb">
            %{--<a href="#" title="前往首页" class="tip-bottom"><i class="icon-home"></i> 首页</a>--}%
            <g:include controller="inc" action="incHome"/>
            <a href="<g:createLink controller="serviceDepartment" action="index"/>" class="current">部门管理</a>
            <a href="#" class="current">业务管理</a>
        </div>
        %{--<h1>Tables</h1>--}%

    </div>

    <div class="container-fluid">
        <hr>

        <p>
            <a href="<g:createLink controller="serviceItem" action="create" params="[did:params.id]"/> " class="btn btn-primary">新建业务</a>
        </p>

        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"><i class="icon-th"></i></span>
                        <h5>业务列表</h5>
                    </div>

                    <div class="widget-content nopadding">
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>部门名称</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                            </thead>

                            <g:each in="${serviceItemInstanceList}" status="i" var="serviceItemInstance">
                                <tr class="${(i % 2) == 0 ? 'even gradeC' : 'odd gradeX'}">
                                    <td>${serviceItemInstance.id}</td>
                                    <td>${serviceItemInstance.name}</td>
                                    <td>
                                        <g:set var="lab" value=""/>
                                        <g:if test="${serviceItemInstance.status == 1}">
                                            <g:set var="lab" value="label-success"/>
                                        </g:if>
                                        <g:elseif test="${serviceItemInstance.status == 2}">
                                            <g:set var="lab" value="label-warning"/>
                                        </g:elseif>

                                        <span class="label ${lab}">
                                            <g:message message="serviceItem.status.${serviceItemInstance.status}"/>
                                        </span>
                                        %{--${serviceItemInstance.status}--}%
                                    </td>
                                    <td>
                                        <div class="fr">
                                            <a href="<g:createLink controller="serviceItem" action="edit"
                                                                   id="${serviceItemInstance.id}"/>"
                                               class="btn btn-primary btn-mini">修改</a>


                                            <g:if test="${serviceItemInstance.status==2}">
                                                <a href="<g:createLink controller="serviceItem" action="update"
                                                                       id="${serviceItemInstance.id}" params="[status:1]"/>"
                                                   class="btn btn-success btn-mini">恢复</a>

                                            </g:if>

                                            <g:if test="${serviceItemInstance.status==1}">
                                                <a href="<g:createLink controller="serviceItem" action="update"
                                                                       id="${serviceItemInstance.id}" params="[status:2]"/>"
                                                   class="btn btn-danger btn-mini">关闭</a>
                                            </g:if>







                                            <a onclick="if (confirm('确认删除吗?删除后无法恢复!') == false)return false;"
                                               href="<g:createLink controller="serviceItem" action="delete"
                                                                   id="${serviceItemInstance.id}"/>"
                                               class="btn btn-danger btn-mini">删除</a>
                                        </div>
                                    </td>
                                </tr>
                            </g:each>

                        </tbody>
                        </table>
                    </div>
                </div>

                <div class="pagination">
                    <g:paginate total="${serviceItemInstanceCount ?: 0}"/>
                </div>
            </div>
        </div>
    </div>
</div>













%{--<a href="#list-serviceItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--}%
%{--<div class="nav" role="navigation">--}%
%{--<ul>--}%
%{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
%{--<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
%{--</ul>--}%
%{--</div>--}%
%{--<div id="list-serviceItem" class="content scaffold-list" role="main">--}%
%{--<h1><g:message code="default.list.label" args="[entityName]" /></h1>--}%
%{--<g:if test="${flash.message}">--}%
%{--<div class="message" role="status">${flash.message}</div>--}%
%{--</g:if>--}%
%{--<table>--}%
%{--<thead>--}%
%{--<tr>--}%
%{----}%
%{--<g:sortableColumn property="name" title="${message(code: 'serviceItem.name.label', default: 'Name')}" />--}%
%{----}%
%{--<g:sortableColumn property="detail" title="${message(code: 'serviceItem.detail.label', default: 'Detail')}" />--}%
%{----}%
%{--<th><g:message code="serviceItem.department.label" default="Department" /></th>--}%
%{----}%
%{--<g:sortableColumn property="create_time" title="${message(code: 'serviceItem.create_time.label', default: 'Createtime')}" />--}%
%{----}%
%{--<g:sortableColumn property="update_time" title="${message(code: 'serviceItem.update_time.label', default: 'Updatetime')}" />--}%
%{----}%
%{--</tr>--}%
%{--</thead>--}%
%{--<tbody>--}%
%{--<g:each in="${serviceItemInstanceList}" status="i" var="serviceItemInstance">--}%
%{--<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">--}%
%{----}%
%{--<td><g:link action="show" id="${serviceItemInstance.id}">${fieldValue(bean: serviceItemInstance, field: "name")}</g:link></td>--}%
%{----}%
%{--<td>${fieldValue(bean: serviceItemInstance, field: "detail")}</td>--}%
%{----}%
%{--<td>${fieldValue(bean: serviceItemInstance, field: "department")}</td>--}%
%{----}%
%{--<td><g:formatDate date="${serviceItemInstance.create_time}" /></td>--}%
%{----}%
%{--<td><g:formatDate date="${serviceItemInstance.update_time}" /></td>--}%
%{----}%
%{--</tr>--}%
%{--</g:each>--}%
%{--</tbody>--}%
%{--</table>--}%
%{--<div class="pagination">--}%
%{--<g:paginate total="${serviceItemInstanceCount ?: 0}" />--}%
%{--</div>--}%
%{--</div>--}%
</body>
</html>
