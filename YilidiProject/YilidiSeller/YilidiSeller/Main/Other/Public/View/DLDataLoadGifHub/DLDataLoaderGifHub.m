//
//  DLDataLoaderGifHub.m
//  YilidiSeller
//
//  Created by yld on 16/4/22.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLDataLoaderGifHub.h"
#import "GiFHUD.h"
#import <Masonry/Masonry.h>

@implementation DLDataLoaderGifHub

static DLDataLoaderGifHub *instance;


+ (instancetype)instance {
    if (!instance) {
        instance = [[DLDataLoaderGifHub alloc] init];
        [GiFHUD setGifWithImageName:@"pika.gif"];
        instance.backgroundColor = [UIColor whiteColor];
    }
    return instance;
}


+ (instancetype)showInContainerView:(UIView *)containerView {
    
    [containerView addSubview:[self instance]];
    [instance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(containerView);
    }];
    [GiFHUD show];
    return instance;
}

+ (void)dissmiss {
    [instance removeFromSuperview];
    [GiFHUD dismiss];
}



@end
