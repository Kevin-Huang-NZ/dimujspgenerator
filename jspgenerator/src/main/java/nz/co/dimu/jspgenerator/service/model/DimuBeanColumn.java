package nz.co.dimu.jspgenerator.service.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties({ "pattern", "maxVal", "minVal", "canRetrieve", "memoVal", "funGen" })
public class DimuBeanColumn {
	private String caption;
	private String name;
	//0-文本；1-字典；5-图片；6-大文本
	private String type;
	private String defaultVal;
	private String refClassName;
	public String getCaption() {
		return caption;
	}
	public void setCaption(String caption) {
		this.caption = caption;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRefClassName() {
		return refClassName;
	}
	public void setRefClassName(String refClassName) {
		this.refClassName = refClassName;
	}
	public String getDefaultVal() {
		return defaultVal;
	}
	public void setDefaultVal(String defaultVal) {
		this.defaultVal = defaultVal;
	}
	
	
}
