<%@ page import="smartcommunity.PollRecord" %>



<div class="fieldcontain ${hasErrors(bean: pollRecordInstance, field: 'poll', 'error')} required">
	<label for="poll">
		<g:message code="pollRecord.poll.label" default="Poll" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="poll" name="poll.id" from="${smartcommunity.Poll.list()}" optionKey="id" required="" value="${pollRecordInstance?.poll?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollRecordInstance, field: 'voter', 'error')} required">
	<label for="voter">
		<g:message code="pollRecord.voter.label" default="Voter" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="voter" name="voter.id" from="${smartcommunity.User.list()}" optionKey="id" required="" value="${pollRecordInstance?.voter?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollRecordInstance, field: 'vote_time', 'error')} required">
	<label for="vote_time">
		<g:message code="pollRecord.vote_time.label" default="Votetime" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="vote_time" precision="day"  value="${pollRecordInstance?.vote_time}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: pollRecordInstance, field: 'pollOption', 'error')} required">
	<label for="pollOption">
		<g:message code="pollRecord.pollOption.label" default="Poll Option" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="pollOption" name="pollOption.id" from="${smartcommunity.PollOption.list()}" optionKey="id" required="" value="${pollRecordInstance?.pollOption?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollRecordInstance, field: 'score', 'error')} required">
	<label for="score">
		<g:message code="pollRecord.score.label" default="Score" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="score" type="number" value="${pollRecordInstance.score}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollRecordInstance, field: 'status', 'error')} required">
	<label for="status">
		<g:message code="pollRecord.status.label" default="Status" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="status" type="number" value="${pollRecordInstance.status}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollRecordInstance, field: 'create_time', 'error')} ">
	<label for="create_time">
		<g:message code="pollRecord.create_time.label" default="Createtime" />
		
	</label>
	<g:datePicker name="create_time" precision="day"  value="${pollRecordInstance?.create_time}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: pollRecordInstance, field: 'update_time', 'error')} ">
	<label for="update_time">
		<g:message code="pollRecord.update_time.label" default="Updatetime" />
		
	</label>
	<g:datePicker name="update_time" precision="day"  value="${pollRecordInstance?.update_time}" default="none" noSelection="['': '']" />

</div>

