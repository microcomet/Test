<%@ page import="smartcommunity.Image" %>



%{--<div class="fieldcontain ${hasErrors(bean: imageInstance, field: 'name', 'error')} required">--}%
	%{--<label for="name">--}%
		%{--<g:message code="image.name.label" default="Name" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:textField name="name" maxlength="200" required="" value="${imageInstance?.name}"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: imageInstance, field: 'storage_url', 'error')} required">--}%
	%{--<label for="storage_url">--}%
		%{--<g:message code="image.storage_url.label" default="Storageurl" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:textArea name="storage_url" cols="40" rows="5" maxlength="500" required="" value="${imageInstance?.storage_url}"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: imageInstance, field: 'upload_time', 'error')} required">--}%
	%{--<label for="upload_time">--}%
		%{--<g:message code="image.upload_time.label" default="Uploadtime" />--}%
		%{--<span class="required-indicator">*</span>--}%
	%{--</label>--}%
	%{--<g:datePicker name="upload_time" precision="day"  value="${imageInstance?.upload_time}"  />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: imageInstance, field: 'create_time', 'error')} ">--}%
	%{--<label for="create_time">--}%
		%{--<g:message code="image.create_time.label" default="Createtime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="create_time" precision="day"  value="${imageInstance?.create_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: imageInstance, field: 'status', 'error')} ">--}%
	%{--<label for="status">--}%
		%{--<g:message code="image.status.label" default="Status" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:field name="status" type="number" value="${imageInstance.status}"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: imageInstance, field: 'update_time', 'error')} ">--}%
	%{--<label for="update_time">--}%
		%{--<g:message code="image.update_time.label" default="Updatetime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="update_time" precision="day"  value="${imageInstance?.update_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

