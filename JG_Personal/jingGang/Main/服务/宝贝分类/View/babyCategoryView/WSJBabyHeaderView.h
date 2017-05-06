//
//  WSJBabyHeaderView.h
//  jingGang
//
//  Created by thinker on 15/8/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger{
    k_Header,
    k_footer,
    k_sectionHeader
}tableType;

@interface WSJBabyHeaderView : UIView

@property (nonatomic, assign) tableType type;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, copy) void (^block)(void);

@end
