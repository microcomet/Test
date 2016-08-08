<%@ page import="smartcommunity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layoutHome">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
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
        <hr>
        <g:if test="${flash.message}">
            <div class="alert alert-info alert-block"><a class="close" data-dismiss="alert" href="#">×</a>
                <h4 class="alert-heading">信息!</h4>
                ${flash.message}
            </div>

        </g:if>

        <g:if test="${params.roleLv == '8'}">
            <p>
                <a href="<g:createLink controller="user" action="create" params="[roleLv: 8]"/> "
                   class="btn btn-primary">新建街道管理员</a>
            </p>
        </g:if>
        <g:if test="${params.roleLv == '6'}">
            <p>
                <a href="<g:createLink controller="user" action="create" params="[roleLv: 6]"/> "
                   class="btn btn-primary">新建社区管理员</a>
            </p>
        </g:if>
        <g:if test="${params.roleLv == '4'}">
            <p>
                <a href="<g:createLink controller="user" action="create" params="[roleLv: 4]"/> "
                   class="btn btn-primary">新建社区从业人员</a>
            </p>
        </g:if>
        <div class="controls">
            <g:form controller="user" action="index">
                <input type="hidden" name="roleLv" class="span2" placeholder="用户类型" value="${params.roleLv}">
                <input type="text" name="name" class="span2" placeholder="用户名" value="${params.name}">
                %{--<input type="text" name="identity_id" class="span2" placeholder="身份证号" value="${params.identity_id}">--}%
                <g:if test="${params.roleLv=='8'}">
                    <g:include controller="userInc" action="createUser" params="[search:1,c_show:'n']"/>
                </g:if>
                <g:else>
                    <g:include controller="userInc" action="createUser" params="[search:1,c_show:'y']"/>
                </g:else>



                <select name="status" style="width:120px;">
                    <option value=" " selected="selected">选择状态</option>
                    <g:each in="${0..3}" var="idx">
                        <option value="${idx}" <g:if test="${params.int('status')==idx}">selected</g:if> ><g:message code="user.status.${idx}"/> </option>
                    </g:each>
                </select>
                <button type="submit" style="margin-top: -10px" class="btn btn-success">搜索</button>
            </g:form>

        </div>

        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"><i class="icon-th"></i></span>
                        <h5>用户列表</h5>
                    </div>

                    <div class="widget-content nopadding">
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>用户姓名</th>

                                <th>昵称</th>

                                <g:if test="${params.int('roleLv')<4}">
                                <th width="130px">身份证号</th>
                                </g:if>
                                <th>街道</th>
                                <g:if test="${params.int('roleLv')<4}">
                                <th>社区</th>
                                </g:if>
                                <th>电话</th>
                                %{--<th>地址</th>--}%
                                <th>状态</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>

                            <g:each in="${userInstanceList}" status="i" var="user">
                                <tr class="${(i % 2) == 0 ? 'even gradeC' : 'odd gradeX'}">
                                    <td>${user.id}</td>
                                    <td>${user.name}</td>
                                    <td>${user.nick_name}</td>
                                    <g:if test="${params.int('roleLv')<4}">
                                    <td>${user.identity_id}</td>
                                </g:if>
                                    <td>
                                        <g:if test="${user.street!=null}">
                                            ${user.street?.name}

                                        </g:if>
                                        <g:elseif test="${user.community!=null}">
                                            ${user.community?.street?.name}
                                        </g:elseif>

                                    </td>
                                    <g:if test="${params.int('roleLv')<4}">
                                    <td>${user.community?.name}</td>
                                </g:if>
                                    <td>${user.mobile}</td>
                                    %{--<td>${user.address}</td>--}%
                                    <td>
                                        <g:set var="lab" value=""/>
                                        <g:if test="${user.status == 0}">
                                            <g:set var="lab" value="label-success"/>
                                        </g:if>
                                        <g:elseif test="${user.status == 1}">
                                            <g:set var="lab" value="label-warning"/>
                                        </g:elseif>
                                        <g:elseif test="${user.status == 2}">
                                            <g:set var="lab" value="label-success"/>
                                        </g:elseif>
                                        <g:elseif test="${user.status == 3}">
                                            <g:set var="lab" value="label-important"/>
                                        </g:elseif>
                                        <span class="label ${lab}">
                                            <g:message message="user.status.${user.status}"/>
                                        </span>

                                    </td>
                                    <td>${user.create_time.format("yyyy-MM-dd HH:mm:ss")}</td>
                                    <td>

                                        <div class="fr">

                                            <g:if test="${user.status == 1 || user.status == 3}">
                                                <a href="<g:createLink controller="user" action="auditing"
                                                                       id="${user.id}"/> "
                                                   class="btn btn-primary btn-mini">审核</a>
                                            </g:if><g:elseif test="${user.status == 2}">
                                            <a href="<g:createLink controller="user" action="update" id="${user.id}"
                                                                   params="[status: 4]"/>"
                                               class="btn btn-info btn-mini">冻结</a>
                                        </g:elseif>
                                            <g:elseif test="${user.status == 4}">
                                                <a href="<g:createLink controller="user" action="update" id="${user.id}"
                                                                       params="[status: 2]"/>"
                                                   class="btn btn-info btn-mini">解冻</a>
                                            </g:elseif>
                                            <a href="<g:createLink controller="user" action="show" id="${user.id}"
                                                                   />" class="btn btn-success btn-mini">详情</a>
                                            <g:if test="${user.status != 5}">
                                                <a href="delete/${user.id}" class="btn btn-danger btn-mini"
                                                    onClick="return confirm('确定删除?');">删除</a>
                                            </g:if>
                                        </div>
                                    </td>
                                </tr>
                            </g:each>

                        </tbody>
                        </table>
                    </div>
                </div>

                <div class="paginationpage">
                    <g:paginate total="${total ?: 0}" params="${params}"/>
                </div>

            </div>
        </div>
    </div>
</div>

</body>
</html>
