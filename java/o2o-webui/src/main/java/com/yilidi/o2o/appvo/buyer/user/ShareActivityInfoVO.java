package com.yilidi.o2o.appvo.buyer.user;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 分享送好礼信息汇总
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午11:41:15
 */
public class ShareActivityInfoVO extends AppBaseVO {

    private static final long serialVersionUID = -1995712142248270383L;
    /**
     * 分享好礼冠军信息
     */
    private ChampionRewardInfoVO championRewardInfo;
    /**
     * 下一期分享好礼冠军信息
     */
    private ChampionRewardInfoVO nextRewardInfo;
    /**
     * 分享好礼获得规则URL地址链接
     */
    private String infoRuleUrl;

    public ChampionRewardInfoVO getChampionRewardInfo() {
        return championRewardInfo;
    }

    public void setChampionRewardInfo(ChampionRewardInfoVO championRewardInfo) {
        this.championRewardInfo = championRewardInfo;
    }

    public ChampionRewardInfoVO getNextRewardInfo() {
        return nextRewardInfo;
    }

    public void setNextRewardInfo(ChampionRewardInfoVO nextRewardInfo) {
        this.nextRewardInfo = nextRewardInfo;
    }

    public String getInfoRuleUrl() {
        return infoRuleUrl;
    }

    public void setInfoRuleUrl(String infoRuleUrl) {
        this.infoRuleUrl = infoRuleUrl;
    }

}
