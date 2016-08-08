<%@ page import="smartcommunity.User" %>

<div class="control-group">
	<label class="control-label">
		<g:message code="user.role.label" default="Role" />

	</label>
	<div class="controls">
		<input type="text" value="${smartcommunity.Role.findByRole(params.roleLv).name}" disabled>

		<div style="display: none">
		<g:select id="role"  name="role.id" from="${smartcommunity.Role.list()}" optionKey="id" optionValue="name" required="" value="${smartcommunity.Role.findByRole(params.roleLv).id}" class="many-to-one" />

	</div>

	</div>
</div>

<g:include controller="userInc" action="createUser"></g:include>

%{--<div class="control-group">--}%
	%{--<label class="control-label">--}%
		%{--<g:message code="user.street.label" default="street" />--}%

	%{--</label>--}%
	%{--<div class="controls">--}%
		%{--<g:select id="street" name="street.id" from="${streetList}" optionKey="id" optionValue="name" value="${userInstance?.street?.id}" class="many-to-one" />--}%

	%{--</div>--}%
%{--</div>--}%
%{--<div class="control-group" style="display: none;">--}%
	%{--<label class="control-label">--}%
		%{--<g:message code="user.community.label" default="Community" />--}%

	%{--</label>--}%
	%{--<div class="controls">--}%
		%{--<g:select id="community" name="community.id" from="${smartcommunity.Community.list()}" optionKey="id" value="${userInstance?.community?.id}" class="many-to-one" noSelection="${['null':'Select One...']}"/>--}%

	%{--</div>--}%
%{--</div>--}%

<div class="control-group">
	<label class="control-label">
		<g:message code="user.name.label" default="Name" />*
	</label>
	<div class="controls">
		<g:textField name="name" maxlength="100" required="" value="${userInstance?.name}"/>

	</div>
</div>
<div class="control-group">
	<label class="control-label">
		<g:message code="user.password.label" default="Password" />*

	</label>
	<div class="controls">
		<g:passwordField name="password" maxlength="50" required="" value="${userInstance?.password}" type="password"/>

	</div>
</div>
<div class="control-group">
	<label class="control-label">
		<g:message code="user.nick_name.label" default="Nickname" />*

	</label>
	<div class="controls">
		<g:textField name="nick_name" maxlength="100" required="" value="${userInstance?.nick_name}"/>

	</div>
</div>
<div class="control-group" style="display: none;">
	<label class="control-label">
		<g:message code="user.identity_id.label" default="Identityid" />*

	</label>
	<div class="controls">
		<g:textField name="identity_id" maxlength="30" required="" value="${userInstance?.identity_id?userInstance?.identity_id:0}"/>

	</div>
</div>
<div class="control-group">
	<label class="control-label">
		<g:message code="user.mobile.label" default="Mobile" />*

	</label>
	<div class="controls">
		<g:textField name="mobile" maxlength="20" required="" value="${userInstance?.mobile}"/>

	</div>
</div>
<div class="control-group" style="display: none;">
	<label class="control-label">
		<g:message code="user.address.label" default="Address" />*

	</label>
	<div class="controls">
		<g:textArea name="address" cols="40" rows="5" maxlength="500" required="" value="新疆"/>

	</div>
</div>

%{--<div class="control-group">--}%
	%{--<label class="control-label">--}%
		%{--<g:message code="user.social_security_card_id.label" default="Socialsecuritycardid" />--}%

	%{--</label>--}%
	%{--<div class="controls">--}%
		%{--<g:textField name="social_security_card_id" maxlength="30" value="${userInstance?.social_security_card_id}"/>--}%

	%{--</div>--}%
%{--</div>--}%
%{--<div class="control-group">--}%
	%{--<label class="control-label">--}%
		%{--<g:message code="user.head_url.label" default="Headurl" />--}%

	%{--</label>--}%
	%{--<div class="controls">--}%
		%{--<g:textField name="head_url" maxlength="200" value="${userInstance?.head_url}"/>--}%

	%{--</div>--}%
%{--</div>--}%







%{--<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'status', 'error')} required">--}%
	%{--<label for="status">--}%
		%{--<g:message code="user.status.label" default="Status" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:select name="status" from="${userInstance.constraints.status.inList}" required="" value="${fieldValue(bean: userInstance, field: 'status')}" valueMessagePrefix="user.status"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'auditing_desc', 'error')} required">--}%
	%{--<label for="auditing_desc">--}%
		%{--<g:message code="user.auditing_desc.label" default="Auditingdesc" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:textArea name="auditing_desc" cols="40" rows="5" maxlength="200" required="" value="${userInstance?.auditing_desc}"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'create_time', 'error')} ">--}%
	%{--<label for="create_time">--}%
		%{--<g:message code="user.create_time.label" default="Createtime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="create_time" precision="day"  value="${userInstance?.create_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'role', 'error')} required">--}%
	%{--<label for="role">--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'update_time', 'error')} ">--}%
	%{--<label for="update_time">--}%
		%{--<g:message code="user.update_time.label" default="Updatetime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="update_time" precision="day"  value="${userInstance?.update_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

