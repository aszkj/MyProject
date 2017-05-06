//
//  RepyLatestMessageModel.m
//  weimi
//
//  Created by 张康健 on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "RepyLatestMessageModel.h"
#import "NSString+Teshuzifu.h"

@implementation RepyLatestMessageModel

-(void)setTypeStr:(NSString *)typeStr {

    if ([typeStr isEqualToString:@"TEXT"]) {
        self.latestMessageType = LatestMessageTextType;
    }else if ([typeStr isEqualToString:@"IMAGE"]){
        self.latestMessageType = LatestMessageImageType;
    }else if([typeStr isEqualToString:@"VOICE"]){
        self.latestMessageType = LatestMessageSoundType;
    }
}



-(NSMutableAttributedString *)showStr {
    
//    if (!_showStr) {
        NSString *contentStr = nil;
        if (self.latestMessageType == LatestMessageTextType) {
            contentStr = self.latesMessageText;
        }else if (self.latestMessageType == LatestMessageImageType){
            contentStr = @"回复了一张图片";
        }else {
            contentStr = @"回复了一条语音";
        }
        
        NSString *totalStr = [NSString stringWithFormat:@"%@:%@",self.latesMessageUserNickName,contentStr];
        NSMutableAttributedString *finalStr = [[NSMutableAttributedString alloc] initWithString:totalStr];

        NSRange nickNameRange = NSMakeRange(0, self.latesMessageUserNickName.length+1);
        [finalStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x576b95) range:nickNameRange];
        _showStr = finalStr;
//    }
    
   return _showStr;
    
}

-(CGSize)contentSize {
    
//    CGSize size = [self.showStr.string getSizeWithWidth:(kScreenWidth-kLatestMessageToLeft-kLatestMessageToTopGap+10) font:kSystemFontWithSize(14)];
    CGSize size = [self.showStr.string getSizeWithWidth:(kScreenWidth-64-kLatestMessageToTopGap*2-3) font:[UIFont customFontOfSize:14]];

    return size ;
}


-(CGSize)totalSize {
    
    return CGSizeMake(self.contentSize.width+kLatestMessageToTopGap*2, self.contentSize.height+kLatestMessageToTopGap*5);
}




@end
