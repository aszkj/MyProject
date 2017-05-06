//
//  DLGoodsSearchTopView.m
//  YilidiBuyer
//
//  Created by yld on 16/5/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsSearchTopView.h"
#import "UITextField+placeHolderSetting.h"
#import "UIButton+Block.h"
#import <Masonry/Masonry.h>

@interface DLGoodsSearchTopView()<UITextFieldDelegate>
@property (nonatomic, copy)NSString *keyWords;

@property (weak, nonatomic) IBOutlet UIView *searchBgView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *clearTextFieldButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrSearchButton;

@property (nonatomic, strong)UIButton *clickToBeginSearchButton;


@end


@implementation DLGoodsSearchTopView

- (void)awakeFromNib {
    [self _init];
}

#pragma mark -------------------Init Method----------------------
-(void)_init {
    RAC(self,keyWords) = self.searchTextField.rac_textSignal;
    self.searchTextValidateSignal = [RACObserve(self, keyWords) map:^NSNumber *(NSString* keyWords) {
        return @(!isEmpty(keyWords));
    }];
    @weakify(self);
    [self.searchTextValidateSignal subscribeNext:^(NSNumber *valide) {
        @strongify(self);
        self.clearTextFieldButton.hidden = !valide.integerValue;
        self.cancelOrSearchButton.selected = valide.integerValue;
    }];
    self.searchTextField.delegate = self;
    self.cancelOrSearchButton.selected = NO;
    [self.searchTextField setTextPlaceHolderFont:kSystemFontSize(14.0f) placeHolderTextColor:UIColorFromRGB(0x8b8b8b)];
    self.searchType = SearchType_Goods;
}

#pragma mark -------------------Private Method----------------------
- (void)_beginSearch {
    if (isEmpty(self.keyWords)) {
        [Util ShowAlertWithOnlyMessage:@"搜索内容不能为空"];
        return;
    }
    emptyBlock(self.beginSearchBlock,self.keyWords);
    [self.searchTextField resignFirstResponder];
}

- (void)_cancelSearch {
    emptyBlock(self.cancelSearchBlock);
    [self.searchTextField resignFirstResponder];
}

- (void)_configureUIBySearchType {
    NSString *textPlaceHolder = nil;
    if (self.searchType == SearchType_Goods) {
        textPlaceHolder = @"请输入商品";
    }else if (self.searchType == SearchType_Area) {
        textPlaceHolder = @"请输入小区、写字楼、街道";
    }
    self.searchTextField.placeholder = textPlaceHolder;
}

#pragma mark -------------------Setter/Getter Method----------------------
- (void)setSearchType:(SearchType)searchType {
    _searchType = searchType;
    [self _configureUIBySearchType];
}

- (UIButton *)clickToBeginSearchButton {
    
    if (!_clickToBeginSearchButton) {
        _clickToBeginSearchButton = [UIButton new];
        [self.searchBgView addSubview:_clickToBeginSearchButton];
        [_clickToBeginSearchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.searchBgView);
        }];
        WEAK_SELF
        [_clickToBeginSearchButton addActionHandler:^(NSInteger tag) {
            emptyBlock(weak_self.clickToBeginSearchBlock);
        }];
    }
    return _clickToBeginSearchButton;
}

- (void)setClickToBeginSearchBlock:(ClickToBeginSearchBlock)clickToBeginSearchBlock {
    _clickToBeginSearchBlock = clickToBeginSearchBlock;
    self.clickToBeginSearchButton.hidden = NO;
}

- (void)setNoCancel:(BOOL)noCancel {
    _noCancel = noCancel;
    self.cancelOrSearchButton.hidden = noCancel;
}

#pragma mark -------------------Delegate Method----------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self _beginSearch];
    return YES;
}

#pragma mark -------------------Action Method----------------------
- (IBAction)backAction:(id)sender {
    [self.searchTextField resignFirstResponder];
    emptyBlock(self.searchBackBlock)
}

- (IBAction)clearTextFieldAction:(id)sender {
    self.searchTextField.text = nil;
    self.keyWords = nil;
}

- (IBAction)cancelOrSearchAction:(id)sender {
    if (self.cancelOrSearchButton.selected) {
        [self _beginSearch];
    }else {
        [self _cancelSearch];
    }

}

@end
