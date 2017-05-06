package com.yilidi.o2o.product.proxy.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.proxy.IBuyRewardActivityProxyService;
import com.yilidi.o2o.product.proxy.dto.BuyRewardGiftInfoProxyDto;
import com.yilidi.o2o.product.service.IBuyRewardActivityAuditService;
import com.yilidi.o2o.product.service.dto.RewardSaleProductDto;
import com.yilidi.o2o.product.service.dto.RewardTicketDto;

@Service("buyRewardActivityProxyService")
public class BuyRewardActivityProxyServiceImpl implements IBuyRewardActivityProxyService {

    @Autowired
    private IBuyRewardActivityAuditService buyRewardActivityAuditService;

    @Override
    public List<BuyRewardGiftInfoProxyDto> listBySaleProductIdsAndNumber(
            List<KeyValuePair<Integer, Integer>> saleProductIdAndNumberPairs) throws ProductServiceException {
        if (ObjectUtils.isNullOrEmpty(saleProductIdAndNumberPairs)) {
            return Collections.emptyList();
        }
        List<RewardSaleProductDto> allRewardSaleProductDtos = new ArrayList<RewardSaleProductDto>();
        for (KeyValuePair<Integer, Integer> pair : saleProductIdAndNumberPairs) {
            List<RewardSaleProductDto> rewardSaleProducts = buyRewardActivityAuditService
                    .listRewardSaleProductsBySaleProductId(pair.getKey(), pair.getValue());
            if (!ObjectUtils.isNullOrEmpty(rewardSaleProducts)) {
                allRewardSaleProductDtos.addAll(rewardSaleProducts);
            }
        }
        List<RewardTicketDto> allRewardTicketDtos = new ArrayList<RewardTicketDto>();
        for (KeyValuePair<Integer, Integer> pair : saleProductIdAndNumberPairs) {
            List<RewardTicketDto> rewardTickets = buyRewardActivityAuditService.listRewardTicketsBySaleProductId(pair.getKey(),
                    pair.getValue());
            if (!ObjectUtils.isNullOrEmpty(rewardTickets)) {
                allRewardTicketDtos.addAll(rewardTickets);
            }
        }
        List<BuyRewardGiftInfoProxyDto> buyRewardGiftInfoProxyDtos = new ArrayList<BuyRewardGiftInfoProxyDto>();
        buyRewardGiftInfoProxyDtos.addAll(packageRewardSaleProductInfo(allRewardSaleProductDtos));
        buyRewardGiftInfoProxyDtos.addAll(packageRewardTicketInfo(allRewardTicketDtos));
        return buyRewardGiftInfoProxyDtos;
    }

    private List<BuyRewardGiftInfoProxyDto> packageRewardSaleProductInfo(List<RewardSaleProductDto> rewardSaleProductDtos) {
        if (ObjectUtils.isNullOrEmpty(rewardSaleProductDtos)) {
            return Collections.emptyList();
        }
        List<BuyRewardGiftInfoProxyDto> buyRewardGiftInfoProxyDto = new ArrayList<BuyRewardGiftInfoProxyDto>();
        Map<Integer, BuyRewardGiftInfoProxyDto> map = new HashMap<Integer, BuyRewardGiftInfoProxyDto>();
        for (RewardSaleProductDto rewardSaleProductDto : rewardSaleProductDtos) {
            BuyRewardGiftInfoProxyDto saleProductDto = map.get(rewardSaleProductDto.getId());
            if (map.containsKey(rewardSaleProductDto.getId())) {
                saleProductDto.setGiftNumber(saleProductDto.getGiftNumber().intValue() + rewardSaleProductDto.getNumber());
            } else {
                saleProductDto = new BuyRewardGiftInfoProxyDto();
                saleProductDto.setGiftId(rewardSaleProductDto.getId());
                saleProductDto.setGiftNumber(rewardSaleProductDto.getNumber());
                saleProductDto.setGiftType(SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_PRODUCT);
            }
            map.put(rewardSaleProductDto.getId(), saleProductDto);
        }
        for (Entry<Integer, BuyRewardGiftInfoProxyDto> entry : map.entrySet()) {
            BuyRewardGiftInfoProxyDto rewardSaleProductDto = entry.getValue();
            buyRewardGiftInfoProxyDto.add(rewardSaleProductDto);
        }
        return buyRewardGiftInfoProxyDto;
    }

    private List<BuyRewardGiftInfoProxyDto> packageRewardTicketInfo(List<RewardTicketDto> rewardTicketDtos) {
        if (ObjectUtils.isNullOrEmpty(rewardTicketDtos)) {
            return Collections.emptyList();
        }
        List<BuyRewardGiftInfoProxyDto> buyRewardGiftInfoProxyDto = new ArrayList<BuyRewardGiftInfoProxyDto>();
        Map<Integer, BuyRewardGiftInfoProxyDto> map = new HashMap<Integer, BuyRewardGiftInfoProxyDto>();
        for (RewardTicketDto rewardSaleProductDto : rewardTicketDtos) {
            BuyRewardGiftInfoProxyDto saleProductDto = map.get(rewardSaleProductDto.getTicketId());
            if (map.containsKey(rewardSaleProductDto.getTicketId())) {
                saleProductDto
                        .setGiftNumber(saleProductDto.getGiftNumber().intValue() + rewardSaleProductDto.getRewardNumber());
            } else {
                saleProductDto = new BuyRewardGiftInfoProxyDto();
                saleProductDto.setGiftId(rewardSaleProductDto.getTicketId());
                saleProductDto.setGiftNumber(rewardSaleProductDto.getRewardNumber());
                saleProductDto.setGiftType(SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_COUPON);
            }
            map.put(rewardSaleProductDto.getTicketId(), saleProductDto);
        }
        for (Entry<Integer, BuyRewardGiftInfoProxyDto> entry : map.entrySet()) {
            BuyRewardGiftInfoProxyDto rewardSaleProductDto = entry.getValue();
            buyRewardGiftInfoProxyDto.add(rewardSaleProductDto);
        }
        return buyRewardGiftInfoProxyDto;
    }
}
