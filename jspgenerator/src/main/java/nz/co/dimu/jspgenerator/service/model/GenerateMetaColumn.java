package nz.co.dimu.jspgenerator.service.model;

public class GenerateMetaColumn {
	private DimuBeanColumn column;
	public GenerateMetaColumn(DimuBeanColumn column) {
		this.column = column;
	}
	
	public String getCaption() {
		return this.column.getCaption();
	}

	public String getName() {
		return this.column.getName();
	}

	public String getType() {
		return this.column.getType();
	}

	public String getRefClassName() {
		return this.column.getRefClassName();
	}

	public String getDefaultVal() {
		return this.column.getDefaultVal();
	}

}
