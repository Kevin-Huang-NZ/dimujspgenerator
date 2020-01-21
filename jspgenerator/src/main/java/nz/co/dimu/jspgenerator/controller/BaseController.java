package nz.co.dimu.jspgenerator.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import nz.co.dimu.jspgenerator.response.CommonReturnType;
import nz.co.dimu.jspgenerator.response.error.BusinessException;
import nz.co.dimu.jspgenerator.response.error.EmBusinessError;

public class BaseController {
	final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public static final String CONTENT_TYPE_FORMED="application/x-www-form-urlencoded";
	
	public static final String CONTENT_TYPE_JSON="application/JSON";
	
	@ExceptionHandler(Exception.class)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public Object handleException(HttpServletRequest request, Exception ex) {
		Map<String, Object> responseData = new HashMap<String, Object>();
		if (ex instanceof BusinessException) {
			BusinessException bex = (BusinessException) ex;
			responseData.put("errCode", bex.getErrCode());
			responseData.put("errMsg", bex.getErrMsg());
		} else {
			logger.error(EmBusinessError.UNKNOWN_ERROR.getErrCode() + ":" + EmBusinessError.UNKNOWN_ERROR.getErrMsg(), ex);
			responseData.put("errCode", EmBusinessError.UNKNOWN_ERROR.getErrCode());
			responseData.put("errMsg", EmBusinessError.UNKNOWN_ERROR.getErrMsg());
		}
		return CommonReturnType.create(responseData, "fail");
	}

}
