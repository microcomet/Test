<%@ page import="smartcommunity.DesireImage" %>



<div class="fieldcontain ${hasErrors(bean: desireImageInstance, field: 'desire', 'error')} required">
	<label for="desire">
		<g:message code="desireImage.desire.label" default="Desire" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="desire" name="desire.id" from="${smartcommunity.Desire.list()}" optionKey="id" required="" value="${desireImageInstance?.desire?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: desireImageInstance, field: 'image', 'error')} required">
	<label for="image">
		<g:message code="desireImage.image.label" default="Image" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="image" name="image.id" from="${smartcommunity.Image.list()}" optionKey="id" required="" value="${desireImageInstance?.image?.id}" class="many-to-one"/>

</div>

