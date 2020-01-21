package nz.co.dimu.jspgenerator.dao;

import java.util.List;

import nz.co.dimu.jspgenerator.dto.DimuBeanDoWithBLOBs;

public interface DimuBeanDoMapper {

    List<DimuBeanDoWithBLOBs> selectGroup();

    List<DimuBeanDoWithBLOBs> selectTablesByGroup(String groupId);
    
    DimuBeanDoWithBLOBs selectTableByNo(String tableNo);
    
    DimuBeanDoWithBLOBs selectColumnsByTable(String tableName);
    
}