<!--#<JREMOVE>
	检索[=tableName]列表。
	参数：
	pageNo：可选，默认1
	pageSize：可选，默认999999
	orderBy: 可选, 默认id降序
	extIsNumber: orderBy设置时，必须设置。含有：排序字段是否是数字。
	ascDesc: orderBy设置时，必须设置。可选值：asc/desc
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


<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="createBeanExByClassName" id="[=tableNo]">
	<east:para name="className" value="[=tableNo]" type="String" />
</east:service>
<east:service beanName="eastUtilService" methodName="setValue" id="tn[=tableNoWithoutCol]">
	<east:para name="_tableName" value="${[=tableNo].externTable}" type="Object" />
	<east:para name="_default" value="t_news" type="Object" />
</east:service>

<s:if test="${requestEx.keyWord ne null && requestEx.keyWord ne ''}">
	<east:service beanName="eastUtilService" methodName="replaceStr" id="_keyWord">
		<east:para name="_sVal" value="${requestEx.keyWord}" type="String" />
		<east:para name="_sReplaced" value="%" type="String" />
		<east:para name="_sReplaceNew" value="\%" type="String" />
	</east:service>
	<east:service beanName="eastUtilService" methodName="replaceStr" id="_keyWord">
		<east:para name="_sVal" value="${_keyWord}" type="String" />
		<east:para name="_sReplaced" value="." type="String" />
		<east:para name="_sReplaceNew" value="\." type="String" />
	</east:service>
	<east:service beanName="eastUtilService" methodName="setValue" id="_whereKeyWord">
		<east:para name="_val" value="AND (t1.${[=tableNo].extKeepName.[=firstColumnName]} LIKE '%${_keyWord}%'
			OR t1.${[=tableNo].extKeepName.[=secondColumnName]} LIKE '%${_keyWord}%')" type="Object" />
	</east:service>
</s:if>

<!--#<JREMOVE>
<s:if test="${requestEx.startDate ne null && requestEx.startDate ne ''}">
	<east:service beanName="eastUtilService" methodName="setValue" id="_whereStartDate">
		<east:para name="_val" value="AND t1.${[=tableNo].extKeepName.capplyDate} >= '${requestEx.startDate}'" type="Object" />
	</east:service>
</s:if>

<s:if test="${requestEx.endDate ne null && requestEx.endDate ne ''}">
	<east:service beanName="eastUtilService" methodName="setValue" id="_whereEndDate">
		<east:para name="_val" value="AND t1.${[=tableNo].extKeepName.capplyDate} <= '${requestEx.endDate}'" type="Object" />
	</east:service>
</s:if>

<s:if test="${requestEx.cstatus ne null && requestEx.cstatus ne ''}">
	<east:service beanName="eastUtilService" methodName="setValue" id="_whereStatus">
		<east:para name="_val" value="AND t1.${[=tableNo].extKeepName.cstatus} = '${requestEx.cstatus}'" type="Object" />
	</east:service>
</s:if>
</JREMOVE>#-->


<east:service beanName="eastUtilService" methodName="setValue" id="_fromIndex">
	<east:para name="_val" value="${_pageSize * (_pageNo - 1)}" type="Object" />
</east:service>

<east:service beanName="pmsService" methodName="nativeQuerySqlMap" id="_rsResult">
	<east:para name="nativeSql" value="SELECT t1.id AS id
<#list columns as column>
			,t1.${[=tableNo].extKeepName.[=column.columnName]} AS [=column.columnName]
</#list>
		FROM ${tn[=tableNoWithoutCol]} t1
		WHERE t1.${[=tableNo].keepName.newsClass} = '[=tableNo]'
			AND t1.column_id=1603
			${_whereKeyWord}
		ORDER BY t1.id DESC
		LIMIT ${_fromIndex},${_pageSize}
		"
		type="String" />
	<east:para name="_out_nodes_name" value="id<#list columns as column>,[=column.columnName]</#list>" type="String" />
	<east:para name="token" value="123qweasd" type="String" />
</east:service>

<east:service beanName="pmsService" methodName="nativeQuerySqlMap" id="_rsPagination">
	<east:para name="nativeSql" value="SELECT count('1') AS totalRecords
			, CEIL(count('1')/${_pageSize}) AS totalPages
		FROM (
			SELECT t1.id
			FROM ${tn[=tableNoWithoutCol]} t1
			WHERE t1.${[=tableNo].keepName.newsClass} = '[=tableNo]'
				AND t1.column_id=1603
				${_whereKeyWord}
		) pv
		"
		type="String" />
	<east:para name="_out_nodes_name" value="totalRecords,totalPages" type="String" />
	<east:para name="token" value="123qweasd" type="String" />
</east:service>
	
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