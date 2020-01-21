<!--#<JREMOVE>
	删除[=tableName]。
</JREMOVE>#-->
<%@ page trimDirectiveWhitespaces="true" buffer="128kb" autoFlush="true" language="Java" pageEncoding="UTF-8" %>
<MACRO>
	Jsp.includejsp("/[=projectName]_jsp/[=projectName]_const_html/global_const_define.jsp");
	Jsp.includejsp("/[=projectName]_jsp/[=projectName]_modules_html/erp_login_staff_info.jsp");
	Jsp.result("_loginStaff","_roleFuncMap");
</MACRO>
<s:if test="${_loginStaff eq null || _loginStaff.ext.cstaffNo eq null || _loginStaff.ext.cstaffNo eq ''}">
	{"state":"failed", "error_code":"${API_ERROR_CODE_SESSION_TIMEOUT}"}
</s:if>
<s:else>
	<!--#<JREMOVE>session没有超时，执行业务代码</JREMOVE>#-->
	<east:service beanName="eastUtilService" methodName="setValue" id="hasError">
		<east:para name="_value" value="0" type="Object" />
	</east:service>
	<east:service beanName="eastUtilService" methodName="setValue" id="msg">
		<east:para name="_value" value="" type="Object" />
	</east:service>
	
	
	<s:if test="${hasError eq '0'}">
		<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="createBeanExByClassName" id="[=tableNo]">
			<east:para name="className" value="[=tableNo]" type="String" />
		</east:service>
		<east:service beanName="eastUtilService" methodName="setValue" id="tn[=tableNoWithoutCol]">
			<east:para name="_tableName" value="${[=tableNo].externTable}" type="Object" />
			<east:para name="_default" value="t_news" type="Object" />
		</east:service>
		<east:service beanName="pmsService" methodName="nativeSqlExc" id="_result">
			<east:para name="nativeSql" value="DELETE FROM ${tn[=tableNoWithoutCol]} 
				WHERE id = ${requestEx.id}" type="String" />
			<east:para name="token" value="123qweasd" type="String" />
		</east:service>
	
		<east:service beanName="pmsService" methodName="nativeSqlExc" id="idFileRecords">
			<east:para name="nativeSql" value="DELETE FROM t_files 
					WHERE table_name='[=tableNo]' AND table_id = ${requestEx.id}" 
				type="String" />
			<east:para name="token" value="123qweasd" type="String" />
		</east:service>	 
	</s:if>
		
	<s:if test="${hasError eq '0'}">
		{"state":"success"}
	</s:if>
	<s:else>
		{"state":"failed", "error_code":"${API_ERROR_CODE_BUSINESS}", "msg":"${msg}"}
	</s:else>
</s:else>