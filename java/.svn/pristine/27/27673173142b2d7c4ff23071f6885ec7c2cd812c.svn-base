/**
 * 文件名称：SaleOrderShardingTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.math.RandomUtils;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.sequence.IDGenerator;
import com.yilidi.o2o.core.sharding.dimension.concrete.DateDimension;
import com.yilidi.o2o.core.sharding.dimension.concrete.DateDimensionArgument;
import com.yilidi.o2o.core.sharding.dimension.concrete.EnumerationDimension;
import com.yilidi.o2o.core.sharding.dimension.concrete.NormalDimension;
import com.yilidi.o2o.core.sharding.model.ShardingOperationModel;
import com.yilidi.o2o.core.sharding.model.TableShardingModel;
import com.yilidi.o2o.core.sharding.model.concrete.SaleOrderShardingModel;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.model.SaleOrder;
import com.yilidi.o2o.order.service.dto.query.SaleOrderQueryDto;

/**
 * 功能描述：<简单描述> <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleOrderShardingTest extends BaseMapperTest {

    @Autowired
    private SaleOrderShardingMapper saleOrderShardingMapper;

    private IDGenerator generator = new IDGenerator();

    @Test
    public void testSave() {
        for (int i = 0; i < 100; i++) {
            SaleOrder order = new SaleOrder();
            order.setId(generator.generate("SALE_ORDER_ID_SEQUENCE").intValue());
            order.setDeliveryMode("aa");
            order.setBestTime("bb");
            order.setProviceCode("7");
            order.setCityCode("8");
            order.setCountyCode("9");
            order.setSendStatus("no send");
            order.setSendCount(1);
            order.setTakeStatus("no take");
            order.setUserId(RandomUtils.nextInt(100));
            order.setChannelCode("IOS");
            order.setCreateTime(new Date());
            order.setCreateUserId(RandomUtils.nextInt(100));
            order.setOrderCount(RandomUtils.nextInt(50));
            order.setStoreId(RandomUtils.nextInt(100));
            order.setBuyerCustomerId(RandomUtils.nextInt(100));
            order.setStatusCode(SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY);
            order.setTotalAmount(RandomUtils.nextInt(5000) * 1000L);
            order.setTransferFee(RandomUtils.nextInt(5000) * 1000L);
            order.setTypeCode(StringUtils.randomString(8));

            List<TableShardingModel> tableShardingModelList = new ArrayList<TableShardingModel>();

            TableShardingModel saleOrderShardingModelForSaleOrderNo = new SaleOrderShardingModel(new NormalDimension(
                    SaleOrderShardingModel.ShardingKey.SALEORDERNO.getValue(), order.getSaleOrderNo()));

            TableShardingModel saleOrderShardingModelForRetailerId = new SaleOrderShardingModel(new NormalDimension(
                    SaleOrderShardingModel.ShardingKey.RETAILERID.getValue(), order.getBuyerCustomerId()));

            TableShardingModel saleOrderShardingModelForProviderId = new SaleOrderShardingModel(new NormalDimension(
                    SaleOrderShardingModel.ShardingKey.PROVIDERID.getValue(), order.getStoreId()));

            TableShardingModel saleOrderShardingModelForUserId = new SaleOrderShardingModel(new NormalDimension(
                    SaleOrderShardingModel.ShardingKey.USERID.getValue(), order.getUserId()));

            TableShardingModel saleOrderShardingModelForStatusCode = new SaleOrderShardingModel(new EnumerationDimension(
                    SaleOrderShardingModel.ShardingKey.STATUSCODE.getValue(), order.getStatusCode()));

            TableShardingModel saleOrderShardingModelForCreateTime = new SaleOrderShardingModel(new DateDimension(
                    SaleOrderShardingModel.ShardingKey.CREATETIME.getValue(), new DateDimensionArgument.Builder()
                            .concreteDate(order.getCreateTime()).build()));

            tableShardingModelList.add(saleOrderShardingModelForSaleOrderNo);
            tableShardingModelList.add(saleOrderShardingModelForRetailerId);
            tableShardingModelList.add(saleOrderShardingModelForProviderId);
            tableShardingModelList.add(saleOrderShardingModelForUserId);
            tableShardingModelList.add(saleOrderShardingModelForStatusCode);
            tableShardingModelList.add(saleOrderShardingModelForCreateTime);

            ShardingOperationModel shardingOperationModel = new ShardingOperationModel(tableShardingModelList,
                    ShardingOperationModel.OperationType.MULTI_DIMENSION_WRITE.getValue());

            Map<String, Object> operationArgumentMap = new HashMap<String, Object>();
            operationArgumentMap.put("saleOrder", order);
            shardingOperationModel.setOperationArgumentMap(operationArgumentMap);

            saleOrderShardingMapper.save(shardingOperationModel);
        }
    }

    @Test
    public void testLoadBySaleOrderNo() {

        String saleOrderNo = "20150723183121489dky";

        TableShardingModel saleOrderShardingModelForSaleOrderNo = new SaleOrderShardingModel(new NormalDimension(
                SaleOrderShardingModel.ShardingKey.SALEORDERNO.getValue(), saleOrderNo));

        ShardingOperationModel shardingOperationModel = new ShardingOperationModel(saleOrderShardingModelForSaleOrderNo);

        Map<String, Object> operationArgumentMap = new HashMap<String, Object>();
        operationArgumentMap.put("saleOrderNo", saleOrderNo);
        shardingOperationModel.setOperationArgumentMap(operationArgumentMap);

        SaleOrder order = saleOrderShardingMapper.loadBySaleOrderNo(shardingOperationModel);
        printInfo(order);
    }

    @Test
    public void testUpdatePrice() {

        String saleOrderNo = "20150724181406021Qnb";

        TableShardingModel saleOrderShardingModelForSaleOrderNo = new SaleOrderShardingModel(new NormalDimension(
                SaleOrderShardingModel.ShardingKey.SALEORDERNO.getValue(), saleOrderNo));

        ShardingOperationModel shardingOperationModel = new ShardingOperationModel(saleOrderShardingModelForSaleOrderNo);

        Map<String, Object> operationArgumentMap = new HashMap<String, Object>();
        operationArgumentMap.put("saleOrderNo", saleOrderNo);
        shardingOperationModel.setOperationArgumentMap(operationArgumentMap);

        SaleOrder order = saleOrderShardingMapper.loadBySaleOrderNo(shardingOperationModel);

        TableShardingModel saleOrderShardingModelForSaleOrderNo1 = new SaleOrderShardingModel(new NormalDimension(
                SaleOrderShardingModel.ShardingKey.SALEORDERNO.getValue(), order.getSaleOrderNo()));

        TableShardingModel saleOrderShardingModelForRetailerId = new SaleOrderShardingModel(new NormalDimension(
                SaleOrderShardingModel.ShardingKey.RETAILERID.getValue(), order.getBuyerCustomerId()));

        TableShardingModel saleOrderShardingModelForProviderId = new SaleOrderShardingModel(new NormalDimension(
                SaleOrderShardingModel.ShardingKey.PROVIDERID.getValue(), order.getStoreId()));

        TableShardingModel saleOrderShardingModelForUserId = new SaleOrderShardingModel(new NormalDimension(
                SaleOrderShardingModel.ShardingKey.USERID.getValue(), order.getUserId()));

        TableShardingModel saleOrderShardingModelForStatusCode = new SaleOrderShardingModel(new EnumerationDimension(
                SaleOrderShardingModel.ShardingKey.STATUSCODE.getValue(), order.getStatusCode()));

        TableShardingModel saleOrderShardingModelForCreateTime = new SaleOrderShardingModel(new DateDimension(
                SaleOrderShardingModel.ShardingKey.CREATETIME.getValue(), new DateDimensionArgument.Builder().concreteDate(
                        order.getCreateTime()).build()));

        List<TableShardingModel> tableShardingModelList = new ArrayList<TableShardingModel>();
        tableShardingModelList.add(saleOrderShardingModelForSaleOrderNo1);
        tableShardingModelList.add(saleOrderShardingModelForRetailerId);
        tableShardingModelList.add(saleOrderShardingModelForProviderId);
        tableShardingModelList.add(saleOrderShardingModelForUserId);
        tableShardingModelList.add(saleOrderShardingModelForStatusCode);
        tableShardingModelList.add(saleOrderShardingModelForCreateTime);

        Map<String, Object> operationArgumentMap1 = new HashMap<String, Object>();
        operationArgumentMap1.put("saleOrderNo", saleOrderNo);
        operationArgumentMap1.put("totalAmount", 2500);
        operationArgumentMap1.put("transferFee", 18);

        ShardingOperationModel shardingOperationModel1 = new ShardingOperationModel(tableShardingModelList,
                ShardingOperationModel.OperationType.MULTI_DIMENSION_WRITE.getValue());
        shardingOperationModel1.setOperationArgumentMap(operationArgumentMap1);

        saleOrderShardingMapper.updatePriceBySaleOrderNo(shardingOperationModel1);

    }

    @Test
    public void testShardingByCreateTime() {
        shardingByCreateTimeForSpecificTable(2);
        shardingByCreateTimeForSpecificTable(3);
        shardingByCreateTimeForSpecificTable(4);
        shardingByCreateTimeForSpecificTable(5);
    }

    private void shardingByCreateTimeForSpecificTable(int tableIndex) {
        List<TableShardingModel> tableShardingModelList = new ArrayList<TableShardingModel>();
        Date currentDate = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(currentDate);
        calendar.add(Calendar.MONTH, -SaleOrderShardingModel.INTERVAL_MONTHS * (tableIndex - 1));
        TableShardingModel saleOrderShardingModel1 = new SaleOrderShardingModel(new DateDimension(
                SaleOrderShardingModel.ShardingKey.CREATETIME.getValue(), new DateDimensionArgument.Builder().concreteDate(
                        calendar.getTime()).build()));
        calendar.add(Calendar.MONTH, SaleOrderShardingModel.INTERVAL_MONTHS);
        TableShardingModel saleOrderShardingModel2 = new SaleOrderShardingModel(new DateDimension(
                SaleOrderShardingModel.ShardingKey.CREATETIME.getValue(), new DateDimensionArgument.Builder().concreteDate(
                        calendar.getTime()).build()));
        tableShardingModelList.add(saleOrderShardingModel1);
        tableShardingModelList.add(saleOrderShardingModel2);
        Map<String, Object> operationArgumentMap = new HashMap<String, Object>();
        operationArgumentMap.put("beginIntervalMonths", SaleOrderShardingModel.INTERVAL_MONTHS * (tableIndex - 1));
        if (tableIndex < 5) {
            operationArgumentMap.put("endIntervalMonths", SaleOrderShardingModel.INTERVAL_MONTHS * tableIndex);
        }
        ShardingOperationModel shardingOperationModel = new ShardingOperationModel(tableShardingModelList,
                ShardingOperationModel.OperationType.MULTI_TABLE_ON_ONE_SQL.getValue());
        shardingOperationModel.setOperationArgumentMap(operationArgumentMap);
        saleOrderShardingMapper.shardingByCreateTime(shardingOperationModel);
        saleOrderShardingMapper.deleteByCreateTimeForSharding(shardingOperationModel);
    }

    @Test
    public void testFindSaleOrders() {
        SaleOrderQueryDto saleOrderQuery = new SaleOrderQueryDto();
        try {
            saleOrderQuery.setStartOrderDate(DateUtils.parseDate("2014-07-01 14:34:56"));
            saleOrderQuery.setEndOrderDate(DateUtils.parseDate("2015-06-17 18:02:47"));
            saleOrderQuery.setStart(2);
            saleOrderQuery.setPageSize(30);

            TableShardingModel saleOrderShardingModel = new SaleOrderShardingModel(new DateDimension(
                    SaleOrderShardingModel.ShardingKey.CREATETIME.getValue(), new DateDimensionArgument.Builder()
                            .fromDate(saleOrderQuery.getStartOrderDate()).toDate(saleOrderQuery.getEndOrderDate()).build()));

            ShardingOperationModel shardingOperationModel = new ShardingOperationModel(saleOrderShardingModel);
            shardingOperationModel.setStart(saleOrderQuery.getStart());
            shardingOperationModel.setPageSize(saleOrderQuery.getPageSize());

            Map<String, Object> operationArgumentMap = new HashMap<String, Object>();
            operationArgumentMap.put("saleOrderQuery", saleOrderQuery);
            shardingOperationModel.setOperationArgumentMap(operationArgumentMap);

            Page<SaleOrder> page = saleOrderShardingMapper.findSaleOrders(shardingOperationModel);

            logger.info("pageSize: ------------> " + page.getPageSize());
            logger.info("pageNumber: ------------> " + page.getPageNum());
            logger.info("pageEndRow: ------------> " + page.getEndRow());
            logger.info("pageTotal: ------------> " + page.getTotal());
            logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(page.getResult()));

        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testListSaleOrders() {
        SaleOrderQueryDto saleOrderQuery = new SaleOrderQueryDto();
        try {
            saleOrderQuery.setStartOrderDate(DateUtils.parseDate("2014-07-01 14:34:56"));
            saleOrderQuery.setEndOrderDate(DateUtils.parseDate("2015-06-17 18:02:47"));

            TableShardingModel saleOrderShardingModel = new SaleOrderShardingModel(new DateDimension(
                    SaleOrderShardingModel.ShardingKey.CREATETIME.getValue(), new DateDimensionArgument.Builder()
                            .fromDate(saleOrderQuery.getStartOrderDate()).toDate(saleOrderQuery.getEndOrderDate()).build()));

            ShardingOperationModel shardingOperationModel = new ShardingOperationModel(saleOrderShardingModel);

            Map<String, Object> operationArgumentMap = new HashMap<String, Object>();
            operationArgumentMap.put("saleOrderQuery", saleOrderQuery);
            shardingOperationModel.setOperationArgumentMap(operationArgumentMap);

            List<SaleOrder> list = saleOrderShardingMapper.listSaleOrders(shardingOperationModel);

            logger.info("list.size(): ------------> " + list.size());
            logger.info("list: ------------> " + JsonUtils.toJsonStringWithDateFormat(list));

        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

}
