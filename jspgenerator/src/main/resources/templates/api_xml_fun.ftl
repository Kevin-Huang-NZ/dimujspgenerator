<!--#<JREMOVE>
	检索[=tableName]列表。
	参数：
	pageNo：可选，默认1
	pageSize：可选，默认999999
</JREMOVE>#-->
<%@ page trimDirectiveWhitespaces="true" buffer="128kb" autoFlush="true" language="Java" pageEncoding="UTF-8" %>
<!--#<JREMOVE>
<MACRO>
	Jsp.includejsp("/[=projectName]_jsp/[=projectName]_const_html/global_const_define.jsp");
</MACRO>
</JREMOVE>#-->
<east:service beanName="eastUtilService" methodName="setValue" id="_pageNo">
	<east:para name="_value" value="${requestEx.pageNo}" type="Object" />
	<east:para name="_defaultValue" value="1" type="Object" />
</east:service>
<east:service beanName="eastUtilService" methodName="setValue" id="_pageSize">
	<east:para name="_value" value="${requestEx.pageSize}" type="Object" />
	<east:para name="_defaultValue" value="999999" type="Object" />
</east:service>

<MACRO>
	Jsp.call("/[=projectName]_jsp/[=projectName]_funs_html/[=funFileName].jsp","${_pageNo}","${_pageSize}","");
	Jsp.result("_rsResult","_rsPagination");
</MACRO>
	
<c:forEach items="${_rsPagination}" var="_one" varStatus="_status">
	<east:service beanName="eastUtilService" methodName="setValue" id="totalRecords">
		<east:para name="_value" value="${_one.totalRecords}" type="Object" />
	</east:service> 
	<east:service beanName="eastUtilService" methodName="setValue" id="totalPages">
		<east:para name="_value" value="${_one.totalPages}" type="Object" />
	</east:service> 
	<s:if test="${(_pageNo + 1) le totalPages}">
		<east:service beanName="eastUtilService" methodName="setValue" id="hasMore">
			<east:para name="_value" value="1" type="Object" />
		</east:service>
	</s:if>
	<s:else>
		<east:service beanName="eastUtilService" methodName="setValue" id="hasMore">
			<east:para name="_value" value="0" type="Object" />
		</east:service>
	</s:else>
</c:forEach>

<?xml version="1.0" encoding="UTF-8"?>
<items xmlns="http://foo.com">
	<state>success</state>
	<error_code>0</error_code>
	<data_size>${fn:length(_rsResult)}</data_size>
	<page_count>${totalPages}</page_count>
	<total_records>${totalRecords}</total_records>
	<has_more>${hasMore}</has_more>
	<c:forEach items="${_rsResult}" var="_one" varStatus="_status">
		<item>
			<id><![CDATA[${_one.id}]]></id>
			<#list columns as column>
			<[=column.columnName]><![CDATA[${_one.[=column.columnName]}]]></[=column.columnName]>
			</#list>
		</item>
	</c:forEach>
</items>