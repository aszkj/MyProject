/**
 * 文件名称：TradeEvaluationTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.TradeEvaluationMapper;
import com.yilidi.o2o.order.model.TradeEvaluation;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class TradeEvaluationTest extends BaseMapperTest {

    @Autowired
    private TradeEvaluationMapper tradeEvaluationMapper;

    Integer saleProductId = 10;

    @Test
    public void testSave() {
        TradeEvaluation te = new TradeEvaluation();

        te.setId(StringUtils.generateEvaluationOrderNo());
        te.setAttitudeStar(4);
        te.setCoincideStar(4);
        te.setContent(StringUtils.randomString(30));
        te.setEvaluationGrade("1");
        te.setImage1("image1");
        te.setImage2("image2");
        te.setImage3("image3");
        te.setImpression(Short.parseShort("00101110", 2));
        te.setLogisticsStar(5);
        te.setSaleOrderNo(StringUtils.generateSaleOrderNo());
        te.setSaleProductId(saleProductId);
        te.setSendStar(5);
        te.setUserId(10);
        te.setCreateTime(new Date());

        tradeEvaluationMapper.save(te);
    }

    @Test
    public void testList() {
        List<TradeEvaluation> teList = tradeEvaluationMapper.listBySaleProductId(saleProductId);

        printInfo(teList);
    }

}
