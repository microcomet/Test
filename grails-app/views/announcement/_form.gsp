<%@ page import="smartcommunity.Announcement" %>


<script>
    function formcheck() {
        var str = document.getElementById("files").value;
        if (str == null || str == "") {
            return true;
        } else {
            var flag = false; //状态

            var arr = ["jpg", "png", "gif"];
            //取出上传文件的扩展名
            var index = str.lastIndexOf(".");
            var ext = str.substr(index + 1);

            //循环比较
            for (var i = 0; i < arr.length; i++) {
                if (ext == arr[i]) {
                    flag = true; //一旦找到合适的，立即退出循环
                    break;
                }
            }
            if (flag) {
//                alert("文件名合法");
            } else {
                alert("文件名不合法");
            }
//            return false;
			return flag;
        }

    }
</script>

<div class="control-group">
    <label class="control-label">
        <g:message code="announcement.title.label" default="Title"/>*
    </label>

    <div class="controls">
        <g:textField name="title" maxlength="250" required="" value="${announcementInstance?.title}"/>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="announcement.content.label" default="Content"/>*
    </label>

    <div class="controls">
        <g:textArea style="margin-left: 0" name="content" cols="40" rows="5" maxlength="3000" required=""
                    value="${announcementInstance?.content}"/>
    </div>
</div>



%{--<div class="control-group">--}%
%{--<label class="control-label">--}%
%{--<g:message code="announcement.street.label" default="Community" />--}%
%{--</label>--}%
%{--<div class="controls">--}%
%{--<g:select id="street" name="street.id" from="${smartcommunity.Street.list()}" optionKey="id" value="${announcementInstance?.street?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
%{--</div>--}%
%{--</div>--}%
%{--<div class="control-group">--}%
%{--<label class="control-label">--}%
%{--<g:message code="announcement.community.label" default="Community" />--}%
%{--</label>--}%
%{--<div class="controls">--}%
%{--<g:select id="community" name="community.id" from="${smartcommunity.Community.list()}" optionKey="id" value="${announcementInstance?.community?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
%{--</div>--}%
%{--</div>--}%
<g:include controller="userInc" action="createUser"
           params="[streetId: announcementInstance?.street?.id, communityId: announcementInstance?.community?.id]"></g:include>


%{--<div class="control-group">--}%
%{--<label class="control-label">--}%
%{----}%
%{--</label>--}%

%{--<div class="controls">--}%

%{--<g:field type="file" multiple="multiple" name="files" />--}%

%{--</div>--}%
%{--</div>--}%


<div class="control-group">
    <label class="control-label"><g:message code="announcement.files.label" default="Files"/></label>

    <div class="controls">
        <input type="file" multiple="multiple" name="files" id="files"/>
    </div>
</div>



