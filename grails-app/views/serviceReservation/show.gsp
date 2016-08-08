
<%@ page import="smartcommunity.ServiceReservation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'serviceReservation.label', default: 'ServiceReservation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-serviceReservation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-serviceReservation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list serviceReservation">
			
				<g:if test="${serviceReservationInstance?.serviceItem}">
				<li class="fieldcontain">
					<span id="serviceItem-label" class="property-label"><g:message code="serviceReservation.serviceItem.label" default="Service Item" /></span>
					
						<span class="property-value" aria-labelledby="serviceItem-label"><g:link controller="serviceItem" action="show" id="${serviceReservationInstance?.serviceItem?.id}">${serviceReservationInstance?.serviceItem?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceReservationInstance?.reserve_person}">
				<li class="fieldcontain">
					<span id="reserve_person-label" class="property-label"><g:message code="serviceReservation.reserve_person.label" default="Reserveperson" /></span>
					
						<span class="property-value" aria-labelledby="reserve_person-label"><g:link controller="user" action="show" id="${serviceReservationInstance?.reserve_person?.id}">${serviceReservationInstance?.reserve_person?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceReservationInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="serviceReservation.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${serviceReservationInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceReservationInstance?.clerk}">
				<li class="fieldcontain">
					<span id="clerk-label" class="property-label"><g:message code="serviceReservation.clerk.label" default="Clerk" /></span>
					
						<span class="property-value" aria-labelledby="clerk-label"><g:link controller="user" action="show" id="${serviceReservationInstance?.clerk?.id}">${serviceReservationInstance?.clerk?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceReservationInstance?.create_time}">
				<li class="fieldcontain">
					<span id="create_time-label" class="property-label"><g:message code="serviceReservation.create_time.label" default="Createtime" /></span>
					
						<span class="property-value" aria-labelledby="create_time-label"><g:formatDate date="${serviceReservationInstance?.create_time}" /></span>
					
				</li>
				</g:if>

				<g:if test="${serviceReservationInstance?.order_date}">
					<li class="fieldcontain">
						<span id="order_date-label" class="property-label"><g:message code="serviceReservation.order_date.label" default="Orderdate" /></span>

						<span class="property-value" aria-labelledby="order_date-label"><g:formatDate date="${serviceReservationInstance?.order_date}" /></span>

					</li>
				</g:if>
			
				<g:if test="${serviceReservationInstance?.server_desc}">
				<li class="fieldcontain">
					<span id="server_desc-label" class="property-label"><g:message code="serviceReservation.server_desc.label" default="Serverdesc" /></span>
					
						<span class="property-value" aria-labelledby="server_desc-label"><g:fieldValue bean="${serviceReservationInstance}" field="server_desc"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceReservationInstance?.server_time}">
				<li class="fieldcontain">
					<span id="server_time-label" class="property-label"><g:message code="serviceReservation.server_time.label" default="Servertime" /></span>
					
						<span class="property-value" aria-labelledby="server_time-label"><g:formatDate date="${serviceReservationInstance?.server_time}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceReservationInstance?.update_time}">
				<li class="fieldcontain">
					<span id="update_time-label" class="property-label"><g:message code="serviceReservation.update_time.label" default="Updatetime" /></span>
					
						<span class="property-value" aria-labelledby="update_time-label"><g:formatDate date="${serviceReservationInstance?.update_time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:serviceReservationInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${serviceReservationInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
