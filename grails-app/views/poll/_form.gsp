<%@ page import="smartcommunity.Poll" %>


<div class="control-group">
	<label class="control-label">
		<g:message code="poll.title.label" default="Title" />
	</label>
	<div class="controls">
		<g:textField name="title" maxlength="250" required="" value="${pollInstance?.title}"/>

	</div>
</div>

<div class="control-group">
	<label class="control-label">
		<g:message code="poll.description.label" default="Description" />
	</label>
	<div class="controls">
		<g:textArea name="description" cols="40" rows="5" maxlength="2000" value="${pollInstance?.description}"/>


	</div>
</div>

<g:include controller="userInc" action="createUser"></g:include>

<div class="control-group">
	<label class="control-label">
		<g:message code="poll.rule.label" default="Rule" />

	</label>
	<div class="controls span3" style="margin-left: 20px">
		<select name="rule">
			<g:each in="${pollInstance.constraints.rule.inList}" var="r">
				<option value="${r}">${message(code:'poll.check.'+r)}</option>
			</g:each>
		</select>

	</div>
</div>

<div class="control-group">
	<label class="control-label">
		<g:message code="poll.max_select_num.label" default="Maxselectnum" />

	</label>
	<div class="controls">
		<g:field name="max_select_num" type="number" value="${pollInstance.max_select_num}"/>


	</div>
</div>


<div class="control-group">
	<label class="control-label">
		<g:message code="poll.score.label" default="Score" />

	</label>
	<div class="controls">
		<g:field name="score" type="number" value="${pollInstance.score? pollInstance.score:smartcommunity.Score.findByType(4).score}" required=""/>


	</div>
</div>

<div class="control-group">
	<label class="control-label">
		<g:message code="poll.start_time.label" default="Starttime" /> :

	</label>
	%{--<div class="controls span3" style="margin-left: 20px">--}%
		%{--<g:datePicker name="start_time" precision="day" relativeYears="[-2..10]" value="${pollInstance?.start_time}" default="none" noSelection="['': '']" />--}%



	%{--</div>--}%
	%{--<div class="controls">--}%
		%{--<div  data-date="12-02-2012" class="input-append date datepicker">--}%
			%{--<input type="text" name="start_time" value="${pollInstance.start_time}"  data-date-format="yyyy-mm-dd" class="span11" >--}%
			%{--<span class="add-on"><i class="icon-th"></i></span> </div>--}%
	%{--</div>--}%
	<div class="controls">
		<div  data-date="<g:formatDate date="${new java.util.Date()}" format="yyyy-MM-dd"/> " class="input-append date datepicker">
			<input type="text" name="start_time" date-format="yyyy-mm-dd" value="${pollInstance.start_time?new java.util.Date():pollInstance.start_time}" class="span11" >
			<span class="add-on"><i class="icon-th"></i></span> </div>
	</div>
</div>
<div class="control-group">
	<label class="control-label">
		<g:message code="poll.end_time.label" default="Endtime" /> :

	</label>
	%{--<div class="controls span3" style="margin-left: 20px">--}%
		%{--<g:datePicker name="end_time" precision="day" relativeYears="[-2..10]" value="${pollInstance?.end_time}" default="none" noSelection="['': '']" />--}%



	%{--</div>--}%
	%{--<div class="controls">--}%
		%{--<div  data-date="12-02-2012" class="input-append date datepicker">--}%
			%{--<input type="text" name="end_time" value="${pollInstance.end_time}"  data-date-format="yyyy-mm-dd" class="span11" >--}%
			%{--<span class="add-on"><i class="icon-th"></i></span> </div>--}%
	%{--</div>--}%

	<div class="controls">
		<div  data-date="<g:formatDate date="${new java.util.Date()}" format="yyyy-MM-dd"/> " class="input-append date datepicker">
			<input type="text" name="end_time" date-format="yyyy-mm-dd" value="${pollInstance.end_time?new java.util.Date():pollInstance.end_time}" class="span11" >
			<span class="add-on"><i class="icon-th"></i></span> </div>
	</div>
</div>

<div class="control-group">
	<label class="control-label">
		<g:message code="poll.options.label" default="Options" />

	</label>
	<div class="controls">
		<g:textArea name="options" rows="5" required="" value="${pollInstance?.options}"/>
		每项请用"/"分隔,如:第一选项/第二选项/第三选项


	</div>
</div>




