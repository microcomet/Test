<%@ page import="smartcommunity.AnnouncementImage" %>



<div class="fieldcontain ${hasErrors(bean: announcementImageInstance, field: 'announcement', 'error')} required">
	<label for="announcement">
		<g:message code="announcementImage.announcement.label" default="Announcement" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="announcement" name="announcement.id" from="${smartcommunity.Announcement.list()}" optionKey="id" required="" value="${announcementImageInstance?.announcement?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: announcementImageInstance, field: 'image', 'error')} required">
	<label for="image">
		<g:message code="announcementImage.image.label" default="Image" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="image" name="image.id" from="${smartcommunity.Image.list()}" optionKey="id" required="" value="${announcementImageInstance?.image?.id}" class="many-to-one"/>

</div>

