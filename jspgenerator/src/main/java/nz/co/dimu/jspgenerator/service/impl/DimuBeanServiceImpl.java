package nz.co.dimu.jspgenerator.service.impl;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.druid.util.StringUtils;
import com.fasterxml.jackson.databind.ObjectMapper;

import nz.co.dimu.jspgenerator.dao.DimuBeanDoMapper;
import nz.co.dimu.jspgenerator.dto.DimuBeanDoWithBLOBs;
import nz.co.dimu.jspgenerator.service.DimuBeanService;
import nz.co.dimu.jspgenerator.service.model.DimuBeanColumn;
import nz.co.dimu.jspgenerator.service.model.DimuBeanGroup;
import nz.co.dimu.jspgenerator.service.model.DimuBeanTable;

@Service
public class DimuBeanServiceImpl implements DimuBeanService {

	@Autowired
	private DimuBeanDoMapper dimuBeanDoMapper;
	@Override
	public List<DimuBeanGroup> getGroups() {
		List<DimuBeanGroup> groups = new ArrayList<DimuBeanGroup>();
		

		List<DimuBeanDoWithBLOBs> queryResult = dimuBeanDoMapper.selectGroup();
		if (queryResult != null && queryResult.size() > 0) {
			queryResult.forEach(dto -> groups.add(convertDoToGroup(dto)));
		}
		
		
		return groups;
	}

	@Override
	public List<DimuBeanTable> getTablesByGroup(String groupId) {
		List<DimuBeanTable> tables = new ArrayList<DimuBeanTable>();
		

		List<DimuBeanDoWithBLOBs> queryResult = dimuBeanDoMapper.selectTablesByGroup(groupId);
		if (queryResult != null && queryResult.size() > 0) {
			queryResult.forEach(dto -> tables.add(convertDoToTable(dto)));
		}
		
		return tables;
	}

	@Override
	public List<DimuBeanColumn> getColumnsByTable(String tableNo) {
		DimuBeanDoWithBLOBs dto = dimuBeanDoMapper.selectColumnsByTable(tableNo);
		List<DimuBeanColumn> columns = new ArrayList<DimuBeanColumn>();
		if (dto != null) {
			columns = convertDoToColumns(dto);
		}
		return columns;
	}

	@Override
	public DimuBeanTable getTableByNo(String tableNo) {
		DimuBeanDoWithBLOBs dto = dimuBeanDoMapper.selectTableByNo(tableNo);
		DimuBeanTable table = convertDoToTable(dto);
		return table;
	}

	
	private DimuBeanGroup convertDoToGroup(DimuBeanDoWithBLOBs dto) {
		if (dto == null) {
			return null;
		}
		DimuBeanGroup model = new DimuBeanGroup();
		model.setId(String.valueOf(dto.getId()));
		model.setGroupNo(dto.getExt3());
		model.setGroupName(dto.getExt2());
		return model;
	}

	private DimuBeanTable convertDoToTable(DimuBeanDoWithBLOBs dto) {
		if (dto == null) {
			return null;
		}
		DimuBeanTable model = new DimuBeanTable();
		model.setTableNo(dto.getExt3());
		model.setTableName(dto.getExt2());
		return model;
	}

	private List<DimuBeanColumn> convertDoToColumns(DimuBeanDoWithBLOBs dto) {
		List<DimuBeanColumn> columns = new ArrayList<DimuBeanColumn>();
		if (dto == null) {
			return columns;
		}
		try {
			//ext 12 ~ 20
			for(int i = 12; i <= 20; i++) {
				String methodName = "getExt" + i;
				Method method = dto.getClass().getMethod(methodName);
				Object json = method.invoke(dto);
				if (json != null && !StringUtils.isEmpty(json.toString())) {
					DimuBeanColumn column = convertJsonToColumns(json.toString());
					
					if (column != null) {
						columns.add(column);
					}
				}
			}
			//tag 1 ~ 30
			for(int i = 1; i <= 30; i++) {
				String methodName = "getTag" + i;
				Method method;
				method = dto.getClass().getMethod(methodName);
				Object json = method.invoke(dto);
				if (json != null && !StringUtils.isEmpty(json.toString())) {
					DimuBeanColumn column = convertJsonToColumns(json.toString());
					
					if (column != null) {
						columns.add(column);
					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return columns;
	}
	private DimuBeanColumn convertJsonToColumns(String json) {
		if (StringUtils.isEmpty(json)) {
			return null;
		}
		ObjectMapper mapper = new ObjectMapper();
		DimuBeanColumn model = null;
		try {
			model = mapper.readValue(json, DimuBeanColumn.class);
			
			if (StringUtils.isEmpty(model.getName())) {
				return null;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return model;
	}
	
}
