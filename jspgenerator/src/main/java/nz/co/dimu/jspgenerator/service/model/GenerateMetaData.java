package nz.co.dimu.jspgenerator.service.model;

import java.util.List;

public class GenerateMetaData {
	private String projectName;
	private GenerateMetaTable table;
	private List<GenerateMetaColumn> colums;
	
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public GenerateMetaTable getTable() {
		return table;
	}
	public void setTable(GenerateMetaTable table) {
		this.table = table;
	}
	public List<GenerateMetaColumn> getColums() {
		return colums;
	}
	public void setColums(List<GenerateMetaColumn> colums) {
		this.colums = colums;
	}
	
	
	
}
