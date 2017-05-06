//
//  WSJShoppingCartEditTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJShoppingCartEditTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"
#import "VApiManager.h"
#import "KJShoppingAlertView.h"

@interface WSJShoppingCartEditTableViewCell ()
{
    WSJShoppingCartInfoModel *_model;
    VApiManager *_vapiManager;
    __weak IBOutlet UIButton *_jianfaBtn;
}

//选中按钮
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
//标题图片
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
//商品规格
@property (weak, nonatomic) IBOutlet UILabel *specInfo;



@end

@implementation WSJShoppingCartEditTableViewCell

- (void)willCellWith:(WSJShoppingCartInfoModel *)model
{
    _model = model;
    self.selectBtn.selected = model.isSelect;
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(model.imageURL, self.titleImageView.frame.size.width, self.titleImageView.frame.size.height) ]];
    self.specInfo.text = model.specInfo;
    self.countLabel.text = [NSString stringWithFormat:@"%@",model.count];
    if ([model.count intValue] == 1)
    {
        _jianfaBtn.selected = YES;
        _jianfaBtn.userInteractionEnabled = NO;
    }
    else
    {
        _jianfaBtn.selected = NO;
    }
}
- (void)awakeFromNib {
    self.specInfo.adjustsFontSizeToFitWidth = YES;
    self.countLabel.adjustsFontSizeToFitWidth = YES;
    _vapiManager = [[VApiManager alloc] init];
}
- (IBAction)deleteCell:(UIButton *)sender
{
    if (self.deleteCell)
    {
        self.deleteCell(self.indexPath);
    }
}
- (IBAction)selectAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _model.isSelect = sender.selected;
    if (self.selectShopping)
    {
        self.selectShopping([_model.ID stringValue],sender.selected);
    }
}
//商品个数计算
- (IBAction)countActionBtn:(UIButton *)sender
{
    int count = [self.countLabel.text intValue];
    if (sender.tag == 1)//减法操作
    {
        if (count > 1)
        {
            self.countLabel.text = [NSString stringWithFormat:@"%d",--count];
        }
        if (count == 1)
        {
            sender.selected = YES;
            sender.userInteractionEnabled = NO;
        }
        else
        {
            sender.selected = NO;
        }
        
    }
    else if (sender.tag == 2)//加法操作
    {
        if (count < [_model.goodsInventory intValue])
        {
            self.countLabel.text = [NSString stringWithFormat:@"%d",++count];
            _jianfaBtn.selected = NO;
            _jianfaBtn.userInteractionEnabled = YES;
        }
        else
        {
           [KJShoppingAlertView showAlertTitle:@"亲，没那么多库存量！" inContentView:self.window];
            return;
        }
        
    }
    _model.count = @(count);
    if (self.changeCount) {
        self.changeCount(count,_model.ID);
    }
}

- (IBAction)btnAction:(id)sender {
    [self selectAction:self.selectBtn];
}

@end
