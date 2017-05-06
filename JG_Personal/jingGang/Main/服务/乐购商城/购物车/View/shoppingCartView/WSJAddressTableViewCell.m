//
//  WSJAddressTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJAddressTableViewCell.h"
#import "PublicInfo.h"

@interface WSJAddressTableViewCell ()


@end

@implementation WSJAddressTableViewCell
- (IBAction)selectAction:(UIButton *)sender
{
    if (self.defaultAddress)
    {
        self.defaultAddress(self.indexPath);
    }
}
/*
 *
 *{
 areaId = 4523277;
 areaInfo = "\U5e7f\U4e1c\U7U51435\U697c";
 areaName = "\U798f\U5efa \U8386\U7530\U5e02";
 mobile = 1234567890;
 trueName = "\U5c0f\U660e";
 zip = 123456;
 },
 *
 */
- (void) cellWithDictionary:(NSDictionary *)dict
{
    self.nameLabel.text = dict[@"trueName"];
    self.telLabel.text = dict[@"mobile"];
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@",dict[@"areaName"],dict[@"areaInfo"]];
}
- (void)awakeFromNib {
    
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.addressLabel.adjustsFontSizeToFitWidth = YES;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(__MainScreen_Width, 0, 110, self.scrollView.frame.size.height)];
    view.backgroundColor = [UIColor blueColor];
    [self.scrollView addSubview:view];
    self.scrollView.contentSize = CGSizeMake(__MainScreen_Width + 110, 1);
    
    UIButton *editBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    editBtn.frame = CGRectMake(0, 0, 55, self.scrollView.frame.size.height);
    editBtn.backgroundColor = UIColorFromRGB(0X666666);
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    editBtn.tag = 1;
    [view addSubview:editBtn];
    
    
    UIButton *delete =[UIButton buttonWithType:UIButtonTypeSystem];
    delete.frame = CGRectMake(55, 0, 55, self.scrollView.frame.size.height);
    delete.backgroundColor = UIColorFromRGB(0Xff0000);
    [delete setTitle:@"删除" forState:UIControlStateNormal];
    [delete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [delete addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    delete.tag = 2;
    [view addSubview:delete];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(tap:)];
    [self.scrollView addGestureRecognizer:tap];
    
}
- (IBAction)tap:(UITapGestureRecognizer *)sender
{
    if (self.selectAction)
    {
        self.selectAction(self.indexPath);
    }
}
- (void) btnAction:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
        if (self.editAction)
        {
            self.editAction(self.indexPath);
        }
            break;
        case 2:
        if (self.deleteAction)
        {
            self.deleteAction(self.indexPath);
        }
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
