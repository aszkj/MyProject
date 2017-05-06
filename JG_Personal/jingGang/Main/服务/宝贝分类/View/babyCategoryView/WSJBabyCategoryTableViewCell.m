//
//  WSJBabyCategoryTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJBabyCategoryTableViewCell.h"
#import "PublicInfo.h"

@interface WSJBabyCategoryTableViewCell ()

@property (nonatomic, strong) NSMutableArray *dataLabel;

@end

@implementation WSJBabyCategoryTableViewCell

- (instancetype)init
{
    self = [super init];
    
    return self;
}

- (void)setData:(NSArray *)data
{
    _data = data;
    self.dataLabel = [NSMutableArray array];
    for (UIView *v in self.contentView.subviews)
    {
        [v removeFromSuperview];
    }
    NSInteger row = self.data.count / 2 + self.data.count % 2;
    for (NSInteger i = 0 ; i < row ; i++)
    {
        for (NSInteger j = 0 ; j < 2 ; j ++)
        {
            if ((i * 2 + j) != self.data.count)
            {
                UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20 + (__MainScreen_Width - 40) / 2 * j, 4 + 50 * i , (__MainScreen_Width - 40) / 2 - 2, 48)];
                l.backgroundColor = UIColorFromRGB(0XF3F3F3);
                NSDictionary *dict = self.data[i * 2 + j];
                l.text = [NSString stringWithFormat:@"  %@",dict[@"className"]];
                l.textColor = UIColorFromRGB(0X666666);
                l.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectAction:)];
                [l addGestureRecognizer:tap];
                l.tag = i * 2 + j;
                [self.contentView addSubview:l];
                [self.dataLabel addObject:l];
            }
        }
    }
}

- (void) SelectAction:(UIGestureRecognizer *)ges
{
    for (UILabel *l in self.dataLabel)
    {
        l.backgroundColor = UIColorFromRGB(0XF3F3F3);
        l.textColor = UIColorFromRGB(0X666666);
    }
    UILabel *label = self.dataLabel[ges.view.tag];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = UIColorFromRGB(0X5AC4F1);
    if (self.selectAction)
    {
        self.selectAction(ges.view.tag);
    }
}


@end
