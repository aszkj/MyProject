package com.yilidi.o2o.controller.mobile.buyer.system;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appvo.buyer.system.ProductHotWordVO;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;

/**
 * @Description:商品热词
 * @author: chenb
 * @date: 2016年5月27日 上午9:32:37
 */
@Controller("buyerProductHotWordController")
@RequestMapping(value = "/interfaces/buyer")
public class ProductHotWordController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    /**
     * 
     * @Description 获取热门商品关键字搜索接口
     * @param req
     * @param resp
     * @return
     */
    @RequestMapping(value = "/system/hotproductkey")
    @ResponseBody
    public ResultParamModel getProductHotWord(HttpServletRequest req, HttpServletResponse resp) {
        String productHotWord = SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.P_HOT_SEARCH_KEYS);
        List<ProductHotWordVO> productHotWordVOList = new ArrayList<ProductHotWordVO>();
        if (StringUtils.isEmpty(productHotWord)) {
            return super.encapsulateParam(productHotWordVOList, AppMsgBean.MsgCode.SUCCESS, "获取热门商品关键字搜索成功");
        }
        String[] productHotWordArr = productHotWord.split(CommonConstants.DELIMITER_COMMA);
        for (int i = 0; i < productHotWordArr.length; i++) {
            ProductHotWordVO productHotWordVO = new ProductHotWordVO(productHotWordArr[i]);
            productHotWordVOList.add(productHotWordVO);
        }
        return super.encapsulateParam(productHotWordVOList, AppMsgBean.MsgCode.SUCCESS, "获取热门商品关键字搜索成功");
    }
}
