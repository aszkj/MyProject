package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.system.model.SystemParamsHistory;

/**
 * 功能描述：系统参数历史记录数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public interface SystemParamsHistoryMapper {

	/**
	 * 保存参数历史信息
	 * @param record 参数历史记录对象
	 * @return 影响行数
	 */
    Integer save(SystemParamsHistory record);

    /**
     * 查询所有的历史记录
     * @return 历史记录列表
     */
    List<SystemParamsHistory> list();
    
    /**
     * 根据参数id查询所有的历史记录
     * @param paramId 参数Id
     * @return 历史记录列表
     */
    List<SystemParamsHistory> listByParamId(Integer paramId);

}