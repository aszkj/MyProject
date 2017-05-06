package com.yilidi.o2o.core.sharding.router;

import java.text.ParseException;
import java.util.Map;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.sharding.dimension.concrete.DateDimension;
import com.yilidi.o2o.core.sharding.dimension.concrete.EnumerationDimension;
import com.yilidi.o2o.core.sharding.dimension.concrete.NormalDimension;
import com.yilidi.o2o.core.sharding.model.TableShardingModel;
import com.yilidi.o2o.core.sharding.model.concrete.SaleOrderShardingModel;
import com.yilidi.o2o.core.sharding.router.algorithm.IShardingAlgorithm;
import com.yilidi.o2o.core.sharding.router.algorithm.date.DateShardingAlgorithm;
import com.yilidi.o2o.core.sharding.router.algorithm.enumeration.EnumerationShardingAlgorithm;
import com.yilidi.o2o.core.sharding.router.algorithm.normal.hash.ConsistentHashingShardingAlgorithm;
import com.yilidi.o2o.core.sharding.router.algorithm.normal.mod.ModShardingAlgorithm;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.sharding.dimension.concrete.DateDimensionArgument;

/**
 * 表分片路由
 * 
 * @author chenl
 * 
 */
public class TableShardingRouter {

    private static final Logger LOGGER = Logger.getLogger(TableShardingRouter.class);

    private IShardingAlgorithm shardingAlgorithm;

    public TableShardingRouter(IShardingAlgorithm shardingAlgorithm) {
        this.shardingAlgorithm = shardingAlgorithm;
    }

    public Map<String, String> router(TableShardingModel tableShardingModel) {
        return shardingAlgorithm.sharding(tableShardingModel);
    }

    public static void main(String[] args) {
        TableShardingRouter consistentHashingRouter = new TableShardingRouter(new ConsistentHashingShardingAlgorithm());
        Map<String, String> map1 = consistentHashingRouter.router(new SaleOrderShardingModel(new NormalDimension(
                SaleOrderShardingModel.ShardingKey.RETAILERID.getValue(), 897)));
        for (Map.Entry<String, String> entry : map1.entrySet()) {
            String key = entry.getKey();
            LOGGER.info("consistentHashingRouter ==================== Key : " + key);
            String value = entry.getValue();
            LOGGER.info("consistentHashingRouter ==================== Value : " + value);
        }

        TableShardingRouter modRouter = new TableShardingRouter(new ModShardingAlgorithm());
        Map<String, String> map2 = modRouter.router(new SaleOrderShardingModel(new NormalDimension(
                SaleOrderShardingModel.ShardingKey.RETAILERID.getValue(), 897)));
        for (Map.Entry<String, String> entry : map2.entrySet()) {
            String key = entry.getKey();
            LOGGER.info("modRouter ==================== Key : " + key);
            String value = entry.getValue();
            LOGGER.info("modRouter ==================== Value : " + value);
        }

        TableShardingRouter enumerationRouter = new TableShardingRouter(new EnumerationShardingAlgorithm());
        Map<String, String> map3 = enumerationRouter.router(new SaleOrderShardingModel(new EnumerationDimension(
                SaleOrderShardingModel.ShardingKey.STATUSCODE.getValue(), "noPay")));
        for (Map.Entry<String, String> entry : map3.entrySet()) {
            String key = entry.getKey();
            LOGGER.info("enumerationRouter ==================== Key : " + key);
            String value = entry.getValue();
            LOGGER.info("enumerationRouter ==================== Value : " + value);
        }

        TableShardingRouter dateRouter = new TableShardingRouter(new DateShardingAlgorithm());
        Map<String, String> map = null;
        map = dateRouter.router(new SaleOrderShardingModel(new DateDimension(SaleOrderShardingModel.ShardingKey.CREATETIME
                .getValue(), new DateDimensionArgument.Builder().build())));
        for (Map.Entry<String, String> entry : map.entrySet()) {
            String key = entry.getKey();
            LOGGER.info("dateRouter ==================== Key : " + key);
            String value = entry.getValue();
            LOGGER.info("dateRouter ==================== Value : " + value);
        }

        TableShardingRouter dateRouter1 = new TableShardingRouter(new DateShardingAlgorithm());
        Map<String, String> map4 = null;
        try {
            map4 = dateRouter1.router(new SaleOrderShardingModel(new DateDimension(
                    SaleOrderShardingModel.ShardingKey.CREATETIME.getValue(), new DateDimensionArgument.Builder()
                            .concreteDate(DateUtils.parseDate("2014-12-20 10:03:56")).build())));
            for (Map.Entry<String, String> entry : map4.entrySet()) {
                String key = entry.getKey();
                LOGGER.info("dateRouter1 ==================== Key : " + key);
                String value = entry.getValue();
                LOGGER.info("dateRouter1 ==================== Value : " + value);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        TableShardingRouter dateRouter2 = new TableShardingRouter(new DateShardingAlgorithm());
        Map<String, String> map5 = null;
        try {
            map5 = dateRouter2.router(new SaleOrderShardingModel(new DateDimension(
                    SaleOrderShardingModel.ShardingKey.CREATETIME.getValue(), new DateDimensionArgument.Builder().fromDate(
                            DateUtils.parseDate("2014-12-20 10:03:56")).build())));
            for (Map.Entry<String, String> entry : map5.entrySet()) {
                String key = entry.getKey();
                LOGGER.info("dateRouter2 ==================== Key : " + key);
                String value = entry.getValue();
                LOGGER.info("dateRouter2 ==================== Value : " + value);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        TableShardingRouter dateRouter3 = new TableShardingRouter(new DateShardingAlgorithm());
        Map<String, String> map6 = null;
        try {
            map6 = dateRouter3.router(new SaleOrderShardingModel(new DateDimension(
                    SaleOrderShardingModel.ShardingKey.CREATETIME.getValue(), new DateDimensionArgument.Builder().toDate(
                            DateUtils.parseDate("2015-03-16 18:12:43")).build())));
            for (Map.Entry<String, String> entry : map6.entrySet()) {
                String key = entry.getKey();
                LOGGER.info("dateRouter3 ==================== Key : " + key);
                String value = entry.getValue();
                LOGGER.info("dateRouter3 ==================== Value : " + value);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        TableShardingRouter dateRouter4 = new TableShardingRouter(new DateShardingAlgorithm());
        Map<String, String> map7 = null;
        try {
            map7 = dateRouter4.router(new SaleOrderShardingModel(new DateDimension(
                    SaleOrderShardingModel.ShardingKey.CREATETIME.getValue(), new DateDimensionArgument.Builder()
                            .fromDate(DateUtils.parseDate("2014-12-20 10:03:56"))
                            .toDate(DateUtils.parseDate("2015-03-16 18:12:43")).build())));
            for (Map.Entry<String, String> entry : map7.entrySet()) {
                String key = entry.getKey();
                LOGGER.info("dateRouter4 ==================== Key : " + key);
                String value = entry.getValue();
                LOGGER.info("dateRouter4 ==================== Value : " + value);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

}
