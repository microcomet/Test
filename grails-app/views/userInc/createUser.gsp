<%@ page import="user.UserInfo" %>

<g:set var="ui" value="${(UserInfo)session.getAttribute("user")}"/>

<script>
    var streetArray = new Array();
    var communityArray = new Array();

    <g:each in="${streetList}" var="street">
    streetArray[streetArray.length] = new Array("${street.id}","${street.name}");
        <g:each in="${smartcommunity.Community.findAllByStreet(street)}" var="community">
    communityArray[communityArray.length] = new Array("${street.id}","${community.id}","${community.name}")
        </g:each>
    </g:each>



    function setTitle(obj1ID,obj2ID){
        <g:if test="${params.roleLv!='8'}">
        var objCate = document.getElementById(obj1ID);
        var objTitle = document.getElementById(obj2ID);
        var i;
        var itemArray = null;
        if(objCate.value.length > 0){
            itemArray = new Array();
            for(i=0;i<communityArray.length;i++){
                if(communityArray[i][0]==objCate.value){
                    itemArray[itemArray.length]=new Array(communityArray[i][1],communityArray[i][2]);
                }
            }
        }
//        alert(itemArray);
        for(i = objTitle.options.length ; i >= 0 ; i--){
            objTitle.options[i] = null;
        }
//        objTitle.options[0] = new Option("请选择社区");
//        objTitle.options[0].value = "";
        if(itemArray != null){
//            alert(itemArray.length)
            for(i = 0 ; i < itemArray.length; i++){
//                alert(itemArray[i][1])
                objTitle.options[i] = new Option(itemArray[i][1]);
                if(itemArray[i][0] != null){
                    objTitle.options[i].value = itemArray[i][0];
                }
            }
        }
        </g:if>

    }




</script>

<g:if test="${params.search == 1}">

    <g:select style="width:120px;" onchange="setTitle('street','community')" id="street" name="streetId" from="${streetList}" optionKey="id" optionValue="name" value="${params.streetId?params.streetId:userInstance?.street?.id}" class="many-to-one" noSelection="${[' ':'选择街道']}"/>
    <g:if test="${params.c_show=='y'}">
        <g:select style="width:120px;" id="community" name="communityId" from="${communityList}" optionKey="id" optionValue="name" value="${userInstance?.community?.id?userInstance?.community?.id:((user.UserInfo)session.getAttribute("user")).community_id}" class="many-to-one" noSelection="${['null':'选择社区']}"/>

    </g:if>

</g:if>
<g:else>

%{--街道--}%
%{--${params.streetId} / ${params.communityId}--}%
    <g:if test="${streetList!=null}">

    <div class="control-group">
        <label class="control-label">
            <g:message code="user.street.label" default="street" />

        </label>
        <div class="controls">
            <g:select  onchange="setTitle('street','community')" id="street" name="street.id" from="${streetList}" optionKey="id" optionValue="name" value="${params.streetId?params.streetId:userInstance?.street?.id}" class="many-to-one" noSelection="${[' ':'选择街道']}"/>

        </div>
    </div>
    </g:if>



%{--社区--}%
    <div class="control-group" style="display: <g:if test="${params.roleLv=='8'}">none</g:if>;">
        <label class="control-label">
            <g:message code="user.community.label" default="Community" />

        </label>
        <div class="controls">

            <g:select id="community" name="community.id" from="${communityList}" optionKey="id" optionValue="name" value="${userInstance?.community?.id?userInstance?.community?.id:((user.UserInfo)session.getAttribute("user")).community_id}" class="many-to-one" noSelection="${['null':'选择社区']}"/>

        </div>
    </div>

</g:else>




<script>
    <g:if test="${params.streetId!=null}">
    setTitle('street','community');
    </g:if>
</script>