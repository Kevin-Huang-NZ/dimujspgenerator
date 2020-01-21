<!--#<JREMOVE>
	保存[=tableName]。
</JREMOVE>#-->
<%@ page trimDirectiveWhitespaces="true" buffer="128kb" autoFlush="true" language="Java" pageEncoding="UTF-8" %>
<!--#<JREMOVE>
<MACRO>
	Jsp.includejsp("/[=projectName]_jsp/[=projectName]_const_html/global_const_define.jsp");
</MACRO>
</JREMOVE>#-->
<east:service beanName="eastUtilService" methodName="setValue" id="hasError">
	<east:para name="_value" value="0" type="Object" />
</east:service>
<east:service beanName="eastUtilService" methodName="setValue" id="msg">
	<east:para name="_value" value="" type="Object" />
</east:service>

<!--#<JREMOVE>
<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="getAllByNativeField" id="_rsCheckDuplicate">
	<east:para name="newsClass" value="[=tableNo]" type="String" />
	<east:para name="page" value="1" type="Integer" />
	<east:para name="pageSize" value="1" type="Integer" />
	<east:para name="searchTVL" value="{\"tag\":\"cfilmNo\",\"val\":\"${requestEx.cfilmNo}\",\"link\":\"!{EQ}\",\"type\":\"1\"}
		,{\"tag\":\"id\",\"val\":\"${requestEx.id}\",\"link\":\"!{NE}\",\"type\":\"1\"}" type="String" />
	<east:para name="orderName" value="cdate" type="String" />
	<east:para name="descOrAsc" value="true" type="Boolean" />
</east:service>

<s:if test="${_rsCheckDuplicate.list ne null && fn:length(_rsCheckDuplicate.list) gt 0}">
	<east:service beanName="eastUtilService" methodName="setValue" id="hasError">
		<east:para name="_value" value="1" type="Object" />
	</east:service>
	<east:service beanName="eastUtilService" methodName="setValue" id="msg">
		<east:para name="_value" value="该电影已经发行通证,保存失败。" type="Object" />
	</east:service>
</s:if>
</JREMOVE>#-->

<s:if test="${hasError eq '0'}">
	<s:if test="${requestEx.id eq '0'}">
		<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="createBeanExByClassName" id="_[=beanName]">
			<east:para name="className" value="[=tableNo]" type="String" />
		</east:service>
		<!--#<JREMOVE>
		<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="getDefaultPattern" id="_generatedNo">
			<east:para name="patternStr" value="{seq('TN%09d')}" type="String" />
		</east:service>
		<east:service beanName="eastUtilService" methodName="getNowDate" id="_nowDate">
		</east:service>
		<east:service beanName="eastUtilService" methodName="getDateTime" id="_nowDateTime">
		</east:service>
		</JREMOVE>#-->
	</s:if>
	<s:else>
		<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="getOneByIdAlwaysWithClass" id="_[=beanName]">
			<east:para name="tnewsid" value="${requestEx.id}" type="String" />
			<east:para name="className" value="[=tableNo]" type="String" />
		</east:service>
	</s:else>
	<MACRO>
		<#list columns as column>
		Jsp.call("/bspms_jsp/bspms_funs_html/ajax_set_field1_fun.jsp","${_[=beanName]}","[=column.columnName]","${requestEx.[=column.columnName]}");
		</#list>
		
		Jsp.call("/bspms_jsp/bspms_funs_html/ajax_save_bean_fun.jsp" ,"${_[=beanName]}");
	</MACRO>
</s:if>
	
<s:if test="${hasError eq '0'}">
	{"state":"success"}
</s:if>
<s:else>
	{"state":"failed", "msg":"${msg}"}
</s:else>