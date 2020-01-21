<!--#<JREMOVE>#--> 
FUN:Confused
	检索[=tableName]
<!--#</JREMOVE>#-->
<MACRO>
	Jsp.pops("__pageNo","__pageSize","__keyWord");
</MACRO>

<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="createBeanExByClassName" id="[=tableNo]">
	<east:para name="className" value="[=tableNo]" type="String" />
</east:service>
<east:service beanName="eastUtilService" methodName="setValue" id="tn[=tableNoWithoutCol]">
	<east:para name="_tableName" value="${[=tableNo].externTable}" type="Object" />
	<east:para name="_default" value="t_news" type="Object" />
</east:service>

<s:if test="${__keyWord ne null && __keyWord ne ''}">
	<east:service beanName="eastUtilService" methodName="replaceStr" id="__keyWord">
		<east:para name="_sVal" value="${__keyWord}" type="String" />
		<east:para name="_sReplaced" value="%" type="String" />
		<east:para name="_sReplaceNew" value="\%" type="String" />
	</east:service>
	<east:service beanName="eastUtilService" methodName="replaceStr" id="__keyWord">
		<east:para name="_sVal" value="${__keyWord}" type="String" />
		<east:para name="_sReplaced" value="." type="String" />
		<east:para name="_sReplaceNew" value="\." type="String" />
	</east:service>
	<east:service beanName="eastUtilService" methodName="setValue" id="__whereKeyWord">
		<east:para name="_val" value="AND (t1.${[=tableNo].extKeepName.[=firstColumnName]} LIKE '%${__keyWord}%'
			OR t1.${[=tableNo].extKeepName.[=secondColumnName]} LIKE '%${__keyWord}%')" type="Object" />
	</east:service>
</s:if>

<!--#<JREMOVE>
<s:if test="${__startDate ne null && __startDate ne ''}">
	<east:service beanName="eastUtilService" methodName="setValue" id="__whereStartDate">
		<east:para name="_val" value="AND t1.${[=tableNo].extKeepName.capplyDate} >= '${__startDate}'" type="Object" />
	</east:service>
</s:if>

<s:if test="${__endDate ne null && __endDate ne ''}">
	<east:service beanName="eastUtilService" methodName="setValue" id="__whereEndDate">
		<east:para name="_val" value="AND t1.${[=tableNo].extKeepName.capplyDate} <= '${__endDate}'" type="Object" />
	</east:service>
</s:if>

<s:if test="${__cstatus ne null && __cstatus ne ''}">
	<east:service beanName="eastUtilService" methodName="setValue" id="__whereStatus">
		<east:para name="_val" value="AND t1.${[=tableNo].extKeepName.cstatus} = '${__cstatus}'" type="Object" />
	</east:service>
</s:if>
</JREMOVE>#-->


<east:service beanName="eastUtilService" methodName="setValue" id="__fromIndex">
	<east:para name="_val" value="${__pageSize * (__pageNo - 1)}" type="Object" />
</east:service>

<east:service beanName="pmsService" methodName="nativeQuerySqlMap" id="__rsResult">
	<east:para name="nativeSql" value="SELECT t1.id AS id
<#list columns as column>
			,t1.${[=tableNo].extKeepName.[=column.columnName]} AS [=column.columnName]
</#list>
		FROM ${tn[=tableNoWithoutCol]} t1
		WHERE t1.${[=tableNo].keepName.newsClass} = '[=tableNo]'
			AND t1.column_id=1603
			${__whereKeyWord}
		ORDER BY t1.id DESC
		LIMIT ${__fromIndex},${__pageSize}
		"
		type="String" />
	<east:para name="_out_nodes_name" value="id<#list columns as column>,[=column.columnName]</#list>" type="String" />
	<east:para name="token" value="123qweasd" type="String" />
</east:service>

<east:service beanName="pmsService" methodName="nativeQuerySqlMap" id="__rsPagination">
	<east:para name="nativeSql" value="SELECT count('1') AS totalRecords
			, CEIL(count('1')/${__pageSize}) AS totalPages
		FROM (
			SELECT t1.id
			FROM ${tn[=tableNoWithoutCol]} t1
			WHERE t1.${[=tableNo].keepName.newsClass} = '[=tableNo]'
				AND t1.column_id=1603
				${__whereKeyWord}
		) pv
		"
		type="String" />
	<east:para name="_out_nodes_name" value="totalRecords,totalPages" type="String" />
	<east:para name="token" value="123qweasd" type="String" />
</east:service>

<MACRO>
	Jsp.pushs("${__rsResult}","${__rsPagination}");
</MACRO>