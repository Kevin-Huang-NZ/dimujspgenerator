<!--#<JREMOVE>
	保存[=tableName]。
</JREMOVE>#-->
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


<MACRO>
	Jsp.call("/[=projectName]_jsp/[=projectName]_funs_html/[=funSaveFileName].jsp","${requestEx.id}"<#list columns as column>,"${requestEx.[=column.columnName]}"</#list>);
	Jsp.result("hasError","msg","_[=beanName]");
</MACRO>

	
<s:if test="${hasError eq '0'}">
	{"state":"success"}
</s:if>
<s:else>
	{"state":"failure", "msg":"${msg}"}
</s:else>