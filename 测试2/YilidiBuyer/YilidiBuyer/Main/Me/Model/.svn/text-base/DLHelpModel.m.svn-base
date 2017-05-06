//
//  DLHelpModel.m
//  YilidiBuyer
//
//  Created by yld on 16/5/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHelpModel.h"

@implementation DLHelpModel
-(instancetype)initWithcontent:(NSString *)content{
    
    self = [super init];
    if (self ) {
        self.content = content;
    }
    return self;
}

-(CGFloat)cellHeight{
    
        // 文字的最大尺寸
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT);
    // 计算文字的高度
    CGFloat textH = [self.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
    // c文字部分的高度
    _cellHeight = 40 + textH;
    

    return _cellHeight;
    
}

@end
