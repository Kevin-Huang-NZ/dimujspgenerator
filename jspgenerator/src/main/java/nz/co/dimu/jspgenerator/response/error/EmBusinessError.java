package nz.co.dimu.jspgenerator.response.error;

public enum EmBusinessError implements CommonError {

	// ps:通用错误9开头
	PARAMETER_VALIDATION_ERROR(900000, "参数不合法"),
	DATA_NOT_EXIST(900001, "数据不存在"),
	DATA_TYPE_CAST_ERROR(900002, "业务数据模型转换错误"),
	UNKNOWN_ERROR(999999, "未知错误")
	;
	private EmBusinessError(int errCode, String errMsg) {
		this.errCode = errCode;
		this.errMsg = errMsg;
	};
	private int errCode;
	private String errMsg;
	@Override
	public int getErrCode() {
		return this.errCode;
	}

	@Override
	public String getErrMsg() {
		return this.errMsg;
	}

	@Override
	public CommonError setErrMsg(String errMsg) {
		this.errMsg = errMsg;
		return this;
	}

}
