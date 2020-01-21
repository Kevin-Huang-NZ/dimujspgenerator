package nz.co.dimu.jspgenerator.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.util.StringUtils;

import nz.co.dimu.jspgenerator.controller.vo.DimuBeanColumnVo;
import nz.co.dimu.jspgenerator.controller.vo.DimuBeanGroupVo;
import nz.co.dimu.jspgenerator.controller.vo.DimuBeanTableVo;
import nz.co.dimu.jspgenerator.response.CommonReturnType;
import nz.co.dimu.jspgenerator.response.error.BusinessException;
import nz.co.dimu.jspgenerator.response.error.EmBusinessError;
import nz.co.dimu.jspgenerator.service.DimuBeanService;
import nz.co.dimu.jspgenerator.service.GenerateService;
import nz.co.dimu.jspgenerator.service.model.DimuBeanColumn;
import nz.co.dimu.jspgenerator.service.model.DimuBeanGroup;
import nz.co.dimu.jspgenerator.service.model.DimuBeanTable;
import static nz.co.dimu.jspgenerator.utils.LambdaExceptionUtil.rethrowConsumer;
@Controller
@RequestMapping("/")
@CrossOrigin
public class DimuBeanController extends BaseController {
	@Autowired 
	private DimuBeanService dimuBeanService;
	@Autowired 
	private GenerateService generateService;
	
	//http://127.0.0.1:8090/groups
//	@RequestMapping(value="/groups",method= {RequestMethod.GET}, consumes= {CONTENT_TYPE_FORMED})
//	@RequestMapping(value="/groups",method= {RequestMethod.GET})
	@GetMapping(value={"/groups"})
	@ResponseBody
	public CommonReturnType getGroup() throws BusinessException {
		List<DimuBeanGroupVo> voGroups = new ArrayList<DimuBeanGroupVo>();
		
		List<DimuBeanGroup> groups = dimuBeanService.getGroups();
		groups.forEach(rethrowConsumer(group -> {
			DimuBeanGroupVo groupVo = convertModelToGroupVo(group);
			if (groupVo != null) {
				voGroups.add(groupVo);
			}
		}));
		
		if (voGroups.size() == 0) {
			throw new BusinessException(EmBusinessError.DATA_NOT_EXIST.setErrMsg("没有定义任何分组。"));
		}
		
		
		return CommonReturnType.create(voGroups);
	}
	
	//http://127.0.0.1:8090/tables?groupId=200000
	//@RequestMapping(value="/tables")
	@GetMapping(value={"/group/{groupId}/tables"})
//	@PostMapping(value={"/tables"})
	@ResponseBody
	public CommonReturnType getTables(@PathVariable String groupId) throws BusinessException {
//	public CommonReturnType getTables(@RequestBody String groupId) throws BusinessException {

		logger.info("param groupId:{}", groupId);
		List<DimuBeanTableVo> voTables = new ArrayList<DimuBeanTableVo>();
		
		List<DimuBeanTable> tables = dimuBeanService.getTablesByGroup(groupId);
		tables.forEach(rethrowConsumer(table -> {
			DimuBeanTableVo tableVo = convertModelToTableVo(table);
			if (tableVo != null) {
				voTables.add(tableVo);
			}
		}));
		
		if (voTables.size() == 0) {
			logger.info("分组下没有定义任何数据表。");
			throw new BusinessException(EmBusinessError.DATA_NOT_EXIST.setErrMsg("分组下边没有定义表。"));
		}

		return CommonReturnType.create(voTables);
	}

	@PostMapping(value={"/table/generate"})
	@ResponseBody
	public CommonReturnType generateHTML( @RequestParam(value = "projectName") String projectName, @RequestParam(value = "tables[]") List<String> tables) throws BusinessException {
		logger.info("tableNos:{}", tables.size());
		logger.info("projectName:{}", projectName);
		
		if (StringUtils.isEmpty(projectName)) {
			throw new BusinessException(EmBusinessError.PARAMETER_VALIDATION_ERROR.setErrMsg("没有输入项目英文名称。"));
		}
		
		if (tables.size() == 0) {
			throw new BusinessException(EmBusinessError.PARAMETER_VALIDATION_ERROR.setErrMsg("没有选择要生成的表。"));
		}
		tables.forEach(tableNo -> {
			List<DimuBeanColumn> columns = this.dimuBeanService.getColumnsByTable(tableNo);
			DimuBeanTable table = this.dimuBeanService.getTableByNo(tableNo);
			this.generateService.generate(projectName, table, columns);
		});
		return CommonReturnType.create(null);
	}
	
//	//http://127.0.0.1:8090/columns?tableName=colExchangeRecord
////	@RequestMapping(value="/columns")
//	@GetMapping(value={"/table/{tableName}/columns"})
//	@ResponseBody
//	public CommonReturnType getColumns(@PathVariable(name="tableName") String tableName) throws BusinessException {
//		List<DimuBeanColumnVo> voColumns = new ArrayList<DimuBeanColumnVo>();
//		
//		List<DimuBeanColumn> columns = dimuBeanService.getColumnsByTable(tableName);
//		columns.forEach(column -> {
//			DimuBeanColumnVo columnVo = convertModelToColumnVo(column);
//			if (columnVo != null) {
//				voColumns.add(columnVo);
//			}
//		});
//		
//		if (voColumns.size() == 0) {
//			throw new BusinessException(EmBusinessError.DATA_NOT_EXIST.setErrMsg("表没有定义字段。"));
//		}
//
//		return CommonReturnType.create(voColumns);
//	}
	
	private DimuBeanGroupVo convertModelToGroupVo(DimuBeanGroup group) throws BusinessException {
		if (group == null) {
			return null;
		}
		DimuBeanGroupVo vo = new DimuBeanGroupVo();
		try {
			BeanUtils.copyProperties(vo, group);
		} catch (Exception e) {
			logger.error("类型转换错误。",e);
			throw new BusinessException(EmBusinessError.DATA_TYPE_CAST_ERROR);
		}
		
		return vo;
	}
	
	private DimuBeanTableVo convertModelToTableVo(DimuBeanTable table) throws BusinessException {
		if (table == null) {
			return null;
		}
		DimuBeanTableVo vo = new DimuBeanTableVo();
		try {
			BeanUtils.copyProperties(vo, table);
		} catch (Exception e) {
			logger.error("类型转换错误。",e);
			throw new BusinessException(EmBusinessError.DATA_TYPE_CAST_ERROR);
		}
		
		return vo;
	}
}
