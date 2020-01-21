package nz.co.dimu.jspgenerator.service;

import java.util.List;

import nz.co.dimu.jspgenerator.service.model.DimuBeanColumn;
import nz.co.dimu.jspgenerator.service.model.DimuBeanGroup;
import nz.co.dimu.jspgenerator.service.model.DimuBeanTable;

public interface DimuBeanService {
	List<DimuBeanGroup> getGroups();
	List<DimuBeanTable> getTablesByGroup(String groupId);
	List<DimuBeanColumn> getColumnsByTable(String tableNo);
	DimuBeanTable getTableByNo(String tableNo);
}
