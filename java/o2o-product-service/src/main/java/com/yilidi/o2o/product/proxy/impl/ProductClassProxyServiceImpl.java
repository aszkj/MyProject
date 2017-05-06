package com.yilidi.o2o.product.proxy.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.proxy.IProductClassProxyService;
import com.yilidi.o2o.product.proxy.dto.ProductClassProxyDto;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.dto.ProductClassDto;

@Service("productClassProxyService")
public class ProductClassProxyServiceImpl extends BaseService implements IProductClassProxyService {

    @Autowired
    IProductClassService productClassService;
    
    @Override
    public List<Object> getSubClassCodes(String classCode) {
        return productClassService.getSubClassCodes(classCode);
    }

	@Override
	public ProductClassProxyDto getProductClassByCode(String classCode) {
		ProductClassDto productClassDto = productClassService.loadProductClassByClassCode(classCode, null);
		ProductClassProxyDto productClassProxyDto = null;
		if(!ObjectUtils.isNullOrEmpty(productClassDto)){
			productClassProxyDto = new ProductClassProxyDto();
			ObjectUtils.fastCopy(productClassDto, productClassProxyDto);
		}
		return productClassProxyDto;
	}

}
