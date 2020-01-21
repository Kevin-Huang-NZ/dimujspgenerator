package nz.co.dimu.jspgenerator.response.error;

public interface CommonError {
	public int getErrCode();
	public String getErrMsg();
	public CommonError setErrMsg(String errMsg);
}
