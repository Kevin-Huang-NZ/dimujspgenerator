package nz.co.dimu.jspgenerator.service.model;

import com.google.common.base.CaseFormat;

public class GenerateMetaTable {
	private DimuBeanTable table;
	public GenerateMetaTable(DimuBeanTable table) {
		this.table = table;
	}

	public String getTableName() {
		return this.table.getTableName();
	}
	
	//pattern: colStaff
	public String getTableNo() {
		return this.table.getTableNo();
	}
	
	public String getTableNoWithoutCol() {
		return this.table.getTableNo().substring(3);
	}
	
	public String getTableNoLowerUnderscore() {
		return CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, getTableNoWithoutCol());
	}
	
	public String getFileNameApiXmlFun() {
		return getTableNoLowerUnderscore() + "_xml_fun";
	}
	
	public String getFileNameApiXml() {
		return getTableNoLowerUnderscore() + "_xml";
	}
	
	public String getFileNameApiDetailXml() {
		return getTableNoLowerUnderscore() + "_detail_xml";
	}
	
	public String getFileNameList() {
		return "ls_" +  getTableNoLowerUnderscore();
	}
	
	public String getFileNameDetail() {
		return "detail_" +  getTableNoLowerUnderscore();
	}
	
	public String getFileNamePop() {
		return "pop_" +  getTableNoLowerUnderscore() + "_edit";
	}
	
	public String getFileNameAjaxSave() {
		return "erp_" +  getTableNoLowerUnderscore() + "_save";
	}
	
	public String getFileNameAjaxSaveFun() {
		return "erp_" +  getTableNoLowerUnderscore() + "_save_fun";
	}
	
	public String getFileNameAjaxDelete() {
		return "erp_" +  getTableNoLowerUnderscore() + "_delete";
	}
	
	public String getFileNameFun() {
		return "fun_" +  getTableNoLowerUnderscore();
	}
	
	public String getFileNameFunSave() {
		return "fun_" +  getTableNoLowerUnderscore() + "_save";
	}

	public String getBeanName() {
		return CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_CAMEL, this.table.getTableNo().substring(3));
	}

	public String getSearchResultName() {
		return "rs" + this.table.getTableNo().substring(3);
	}
	
}
