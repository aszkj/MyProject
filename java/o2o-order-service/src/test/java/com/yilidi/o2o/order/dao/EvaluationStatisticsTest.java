/**
 * 文件名称：EvaluationStatisticsTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.order.dao.EvaluationStatisticsMapper;
import com.yilidi.o2o.order.model.EvaluationStatistics;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class EvaluationStatisticsTest extends BaseMapperTest {

	@Autowired
	private EvaluationStatisticsMapper evaluationStatisticsMapper;

	Integer saleProductId = 3;

	@Test
	public void testCheck() {
		Integer count = evaluationStatisticsMapper.checkSaleProduct(1);
		if (0 < count) {
			printInfo("存在");
		} else {
			printInfo("不存在");
		}
	}

	@Test
	public void testLoad() {
		EvaluationStatistics es = evaluationStatisticsMapper.loadBySaleProductId(1);
		printInfo(es);
	}

	@Test
	public void testUpdateGood() {
		Integer count = evaluationStatisticsMapper.checkSaleProduct(saleProductId);
		if (0 < count) {
			evaluationStatisticsMapper.updateGoodBySaleProductId(saleProductId);
		} else {
			EvaluationStatistics es = new EvaluationStatistics();
			es.setSaleProductId(saleProductId);
			es.setGoodCount(1);
			es.setNormalCount(0);
			es.setPoorCount(0);
			es.setImageCount(0);
			evaluationStatisticsMapper.save(es);
		}
	}

	@Test
	public void testUpdateNormal() {
		Integer count = evaluationStatisticsMapper.checkSaleProduct(saleProductId);
		if (0 < count) {
			evaluationStatisticsMapper.updateNormalBySaleProductId(saleProductId);
		} else {
			EvaluationStatistics es = new EvaluationStatistics();
			es.setSaleProductId(saleProductId);
			es.setGoodCount(0);
			es.setNormalCount(1);
			es.setPoorCount(0);
			es.setImageCount(0);
			evaluationStatisticsMapper.save(es);
		}
	}

	@Test
	public void testUpdatePoor() {
		Integer count = evaluationStatisticsMapper.checkSaleProduct(saleProductId);
		if (0 < count) {
			evaluationStatisticsMapper.updatePoorBySaleProductId(saleProductId);
		} else {
			EvaluationStatistics es = new EvaluationStatistics();
			es.setSaleProductId(saleProductId);
			es.setGoodCount(0);
			es.setNormalCount(0);
			es.setPoorCount(1);
			es.setImageCount(0);
			evaluationStatisticsMapper.save(es);
		}
	}

	@Test
	public void testUpdateImage() {

		Integer count = evaluationStatisticsMapper.checkSaleProduct(saleProductId);
		if (0 < count) {
			evaluationStatisticsMapper.updateImageBySaleProductId(saleProductId);
		} else {
			EvaluationStatistics es = new EvaluationStatistics();
			es.setSaleProductId(saleProductId);
			es.setGoodCount(0);
			es.setNormalCount(0);
			es.setPoorCount(0);
			es.setImageCount(1);
			evaluationStatisticsMapper.save(es);
		}
	}
}
