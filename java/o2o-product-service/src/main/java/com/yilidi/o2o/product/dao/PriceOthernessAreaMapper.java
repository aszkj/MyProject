package com.yilidi.o2o.product.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.PriceOthernessArea;

/**
 * 功能描述：价格差异化区域设置数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface PriceOthernessAreaMapper {

	/**
	 * 保存价格差异化的地区设置
	 * 
	 * @param record
	 *            地区设置记录
	 * @return 影响的行数
	 */
	Integer save(PriceOthernessArea record);

    /**
     * 根据差异化ID查询差异化地区设置
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param othernessPriceId
     *            价格差异化ID
     * @return 地区设置列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRICE_OTHERNESS_AREA })
    List<PriceOthernessArea> listByOthernessPriceId(Integer othernessPriceId);

}