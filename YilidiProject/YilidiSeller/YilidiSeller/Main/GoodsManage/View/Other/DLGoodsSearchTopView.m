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
#import "Util.h"
#import "UIButton+Design.h"
#import <Masonry/Masonry.h>
#import "ProjectStandardUIDefineConst.h"

@interface DLGoodsSearchTopView()<UITextFieldDelegate>
@property (nonatomic, copy)NSString *keyWords;

@property (weak, nonatomic) IBOutlet UIView *searchBgView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *clearTextFieldButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrSearchButton;

@property (nonatomic, strong)UIButton *clickToBeginSearchButton;
@property (nonatomic, strong)UIButton *recipeCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end


@implementation DLGoodsSearchTopView

- (void)awakeFromNib {
    [self _init];
    [self.backButton setEnlargeEdgeWithTop:8 right:8 bottom:8 left:15];
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
    [self.searchTextField setTextPlaceHolderFont:kSystemFontSize(14.0f) placeHolderTextColor:UIColorFromRGB(0xCED0D0)];
    self.searchType = SearchType_Goods;
}

#pragma mark -------------------Private Method----------------------
- (void)_beginSearch {
    if (![self _emptyWordsSolve]) {
        return;
    }
    emptyBlock(self.beginSearchBlock,self.keyWords);
    [self.searchTextField resignFirstResponder];
}

- (BOOL)_emptyWordsSolve {
    
    if (isEmpty(self.keyWords)) {
        NSString *alertTitle = nil;
        if (self.searchType == SearchType_Goods) {
            alertTitle = @"请输入商品关键字";
        }else if (self.searchType == SearchType_Order){
            alertTitle = @"请输入订单关键字";
        }
        [Util ShowAlertWithOnlyMessage:alertTitle];
        return NO;
    }
    
    return YES;
    
}

- (void)_cancelSearch {
    emptyBlock(self.cancelSearchBlock);
    [self.searchTextField resignFirstResponder];
}

- (void)_configureUIBySearchType {
    NSString *textPlaceHolder = nil;
    if (self.searchType == SearchType_Goods) {
        textPlaceHolder = @"请输入商品名称";
    }else if (self.searchType == SearchType_Order) {
        textPlaceHolder = @"请输入订单手机号";
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
        [self addSubview:_clickToBeginSearchButton];
        [_clickToBeginSearchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.searchBgView);
        }];
        NSString *title = self.searchType == SearchType_Goods ? @"请输入商品名称" : @"请输入订单手机号";
        [_clickToBeginSearchButton setTitle:title forState:UIControlStateNormal];
        [_clickToBeginSearchButton setImage:IMAGE(@"搜索slight") forState:UIControlStateNormal];
        [_clickToBeginSearchButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [_clickToBeginSearchButton setTitleColor:KTextColor forState:UIControlStateNormal];
        [_clickToBeginSearchButton setBackgroundColor:KViewBgColor];
        _clickToBeginSearchButton.layer.cornerRadius = 15.0f;
        _clickToBeginSearchButton.layer.masksToBounds = YES;
        _clickToBeginSearchButton.titleLabel.font = kSystemFontSize(14.0f);
        WEAK_SELF
        [_clickToBeginSearchButton addActionHandler:^(NSInteger tag) {
            emptyBlock(weak_self.clickToBeginSearchBlock);
        }];
    }
    return _clickToBeginSearchButton;
}

- (UIButton *)recipeCodeButton {
    
    if (!_recipeCodeButton) {
        _recipeCodeButton = [UIButton new];
        [self addSubview:_recipeCodeButton];
        [_recipeCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(35, 28));
            make.right.mas_equalTo(-7);
            make.centerY.mas_equalTo(self);
        }];
        [_recipeCodeButton setBackgroundImage:IMAGE(@"recipeCode") forState:UIControlStateNormal];
        WEAK_SELF
        [_recipeCodeButton addActionHandler:^(NSInteger tag) {
            emptyBlock(weak_self.displayRecipeCodeBlock);
        }];
    }
    return _recipeCodeButton;

}


- (void)setClickToBeginSearchBlock:(ClickToBeginSearchBlock)clickToBeginSearchBlock {
    _clickToBeginSearchBlock = clickToBeginSearchBlock;
    self.clickToBeginSearchButton.hidden = NO;
    self.searchBgView.hidden = YES;
}

- (void)setDisplayRecipeCodeBlock:(DisplayRecipeCodeBlock)displayRecipeCodeBlock {
    _displayRecipeCodeBlock = displayRecipeCodeBlock;
    self.noCancel = YES;
    self.recipeCodeButton.hidden = NO;
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
    emptyBlock(self.searchBackBlock)
    [self.searchTextField resignFirstResponder];
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
