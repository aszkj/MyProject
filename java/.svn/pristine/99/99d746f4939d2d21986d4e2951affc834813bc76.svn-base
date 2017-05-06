package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.system.model.SystemAnnouncement;

/**
 * 功能描述：系统公告数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SystemAnnouncementMapper {
	/**
	 * 保存公告信息
	 * 
	 * @param record
	 *            公告信息对象
	 * @return 影响的行数
	 */
	Integer save(SystemAnnouncement record);

	/**
	 * 根据公告ID删除公告信息
	 * 
	 * @param id
	 *            公告id
	 * @return 影响行数
	 */
	Integer deleteById(Integer id);

	/**
	 * 根据ID更新公告内容（如果字段值为NULL，则不更新该字段，推荐使用该方法进行更新）
	 * 
	 * @param record
	 *            公告对象
	 * @return 影响行数
	 */
	Integer updateByIdSelective(SystemAnnouncement record);

	/**
	 * 根据ID更新公告内容
	 * 
	 * @param record
	 *            公告对象
	 * @return 影响行数
	 */
	Integer updateById(SystemAnnouncement record);

	/**
	 * 根据Id查询公告内容
	 * 
	 * @param id
	 *            公告Id
	 * @return 公告对象
	 */
	SystemAnnouncement loadById(Integer id);

	/**
	 * 加载所有的公告
	 * 
	 * @return 公告对象列表
	 */
	List<SystemAnnouncement> list();

	/**
	 * 根据状态查询公告
	 * 
	 * @param status
	 *            公告状态 "0" 未发布， "1" 发布 "2" 撤销，在系统字典中定义
	 * @return 公告对象列表
	 */
	List<SystemAnnouncement> listByStatus(String status);
}