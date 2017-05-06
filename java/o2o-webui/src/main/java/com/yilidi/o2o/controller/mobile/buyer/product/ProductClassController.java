package com.yilidi.o2o.controller.mobile.buyer.product;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.product.GetProductTypeParam;
import com.yilidi.o2o.appvo.buyer.product.ProductClassVO;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.dto.ProductClassDto;

/**
 * 商品分类
 * 
 * @author: chenb
 * @date: 2016年5月25日 上午11:37:38
 */
@Controller("buyerProductClassController")
@RequestMapping(value = "/interfaces/buyer")
public class ProductClassController extends BuyerBaseController {
	private static final String BUYERFLAG = "BUYER";
	@Autowired
	private IProductClassService productClassService;

	/**
	 * 获取商品类型列表
	 * 
	 * @Description 获取商品类型列表
	 * @param req
	 *            request请求
	 * @param resp
	 *            response响应
	 * @return ResultParamModel
	 */
	@RequestMapping(value = "/product/getproducttype")
	@ResponseBody
	public ResultParamModel getProductType(HttpServletRequest req, HttpServletResponse resp) {
		GetProductTypeParam getProductTypeParam = super.getEntityParam(req, GetProductTypeParam.class);
		String parentClassCode = getProductTypeParam.getParentClassCode(); // 上一级类型编码
		Integer storeId = getProductTypeParam.getStoreId(); // 店铺ID
		if (!StringUtils.isEmpty(parentClassCode)) {
			List<ProductClassDto> productClassDtoList = productClassService.listProductClassByParentCode(BUYERFLAG,storeId,
					parentClassCode);
			List<ProductClassVO> productClassVOList = copyList(productClassDtoList);
			return super.encapsulateParam(productClassVOList, AppMsgBean.MsgCode.SUCCESS, "获取商品类型列表成功");
		}
		return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "数据有误，请刷新重试");
	}

	private List<ProductClassVO> copyList(List<ProductClassDto> list) {
		List<ProductClassVO> productClassVOs = new ArrayList<>();
		if (ObjectUtils.isNullOrEmpty(list)) {
			return productClassVOs;
		}
		for (ProductClassDto productClassDto : list) {
			ProductClassVO productClassVO = new ProductClassVO();
			ObjectUtils.fastCopy(productClassDto, productClassVO);
			productClassVO.setClassImageUrl(productClassDto.getClassImageUrl());
			productClassVO.setSubClassList(copyList(productClassDto.getSubClassList()));
			productClassVOs.add(productClassVO);
		}
		return productClassVOs;
	}
}
