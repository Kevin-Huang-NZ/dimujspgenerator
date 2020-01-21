package nz.co.dimu.jspgenerator.service;

import java.util.List;

import nz.co.dimu.jspgenerator.service.model.DimuBeanColumn;
import nz.co.dimu.jspgenerator.service.model.DimuBeanTable;
import nz.co.dimu.jspgenerator.service.model.GenerateMetaData;

public interface GenerateService {
	void generate(String projectName, DimuBeanTable table, List<DimuBeanColumn> columns);
}
