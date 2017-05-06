package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.system.model.ScheduleSetting;

/**
 * 功能描述：系统调度配置数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ScheduleSettingMapper {

	/**
	 * 根据ID更新调度配置(如果字段值为NULL,则不更新该字段， 推荐使用该方法进行更新)
	 * 
	 * @param record
	 *            配置对象
	 * @return 影响行数
	 */
	Integer updateByIdSelective(ScheduleSetting record);

	/**
	 * 根据ID更新调度配置
	 * 
	 * @param record
	 *            配置对象
	 * @return 影响行数
	 */
	Integer updateById(ScheduleSetting record);

	/**
	 * 根据ID查询调度配置
	 * 
	 * @param scheduleId
	 *            调度配置Id
	 * @return 配置对象
	 */
	ScheduleSetting loadById(Integer scheduleId);

	/**
	 * 查询所有的调度配置
	 * 
	 * @return 配置列表
	 */
	List<ScheduleSetting> list();

}