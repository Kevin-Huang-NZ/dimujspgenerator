<!--#<JREMOVE>
FUN:Confused
	保存[=tableName]。
</JREMOVE>#-->
<MACRO>
	Jsp.pops("__id"<#list columns as column>,"__[=column.columnName]"</#list>);
</MACRO>

<east:service beanName="eastUtilService" methodName="setValue" id="__hasError">
	<east:para name="_value" value="0" type="Object" />
</east:service>
<east:service beanName="eastUtilService" methodName="setValue" id="__msg">
	<east:para name="_value" value="" type="Object" />
</east:service>

<!--#<JREMOVE>
<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="getAllByNativeField" id="__rsCheckDuplicate">
	<east:para name="newsClass" value="[=tableNo]" type="String" />
	<east:para name="page" value="1" type="Integer" />
	<east:para name="pageSize" value="1" type="Integer" />
	<east:para name="searchTVL" value="{\"tag\":\"cfilmNo\",\"val\":\"${__cfilmNo}\",\"link\":\"!{EQ}\",\"type\":\"1\"}
		,{\"tag\":\"id\",\"val\":\"${__id}\",\"link\":\"!{NE}\",\"type\":\"1\"}" type="String" />
	<east:para name="orderName" value="cdate" type="String" />
	<east:para name="descOrAsc" value="true" type="Boolean" />
</east:service>

<s:if test="${__rsCheckDuplicate.list ne null && fn:length(__rsCheckDuplicate.list) gt 0}">
	<east:service beanName="eastUtilService" methodName="setValue" id="__hasError">
		<east:para name="_value" value="1" type="Object" />
	</east:service>
	<east:service beanName="eastUtilService" methodName="setValue" id="__msg">
		<east:para name="_value" value="该电影已经发行通证,保存失败。" type="Object" />
	</east:service>
</s:if>
</JREMOVE>#-->

<s:if test="${__hasError eq '0'}">
	<s:if test="${__id eq '0'}">
		<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="createBeanExByClassName" id="__[=beanName]">
			<east:para name="className" value="[=tableNo]" type="String" />
		</east:service>
		<!--#<JREMOVE>
		<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="getDefaultPattern" id="__generatedNo">
			<east:para name="patternStr" value="{seq('TN%09d')}" type="String" />
		</east:service>
		<east:service beanName="eastUtilService" methodName="getNowDate" id="__nowDate">
		</east:service>
		<east:service beanName="eastUtilService" methodName="getDateTime" id="__nowDateTime">
		</east:service>
		</JREMOVE>#-->
	</s:if>
	<s:else>
		<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="getOneByIdAlwaysWithClass" id="__[=beanName]">
			<east:para name="tnewsid" value="${__id}" type="String" />
			<east:para name="className" value="[=tableNo]" type="String" />
		</east:service>
	</s:else>
	<MACRO>
		<#list columns as column>
		Jsp.call("/bspms_jsp/bspms_funs_html/ajax_set_field1_fun.jsp","${__[=beanName]}","[=column.columnName]","${__[=column.columnName]}");
		</#list>
		
		Jsp.call("/bspms_jsp/bspms_funs_html/ajax_save_bean_fun.jsp" ,"${__[=beanName]}");
	</MACRO>
</s:if>
	
<MACRO>
	Jsp.pushs("${__hasError}","${__msg}","${__[=beanName]}");
</MACRO>