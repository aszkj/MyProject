package com.yilidi.o2o.product.proxy;

import java.util.List;

import com.yilidi.o2o.product.proxy.dto.ProductClassProxyDto;

/**
 * 产品分类代理服务接口
 *
 * @author: zhangkun
 * @date: 2016年12月28日 上午9:22:38
 */
public interface IProductClassProxyService {
    
    /**
     * 根据一个classCode递归获取子集(最下一级的)的classCode
     * 
     * <p>
     * Description:
     * </p>
     * 
     * @param classCode
     * @return
     * @see com.yilidi.o2o.product.service.IProductClassService#getSunClassCodes(java.lang.String)
     */
    public List<Object> getSubClassCodes(String classCode);
    
    /**
     * 根据code 查询
     * @param code
     */
	public ProductClassProxyDto getProductClassByCode(String classCode);
}
