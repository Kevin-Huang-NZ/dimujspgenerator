package nz.co.dimu.jspgenerator.service.impl;


import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.druid.util.StringUtils;
import com.google.common.base.CaseFormat;

import freemarker.template.Configuration;
import freemarker.template.Template;
import nz.co.dimu.jspgenerator.utils.MakeDir;
import nz.co.dimu.jspgenerator.service.model.DimuBeanColumn;
import nz.co.dimu.jspgenerator.service.model.DimuBeanTable;
import nz.co.dimu.jspgenerator.service.model.GenerateMetaColumn;
import nz.co.dimu.jspgenerator.service.model.GenerateMetaData;
import nz.co.dimu.jspgenerator.service.model.GenerateMetaTable;
import nz.co.dimu.jspgenerator.controller.vo.DimuBeanTableVo;
import nz.co.dimu.jspgenerator.dao.DimuBeanDoMapper;
import nz.co.dimu.jspgenerator.response.error.BusinessException;
import nz.co.dimu.jspgenerator.response.error.EmBusinessError;
import nz.co.dimu.jspgenerator.service.GenerateService;

@Service("generateService")
@Transactional
public class GenerateServiceImpl implements GenerateService {
	Logger logger = LoggerFactory.getLogger(GenerateServiceImpl.class);

	@Autowired
	private Configuration freeMarkerCfg;

	@Value("${generate.output.folder}")
	private String outputFolder;


	@Override
	public void generate(String projectName, DimuBeanTable table, List<DimuBeanColumn> columns) {
		GenerateMetaData metaData = convertToMetaData(projectName, table, columns);
		
		if (metaData != null) {
//			generateFunFile(metaData);
//			generateControlsDeleteFile(metaData);

//			generateControlsSaveFileFun(metaData);
			generateControlsSaveFile(metaData);
			
			generateListFile(metaData);
			generatePopFile(metaData);

//			generateApiXmlFun(metaData);
			generateApiXml(metaData);
			generateApiDetailXml(metaData);
			
//			generateLs(metaData);
//			generatePop(metaData);
//			generateDetail(metaData);
//			generateAjaxSave(metaData);
//			generateAjaxUpdate(metaData);
//			generateAjaxDelete(metaData);
		}
	}
	
	private void generateFunFile(GenerateMetaData metaData) {
		OutputStreamWriter out = null;
		try {
			Template template = freeMarkerCfg.getTemplate("funs.ftl");

			//为模板准备数据
			Map<String, Object> root = new HashMap<String, Object>();
			List<Map<String, Object>> columns = new ArrayList<Map<String, Object>>();

			root.put("tableName", metaData.getTable().getTableName());
			root.put("tableNo", metaData.getTable().getTableNo());
			root.put("tableNoWithoutCol", metaData.getTable().getTableNoWithoutCol());
			// columns
			String firstColumnName = "";
			String secondColumnName = "";
			for (int i = 0; i < metaData.getColums().size(); i++) {
				GenerateMetaColumn column = metaData.getColums().get(i);
				if (i == 0) {
					firstColumnName = column.getName();
				} else if (i == 1) {
					secondColumnName = column.getName();
				}
				
				Map<String, Object> mapColumn = new HashMap<String, Object>();
				mapColumn.put("columnName", column.getName());
				
				columns.add(mapColumn);
			}
			root.put("firstColumnName", firstColumnName);
			root.put("secondColumnName", secondColumnName);
			root.put("columns", columns);
			//生成
			String packageDir = MakeDir.make(metaData.getProjectName()+"_funs_html", this.outputFolder);
			String fileName = packageDir + "/" + metaData.getTable().getFileNameFun() + ".html";
//			fw = new FileWriter(fileName, false);
			out = new OutputStreamWriter(new FileOutputStream(fileName), "UTF-8");
			template.process(root, out);
		} catch (Exception e) {
			logger.error("Failed to get template.", e);
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
				}
			}
		}
	}
	
	private void generateControlsSaveFileFun(GenerateMetaData metaData) {
		OutputStreamWriter out = null;
		try {
			Template template = freeMarkerCfg.getTemplate("controls_save_fun.ftl");
			Template templateFun = freeMarkerCfg.getTemplate("fun_save.ftl");

			//为模板准备数据
			Map<String, Object> root = new HashMap<String, Object>();
			List<Map<String, Object>> columns = new ArrayList<Map<String, Object>>();

			root.put("projectName", metaData.getProjectName());
			root.put("funSaveFileName", metaData.getTable().getFileNameFunSave());
			root.put("tableName", metaData.getTable().getTableName());
			root.put("tableNo", metaData.getTable().getTableNo());
			root.put("beanName", metaData.getTable().getBeanName());
			// columns
			for (int i = 0; i < metaData.getColums().size(); i++) {
				GenerateMetaColumn column = metaData.getColums().get(i);
				
				Map<String, Object> mapColumn = new HashMap<String, Object>();
				mapColumn.put("columnName", column.getName());
				
				columns.add(mapColumn);
			}
			root.put("columns", columns);
			//生成
			String packageDir = MakeDir.make(metaData.getProjectName()+"_controls_html", this.outputFolder);
			String fileName = packageDir + "/" + metaData.getTable().getFileNameAjaxSaveFun() + ".html";
//			fw = new FileWriter(fileName, false);
			out = new OutputStreamWriter(new FileOutputStream(fileName), "UTF-8");
			template.process(root, out);
			out.close();
			
			String packageDirSave = MakeDir.make(metaData.getProjectName()+"_funs_html", this.outputFolder);
			String fileNameSave = packageDirSave + "/" + metaData.getTable().getFileNameFunSave() + ".html";
//			fw = new FileWriter(fileName, false);
			out = new OutputStreamWriter(new FileOutputStream(fileNameSave), "UTF-8");
			templateFun.process(root, out);
		} catch (Exception e) {
			logger.error("Failed to get template.", e);
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
				}
			}
		}
	}
	
	private void generateControlsSaveFile(GenerateMetaData metaData) {
		OutputStreamWriter out = null;
		try {
			Template template = freeMarkerCfg.getTemplate("controls_save.ftl");

			//为模板准备数据
			Map<String, Object> root = new HashMap<String, Object>();
			List<Map<String, Object>> columns = new ArrayList<Map<String, Object>>();

			root.put("projectName", metaData.getProjectName());
			root.put("tableName", metaData.getTable().getTableName());
			root.put("tableNo", metaData.getTable().getTableNo());
			root.put("beanName", metaData.getTable().getBeanName());
			// columns
			for (int i = 0; i < metaData.getColums().size(); i++) {
				GenerateMetaColumn column = metaData.getColums().get(i);
				
				Map<String, Object> mapColumn = new HashMap<String, Object>();
				mapColumn.put("columnName", column.getName());
				
				columns.add(mapColumn);
			}
			root.put("columns", columns);
			//生成
			String packageDir = MakeDir.make(metaData.getProjectName()+"_controls_html", this.outputFolder);
			String fileName = packageDir + "/" + metaData.getTable().getFileNameAjaxSave() + ".html";
//			fw = new FileWriter(fileName, false);
			out = new OutputStreamWriter(new FileOutputStream(fileName), "UTF-8");
			template.process(root, out);
			out.close();
			
		} catch (Exception e) {
			logger.error("Failed to get template.", e);
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
				}
			}
		}
	}
	
//	private void generateControlsDeleteFile(GenerateMetaData metaData) {
//		OutputStreamWriter out = null;
//		try {
//			Template template = freeMarkerCfg.getTemplate("controls_delete.ftl");
//
//			//为模板准备数据
//			Map<String, Object> root = new HashMap<String, Object>();
//			List<Map<String, Object>> columns = new ArrayList<Map<String, Object>>();
//
//			root.put("tableName", metaData.getTable().getTableName());
//			root.put("tableNo", metaData.getTable().getTableNo());
//			root.put("tableNoWithoutCol", metaData.getTable().getTableNoWithoutCol());
//			
//			//生成
//			String packageDir = MakeDir.make(metaData.getProjectName()+"_controls_html", this.outputFolder);
//			String fileName = packageDir + "/" + metaData.getTable().getFileNameAjaxDelete() + ".html";
////			fw = new FileWriter(fileName, false);
//			out = new OutputStreamWriter(new FileOutputStream(fileName), "UTF-8");
//			template.process(root, out);
//		} catch (Exception e) {
//			logger.error("Failed to get template.", e);
//		} finally {
//			if (out != null) {
//				try {
//					out.close();
//				} catch (IOException e) {
//				}
//			}
//		}
//	}
	
	private void generateListFile(GenerateMetaData metaData) {
		OutputStreamWriter out = null;
		try {
			Template template = freeMarkerCfg.getTemplate("erp_ls.ftl");

			//为模板准备数据
			Map<String, Object> root = new HashMap<String, Object>();
			List<Map<String, Object>> columns = new ArrayList<Map<String, Object>>();

			root.put("projectName", metaData.getProjectName());
			root.put("tableName", metaData.getTable().getTableName());
			root.put("tableNo", metaData.getTable().getTableNo());
			root.put("listFileName", metaData.getTable().getFileNameList());
			root.put("funFileName", metaData.getTable().getFileNameFun());
			root.put("popFileName", metaData.getTable().getFileNamePop());
			root.put("searchResultName", metaData.getTable().getSearchResultName());
			root.put("tableNoWithoutCol", metaData.getTable().getTableNoWithoutCol());
			
			// columns
			String firstColumnName = "";
			String secondColumnName = "";
			for (int i = 0; i < metaData.getColums().size(); i++) {
				GenerateMetaColumn column = metaData.getColums().get(i);
				if (i == 0) {
					firstColumnName = column.getName();
				} else if (i == 1) {
					secondColumnName = column.getName();
				}
				
				Map<String, Object> mapColumn = new HashMap<String, Object>();
				mapColumn.put("columnCaption", column.getCaption());
				mapColumn.put("columnName", column.getName());
				mapColumn.put("type", column.getType());
				mapColumn.put("refClassName", column.getRefClassName());
				
				columns.add(mapColumn);
			}
			root.put("firstColumnName", firstColumnName);
			root.put("secondColumnName", secondColumnName);
			root.put("columns", columns);
			
			//生成
			String packageDir = MakeDir.make(metaData.getProjectName()+"_erp_html", this.outputFolder);
			String fileName = packageDir + "/" + metaData.getTable().getFileNameList() + ".html";
//			fw = new FileWriter(fileName, false);
			out = new OutputStreamWriter(new FileOutputStream(fileName), "UTF-8");
			template.process(root, out);
		} catch (Exception e) {
			logger.error("Failed to get template.", e);
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
				}
			}
		}
	}
	
	private void generateApiXmlFun(GenerateMetaData metaData) {
		OutputStreamWriter out = null;
		try {
			Template template = freeMarkerCfg.getTemplate("api_xml_fun.ftl");

			//为模板准备数据
			Map<String, Object> root = new HashMap<String, Object>();
			List<Map<String, Object>> columns = new ArrayList<Map<String, Object>>();

			root.put("projectName", metaData.getProjectName());
			root.put("tableName", metaData.getTable().getTableName());
			root.put("funFileName", metaData.getTable().getFileNameFun());
			
			// columns
			for (int i = 0; i < metaData.getColums().size(); i++) {
				GenerateMetaColumn column = metaData.getColums().get(i);
				
				Map<String, Object> mapColumn = new HashMap<String, Object>();
				mapColumn.put("columnCaption", column.getCaption());
				mapColumn.put("columnName", column.getName());
				mapColumn.put("type", column.getType());
				mapColumn.put("refClassName", column.getRefClassName());
				
				columns.add(mapColumn);
			}
			root.put("columns", columns);
			//生成
			String packageDir = MakeDir.make(metaData.getProjectName()+"_api_html", this.outputFolder);
			String fileName = packageDir + "/" + metaData.getTable().getFileNameApiXmlFun() + ".html";
//			fw = new FileWriter(fileName, false);
			out = new OutputStreamWriter(new FileOutputStream(fileName), "UTF-8");
			template.process(root, out);
		} catch (Exception e) {
			logger.error("Failed to get template.", e);
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
				}
			}
		}
	}
	
	private void generateApiXml(GenerateMetaData metaData) {
		OutputStreamWriter out = null;
		try {
			Template template = freeMarkerCfg.getTemplate("api_xml.ftl");

			//为模板准备数据
			Map<String, Object> root = new HashMap<String, Object>();
			List<Map<String, Object>> columns = new ArrayList<Map<String, Object>>();

			root.put("projectName", metaData.getProjectName());
			root.put("tableName", metaData.getTable().getTableName());
			root.put("tableNo", metaData.getTable().getTableNo());
			root.put("tableNoWithoutCol", metaData.getTable().getTableNoWithoutCol());
			
			// columns
			String firstColumnName = "";
			String secondColumnName = "";
			for (int i = 0; i < metaData.getColums().size(); i++) {
				GenerateMetaColumn column = metaData.getColums().get(i);
				if (i == 0) {
					firstColumnName = column.getName();
				} else if (i == 1) {
					secondColumnName = column.getName();
				}
				
				Map<String, Object> mapColumn = new HashMap<String, Object>();
				mapColumn.put("columnCaption", column.getCaption());
				mapColumn.put("columnName", column.getName());
				mapColumn.put("type", column.getType());
				mapColumn.put("refClassName", column.getRefClassName());
				
				columns.add(mapColumn);
			}
			root.put("firstColumnName", firstColumnName);
			root.put("secondColumnName", secondColumnName);
			root.put("columns", columns);
			
			//生成
			String packageDir = MakeDir.make(metaData.getProjectName()+"_api_html", this.outputFolder);
			String fileName = packageDir + "/" + metaData.getTable().getFileNameApiXml() + ".html";
//			fw = new FileWriter(fileName, false);
			out = new OutputStreamWriter(new FileOutputStream(fileName), "UTF-8");
			template.process(root, out);
		} catch (Exception e) {
			logger.error("Failed to get template.", e);
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
				}
			}
		}
	}
	
	private void generateApiDetailXml(GenerateMetaData metaData) {
		OutputStreamWriter out = null;
		try {
			Template template = freeMarkerCfg.getTemplate("api_detail_xml.ftl");

			//为模板准备数据
			Map<String, Object> root = new HashMap<String, Object>();
			List<Map<String, Object>> columns = new ArrayList<Map<String, Object>>();

			root.put("projectName", metaData.getProjectName());
			root.put("tableName", metaData.getTable().getTableName());
			root.put("beanName", metaData.getTable().getBeanName());
			root.put("tableNo", metaData.getTable().getTableNo());
			
			// columns
			for (int i = 0; i < metaData.getColums().size(); i++) {
				GenerateMetaColumn column = metaData.getColums().get(i);
				
				Map<String, Object> mapColumn = new HashMap<String, Object>();
				mapColumn.put("columnCaption", column.getCaption());
				mapColumn.put("columnName", column.getName());
				mapColumn.put("type", column.getType());
				mapColumn.put("refClassName", column.getRefClassName());
				
				columns.add(mapColumn);
			}
			root.put("columns", columns);
			//生成
			String packageDir = MakeDir.make(metaData.getProjectName()+"_api_html", this.outputFolder);
			String fileName = packageDir + "/" + metaData.getTable().getFileNameApiDetailXml() + ".html";
//			fw = new FileWriter(fileName, false);
			out = new OutputStreamWriter(new FileOutputStream(fileName), "UTF-8");
			template.process(root, out);
		} catch (Exception e) {
			logger.error("Failed to get template.", e);
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
				}
			}
		}
	}
	
	private void generatePopFile(GenerateMetaData metaData) {
		OutputStreamWriter out = null;
		try {
			Template template = freeMarkerCfg.getTemplate("erp_pop.ftl");

			//为模板准备数据
			Map<String, Object> root = new HashMap<String, Object>();
			List<Map<String, Object>> columns = new ArrayList<Map<String, Object>>();

			root.put("projectName", metaData.getProjectName());
			root.put("tableName", metaData.getTable().getTableName());
			root.put("tableNo", metaData.getTable().getTableNo());
			root.put("beanName", metaData.getTable().getBeanName());
			root.put("controlSaveFileName", metaData.getTable().getFileNameAjaxSave());
			
			// columns
			for (int i = 0; i < metaData.getColums().size(); i++) {
				GenerateMetaColumn column = metaData.getColums().get(i);
				
				Map<String, Object> mapColumn = new HashMap<String, Object>();
				mapColumn.put("columnCaption", column.getCaption());
				mapColumn.put("columnName", column.getName());
				mapColumn.put("type", column.getType());
				mapColumn.put("refClassName", column.getRefClassName());
				
				columns.add(mapColumn);
			}
			root.put("columns", columns);
			//生成
			String packageDir = MakeDir.make(metaData.getProjectName()+"_erp_html", this.outputFolder);
			String fileName = packageDir + "/" + metaData.getTable().getFileNamePop() + ".html";
//			fw = new FileWriter(fileName, false);
			out = new OutputStreamWriter(new FileOutputStream(fileName), "UTF-8");
			template.process(root, out);
		} catch (Exception e) {
			logger.error("Failed to get template.", e);
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
				}
			}
		}
	}
	
//	private void generateEntity(Tables tableEntity, Iterable<TableField> oneToManys) {
//		FileWriter fw = null;
//		try {
//			Template template = freeMarkerCfg.getTemplate("java/entity.java.ftl");
//
//			//数据变换
//			String packageName = this.basePackage + "." + this.entityPackage;
//			String className = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL, tableEntity.getTableName());
//			
//			//为模板准备数据
//			Map<String, Object> root = new HashMap<String, Object>();
//			List<String> importClasses = new ArrayList<String>();
//			List<Map<String, Object>> fields = new ArrayList<Map<String, Object>>();
//			
//			root.put("packageName", packageName);
//			root.put("className",className);
//			root.put("tableName", tableEntity.getTableName());
//			// fields
//			for (TableField field : tableEntity.getFields()) {
//				Map<String, Object> mapField = new HashMap<String, Object>();
//				String fieldCamelName = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.LOWER_CAMEL, field.getFieldName());
//				String fieldUpperCamelName = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL, field.getFieldName());
//				String refFieldCamelName = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.LOWER_CAMEL, field.getRefFieldName());
//				String fieldClassName = "String";
//				switch (field.getDataType()) {
//				case STRING:
//					fieldClassName = "String";
//					break;
//				case INTEGER:
//					fieldClassName = "Integer";
//					break;
//				case DOUBLE:
//					fieldClassName = "Double";
//					break;
//				case DIC:
//					fieldClassName = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL, field.getRefDic());
//					importClasses.add(this.basePackage + "." + this.dicPackage + "." + fieldClassName);
//					break;
//				case TABLE:
//					fieldClassName = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL, field.getRefTableName());
//					importClasses.add(this.basePackage + "." + this.entityPackage + "." + fieldClassName);
//					break;
//				default:
//					fieldClassName = "String";
//					break;
//				}
//				
//				mapField.put("fieldName", field.getFieldName());
//				mapField.put("nullable", field.getNullable());
//				mapField.put("length", field.getLength());
//				mapField.put("className", fieldClassName);
//				mapField.put("fieldCamelName", fieldCamelName);
//				mapField.put("refFieldName", field.getRefFieldName());
//				mapField.put("refFieldCamelName", refFieldCamelName);
//				mapField.put("fieldUpperCamelName", fieldUpperCamelName);
//				mapField.put("dataType", field.getDataType());
//				
//				fields.add(mapField);
//			}
//			
//			// OneToManys
//			for (TableField field : oneToManys) {
//				Map<String, Object> mapField = new HashMap<String, Object>();
//				
//				String fieldCamelName = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.LOWER_CAMEL, field.getRefTable().getTableName()) + "List";
//				String fieldUpperCamelName = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL, field.getRefTable().getTableName()) + "List";
//				String refFieldCamelName = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.LOWER_CAMEL, field.getRefFieldName());
//				String fieldClassName = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL, field.getRefTable().getTableName());
//
//				mapField.put("className", fieldClassName);
//				mapField.put("refFieldCamelName", refFieldCamelName);
//				mapField.put("fieldCamelName", fieldCamelName);
//				mapField.put("fieldUpperCamelName", fieldUpperCamelName);
//				mapField.put("dataType", "ONETOMANY");
//				
//				fields.add(mapField);
//			}
//
//			root.put("fields", fields);
//			root.put("importClasses", importClasses);
//			//生成
//			String packageDir = MakeDir.makeByPackage(packageName, this.outputFolder);
//			String fileName = packageDir + "/" + className + ".java";
//			fw = new FileWriter(fileName, false);
//			
//			template.process(root, fw);
//		} catch (Exception e) {
//			logger.error("Failed to get template.", e);
//		} finally {
//			if (fw != null) {
//				try {
//					fw.close();
//				} catch (IOException e) {
//				}
//			}
//		}
//	}
	

	private GenerateMetaData convertToMetaData(String projectName, DimuBeanTable table, List<DimuBeanColumn> columns) {
		if (StringUtils.isEmpty(projectName)) {
			return null;
		}
		
		if (table == null) {
			return null;
		}
		
		if (columns == null || columns.size() == 0) {
			return null;
		}
		
		List<GenerateMetaColumn> metaColumns = new ArrayList<GenerateMetaColumn>();
		columns.forEach(column -> metaColumns.add(new GenerateMetaColumn(column)));
		
		GenerateMetaData metaData = new GenerateMetaData();
		metaData.setProjectName(projectName);
		metaData.setTable(new GenerateMetaTable(table));
		metaData.setColums(metaColumns);
		
		return metaData;
	}
}
