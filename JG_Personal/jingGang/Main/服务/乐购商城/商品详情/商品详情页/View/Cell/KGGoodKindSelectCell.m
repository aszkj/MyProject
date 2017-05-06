//
//  KGGoodKindSelectCell.m
//  jingGang
//
//  Created by 张康健 on 15/8/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KGGoodKindSelectCell.h"
#import "UIViewExt.h"
#import "PublicInfo.h"
#import "GlobeObject.h"

@interface KGGoodKindSelectCell(){
    
    UIView *_seperatedView;

}

@end


@implementation KGGoodKindSelectCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 200, 25)];
        _typeLabel.textColor = [UIColor darkGrayColor];
//        _typeLabel.backgroundColor = [UIColor grayColor];
        _typeLabel.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:_typeLabel];
        
        _typeView = [[welfareView alloc] initWithFrame:CGRectMake(0, _typeLabel.bottom, self.width, 100)];
        _typeView.selectedColor = NavBarColor;
        [self addSubview:_typeView];
//        _typeView.backgroundColor = [UIColor greenColor];
        WEAK_SELF
        _typeView.clickIndexBlock = ^(NSInteger clickIndex, NSString *clickTitle,BOOL open){
            
            NSLog(@"click index %ld",clickIndex);
            if (open) {
                NSLog(@"点击");
            }else{

                NSLog(@"取消点击");
            }
            NSDictionary *originalDic = weak_self.properArr[clickIndex];
            NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:originalDic];
            [mutableDic setObject:@(open) forKey:@"open"];
            
            [kNotification postNotificationName:selectGoodsCationPropertyNotification object:mutableDic];

        
        };
        
        _seperatedView = [UIView new];
        _seperatedView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:_seperatedView];
    }

    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.typeLabel.text = self.typeTitle;
    if (!self.typeView.titleArr) {//滑动cell会调用这里，，防止重复赋值，计算
        self.typeView.titleArr = self.typeArr;
    }
    _seperatedView.frame = CGRectMake(0, _typeView.bottom+1, self.width, 1);
    
    
}


@end
