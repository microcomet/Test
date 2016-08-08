<%@ page import="smartcommunity.ServiceReservation" %>




<div class="control-group">
	<label class="control-label">
		<g:message code="serviceReservation.serviceItem.label" default="Service Item" />
	</label>
	<div class="controls">

		${serviceReservationInstance?.serviceItem?.name}

	</div>
</div>


<div class="control-group">
	<label class="control-label">
		<g:message code="serviceReservation.reserve_person.label" default="Reserveperson" />
	</label>
	<div class="controls">

		${serviceReservationInstance?.reserve_person?.name}

	</div>
</div>

<div class="control-group">
	<label class="control-label">
		<g:message code="serviceReservation.status.label" default="Status" />
	</label>
	<div class="controls">


		<select name="status" style="width:120px;">
			<g:each in="${2..3}" var="idx">
				<option value="${idx}" <g:if test="${params.int('status')==idx}">selected</g:if> ><g:message code="serviceReservation.status.${idx}"/> </option>
			</g:each>
		</select>

	</div>
</div>

<div class="control-group">
	<label class="control-label">
		<g:message code="serviceReservation.server_desc.label" default="Serverdesc" />
	</label>
	<div class="controls">

		<g:textArea name="server_desc" value="${serviceReservationInstance?.server_desc}"/>

	</div>
</div>




%{--<div class="fieldcontain ${hasErrors(bean: serviceReservationInstance, field: 'clerk', 'error')} ">--}%
	%{--<label for="clerk">--}%
		%{--<g:message code="serviceReservation.clerk.label" default="Clerk" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:select id="clerk" name="clerk.id" from="${smartcommunity.User.list()}" optionKey="id" value="${serviceReservationInstance?.clerk?.id}" class="many-to-one" noSelection="['null': '']"/>--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: serviceReservationInstance, field: 'create_time', 'error')} ">--}%
	%{--<label for="create_time">--}%
		%{--<g:message code="serviceReservation.create_time.label" default="Createtime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="create_time" precision="day"  value="${serviceReservationInstance?.create_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: serviceReservationInstance, field: 'update_time', 'error')} ">--}%
	%{--<label for="update_time">--}%
		%{--<g:message code="serviceReservation.update_time.label" default="Updatetime" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:datePicker name="update_time" precision="day"  value="${serviceReservationInstance?.update_time}" default="none" noSelection="['': '']" />--}%

%{--</div>--}%

