<!--#<JREMOVE>
[=tableName]详情。
参数：
	id
</JREMOVE>#-->
<%@ page trimDirectiveWhitespaces="true" buffer="128kb" autoFlush="true" language="Java" pageEncoding="UTF-8" %>
<!--#<JREMOVE>
<MACRO>
	Jsp.includejsp("/[=projectName]_jsp/[=projectName]_const_html/global_const_define.jsp");
</MACRO>
</JREMOVE>#-->
<east:service beanName="eastUtilService" methodName="setValue" id="_hasData">
	<east:para name="_value" value="0" type="Object" />
</east:service>

<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="getOneByIdAlwaysWithClass" id="_[=beanName]">
	<east:para name="tnewsid" value="${requestEx.id}" type="String" />
	<east:para name="className" value="[=tableNo]" type="String" />
</east:service>
<!--#<JREMOVE>
<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="getBeanOneByClassNameExtColumn" id="_[=beanName]">
	<east:para name="className" value="[=tableNo]" type="String" />
	<east:para name="fieldName" value="c[=beanName]No" type="String" />
	<east:para name="fieldValue" value="${requestEx.c[=beanName]No}" type="String" />
</east:service>
</JREMOVE>#-->

<s:if test="${_[=beanName] ne null && _[=beanName].id ne null && _[=beanName].id ne ''}">
	<east:service beanName="eastUtilService" methodName="setValue" id="_hasData">
		<east:para name="_value" value="1" type="Object" />
	</east:service>
</s:if>
	
<s:if test="${_hasData eq '1'}">
	<?xml version="1.0" encoding="UTF-8"?>
	<items xmlns="http://foo.com">
		<state>success</state>
		<error_code>0</error_code>
		<data_size>1</data_size>
		<item>
			<id><![CDATA[${_[=beanName].id}]]></id>
			<#list columns as column>
			<[=column.columnName]><![CDATA[${_[=beanName].ext.[=column.columnName]}]]></[=column.columnName]>
			</#list>
		</item>
	</items>
</s:if>
<s:else>
	<?xml version="1.0" encoding="UTF-8"?>
	<items xmlns="http://foo.com">
		<state>success</state>
		<error_code>0</error_code>
		<data_size>0</data_size>
	</items>
</s:else>