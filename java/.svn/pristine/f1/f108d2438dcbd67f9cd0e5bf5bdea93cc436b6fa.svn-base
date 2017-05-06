package com.yilidi.o2o.product.proxy.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.proxy.dto.ThemeProxyDto;
import com.yilidi.o2o.product.proxy.IThemeProxyService;
import com.yilidi.o2o.product.service.IThemeService;
import com.yilidi.o2o.product.service.dto.ThemeDto;

@Service("themeProxyService")
public class ThemeProxyServiceImpl implements IThemeProxyService{

	@Autowired
	private IThemeService themeService;
	
	@Override
	public ThemeProxyDto loadById(Integer id) {
		ThemeProxyDto themeProxyDto = null;  
		ThemeDto themeDto = themeService.loadById(id);
		if(!ObjectUtils.isNullOrEmpty(themeDto)){
			themeProxyDto = new ThemeProxyDto(); 
			ObjectUtils.fastCopy(themeDto, themeProxyDto);
		}
		return themeProxyDto;
	}

	@Override
	public ThemeProxyDto loadByTypeCode(String typeCode) {
		ThemeProxyDto themeProxyDto = null;  
		ThemeDto themeDto = themeService.loadByTypeCode(typeCode);
		if(!ObjectUtils.isNullOrEmpty(themeDto)){
			themeProxyDto = new ThemeProxyDto(); 
			ObjectUtils.fastCopy(themeDto, themeProxyDto);
		}
		return themeProxyDto;
	}
	
	
	
}
