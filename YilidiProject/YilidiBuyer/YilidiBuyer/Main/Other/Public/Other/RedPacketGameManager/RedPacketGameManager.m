//
//  RedPacketGameManager.m
//  YilidiBuyer
//
//  Created by mm on 16/10/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "RedPacketGameManager.h"
#import "DLGrabRedPacketGameInfoModel.h"

static NSString *hasBeganGrabedRedPacketKey = @"hasBeganGrabedRedPacketKey";
static NSString *hasGotRedPacketKey = @"hasGotRedPacketKey";
static NSString *redPacketGameNormalEndedKey = @"redPacketGameNormalEndedKey";

@interface RedPacketGameManager()

@property (nonatomic, assign)BOOL hasBeganGrabedRedPacket;

@property (nonatomic, assign)BOOL hasGotRedPacket;

@property (nonatomic, assign)BOOL redPacketGameNormalEnded;

@end

@implementation RedPacketGameManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark ---------------------Public Method------------------------------
- (void)markHasBeganGrabedRedPacket {
    self.hasBeganGrabedRedPacket = YES;
}

- (void)markHasGotRedPacket {
    if (self.hasGotRedPacket) {
        return;
    }
    self.hasGotRedPacket = YES;
}

- (void)markRedPacketGameNormalEnded {

    self.redPacketGameNormalEnded = YES;
 }

- (BOOL)hasTheExceptionConditionForLastRedPacketGame {
    BOOL last_hasBeganGrabedRedPacket = [self _valueForGrabRedPacketFlowStatus:hasBeganGrabedRedPacketKey];
    BOOL last_hasGotRedPacket = [self _valueForGrabRedPacketFlowStatus:hasGotRedPacketKey];
    BOOL last_redPacketGameNormalEnded = [self _valueForGrabRedPacketFlowStatus:redPacketGameNormalEndedKey];
    if (last_hasBeganGrabedRedPacket&&last_hasGotRedPacket&&!last_redPacketGameNormalEnded) {
        return YES;
    }else {
        return NO;
    }
}

- (void)resetGrabRedPacketGameFlowStatus {
    self.hasBeganGrabedRedPacket = NO;
    self.hasGotRedPacket = NO;
    self.redPacketGameNormalEnded = NO;
}


#pragma mark ---------------------Setter/Getter Method------------------------------
- (void)setHasBeganGrabedRedPacket:(BOOL)hasBeganGrabedRedPacket {
    _hasBeganGrabedRedPacket = hasBeganGrabedRedPacket;
    [self _saveGrabRedPacketFlowStatus:_hasBeganGrabedRedPacket forKey:hasBeganGrabedRedPacketKey];
}

- (void)setHasGotRedPacket:(BOOL)hasGotRedPacket {
    _hasGotRedPacket = hasGotRedPacket;
    [self _saveGrabRedPacketFlowStatus:_hasGotRedPacket forKey:hasGotRedPacketKey];
}

- (void)setRedPacketGameNormalEnded:(BOOL)redPacketGameNormalEnded {
    _redPacketGameNormalEnded = redPacketGameNormalEnded;
    [self _saveGrabRedPacketFlowStatus:_redPacketGameNormalEnded forKey:redPacketGameNormalEndedKey];
}


#pragma mark ---------------------Private Method------------------------------
- (void)_saveGrabRedPacketFlowStatus:(BOOL)grabRedPacketFlowStatus forKey:(NSString *)grabRedPacketFlowStatusKey{
    [kUserDefaults setObject:@(grabRedPacketFlowStatus) forKey:grabRedPacketFlowStatusKey];
}

- (BOOL)_valueForGrabRedPacketFlowStatus:(NSString *)grabRedPacketFlowStatusKey{
   return [[kUserDefaults objectForKey:grabRedPacketFlowStatusKey] boolValue];
}



#pragma mark ---------------------Api Method------------------------------
-(void)requestGrabRedPacketGameInfoResultBlock:(RequestRedPacketGameInfoBackBlock)requestRedPacketGameInfoBackBlock
{
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_GetGrabRedPacketGameInfo block:^(NSDictionary *resultDic, NSError *error) {
        DLGrabRedPacketGameInfoModel *grabRedPacketGameInfoModel = [[DLGrabRedPacketGameInfoModel alloc] initWithDefaultDataDic:resultDic[EntityKey]];
        requestRedPacketGameInfoBackBlock(grabRedPacketGameInfoModel,CanGrapRedPacket);
    }];
}

-(void)requestBeginGrabRedPacketGameInfoResultBlock:(RequestRedPacketGameInfoBackBlock)requestRedPacketGameInfoBackBlock
{
    

    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_GetBeginGrabRedPacketGameInfo block:^(NSDictionary *resultDic, NSError *error) {
        
        //空的，系统异常==》NoRedPacketGame
        //非空，非系统异常，residueTimes<=0==>CannotGrapRedPacket
        //其他==>CanGrapRedPacket
        
        //系统异常
        if (error.code != 1) {
            requestRedPacketGameInfoBackBlock(nil,NoRedPacketGame);
            return;
        }
        
        NSDictionary *gameInfo = resultDic[EntityKey];
        if (isEmpty(gameInfo)) {//空的
            requestRedPacketGameInfoBackBlock(nil,NoRedPacketGame);
            return;
        }else {
            DLGrabRedPacketGameInfoModel *grabRedPacketGameInfoModel = [[DLGrabRedPacketGameInfoModel alloc] initWithDefaultDataDic:gameInfo];
            if (isEmpty(grabRedPacketGameInfoModel.activityId)) {//空的
                requestRedPacketGameInfoBackBlock(nil,NoRedPacketGame);
                return;
            }
            
            if (grabRedPacketGameInfoModel.residueTimes <= 0) {
                requestRedPacketGameInfoBackBlock(grabRedPacketGameInfoModel,CannotGrapRedPacket);
            }else {
                requestRedPacketGameInfoBackBlock(grabRedPacketGameInfoModel,CanGrapRedPacket);
            }
        }

    }];
}



@end
