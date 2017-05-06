package com.yilidi.o2o.controller.mobile.seller.product;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.seller.product.GetProductTypeParam;
import com.yilidi.o2o.appvo.seller.product.ProductClassVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.SellerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.SellerBaseController;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.dto.ProductClassDto;

/**
 * @Description: TODO(产品类型Controller)
 * @author: chenlian
 * @date: 2016年6月1日 下午5:09:04
 */
@Controller("sellerProductClassController")
@RequestMapping(value = "/interfaces/seller")
public class ProductClassController extends SellerBaseController {

	private static final String SELLERFLAG = "SELLER";
	
    @Autowired
    private IProductClassService productClassService;

    /**
     * 
     * 获取商品类型列表
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/product/getproducttype")
    @ResponseBody
    public ResultParamModel getProductType(HttpServletRequest req, HttpServletResponse resp) {
        GetProductTypeParam getProductTypeParam = super.getEntityParam(req, GetProductTypeParam.class);
        String parentClassCode = getProductTypeParam.getParentClassCode();
        if (WebConstants.PRODUCT_TYPE_TOP_CLASS.equals(parentClassCode)) {
            parentClassCode = null;
        }
        List<ProductClassDto> productClassDtoList = productClassService.listProductClassByParentCode(SELLERFLAG,super.getStoreId(),
                parentClassCode);
        List<ProductClassVO> productClassVOList = copyList(productClassDtoList);
        return super.encapsulateParam(productClassVOList, AppMsgBean.MsgCode.SUCCESS, "获取商品类型列表成功");
    }

	private List<ProductClassVO> copyList(List<ProductClassDto> productClassDtoList) {
		List<ProductClassVO> productClassVOList = new ArrayList<>();
		if (!ObjectUtils.isNullOrEmpty(productClassDtoList)) {
			ProductClassVO productClassVO = null;
            for (ProductClassDto productClassDto : productClassDtoList) {
            	productClassVO = new ProductClassVO();
            	ObjectUtils.fastCopy(productClassDto, productClassVO);
                productClassVO.setSubClassList(copyList(productClassDto.getSubClassList()));
                productClassVO.setClassImageUrl(productClassDto.getClassImageUrl());
                productClassVOList.add(productClassVO);
            }
        }
		return productClassVOList;
	}
}
