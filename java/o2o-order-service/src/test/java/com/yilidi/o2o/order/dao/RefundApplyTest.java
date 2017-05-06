/**
 * 文件名称：RefundApplyTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import java.util.Date;

import org.apache.commons.lang.math.RandomUtils;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.model.RefundApply;
import com.yilidi.o2o.order.model.RefundApplyHistory;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class RefundApplyTest extends BaseMapperTest {

    @Autowired
    private RefundApplyMapper refundApplyMapper;

    @Autowired
    private RefundApplyHistoryMapper refundApplyHistoryMapper;

    @Test
    public void testSave() {
        RefundApply apply = new RefundApply();
        apply.setApplyTime(new Date());
        apply.setApplyUserId(RandomUtils.nextInt(100));
        apply.setStoreId(RandomUtils.nextInt(100));
        apply.setRefundAmount(5800000L);
        apply.setSaleOrderNo(StringUtils.generateSaleOrderNo());
        apply.setStatusCode(StringUtils.randomString(8));
        refundApplyMapper.save(apply);
        printInfo(apply.getId());
        this.saveHistory(apply);
    }

    private void saveHistory(RefundApply apply) {
        RefundApplyHistory his = new RefundApplyHistory();
        his.setApplyId(apply.getId());
        his.setApplyUserId(apply.getApplyUserId());
        his.setMessage(apply.getMessage());
        his.setOperationTime(apply.getApplyTime());
        his.setOperationUserId(apply.getApplyUserId());
        his.setStoreId(apply.getStoreId());
        his.setRefundAmount(apply.getRefundAmount());
        his.setBuyerCustomerId(apply.getBuyerCustomerId());
        his.setSaleOrderNo(apply.getSaleOrderNo());
        his.setStatusCode(apply.getStatusCode());
        refundApplyHistoryMapper.save(his);
    }

}
