//
//  TLActionSheet.m
//  jingGang
//
//  Created by thinker on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "TLActionSheet.h"
#import "Masonry.h"


static NSString * const cellIdentifier = @"Cell";

/// Used for storing button configuration.
@interface TLActionSheetItem : NSObject
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;
@property (nonatomic) TLActionSheetButtonType type;
@property (strong, nonatomic) TLActionSheetHandler handler;
@end

@implementation TLActionSheetItem
@end

@interface TLActionSheet () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UIView *lightView;
@property (nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *items;

@end

@implementation TLActionSheet

- (id)initWithTitle:(NSString *)title {
    if (self = [super init]) {

    }

    return self;
}

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLActionSheetItem *item = self.items[(NSUInteger)indexPath.row];
    if (item.type != TLActionSheetButtonTypeDisabled) {
        [self dismissAnimated:YES duration:self.animationDuration completion:item.handler];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    
    TLActionSheetItem *item = (TLActionSheetItem *)self.items[(NSUInteger)indexPath.row];

    NSDictionary *attributes = nil;
    /*switch (item.type)
    {
        case TLActionSheetButtonTypeDefault:
            attributes = self.buttonTextAttributes;
            break;
        case TLActionSheetButtonTypeDisabled:
            attributes = self.disabledButtonTextAttributes;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case TLActionSheetButtonTypeDestructive:
            attributes = self.destructiveButtonTextAttributes;
            break;
    }*/
    
    NSAttributedString *attrTitle = [[NSAttributedString alloc] initWithString:item.title attributes:attributes];
    cell.textLabel.attributedText = attrTitle;
    
    // Use image with template mode with color the same as the text (when enabled).
//    BOOL useTemplateMode = [UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)] && [self.automaticallyTintButtonImages boolValue];
//    cell.imageView.image = useTemplateMode ? [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] : item.image;
    
    if ([UIImageView instancesRespondToSelector:@selector(tintColor)]){
        cell.imageView.tintColor = attributes[NSForegroundColorAttributeName] ? attributes[NSForegroundColorAttributeName] : [UIColor blackColor];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    /*if (self.selectedBackgroundColor && ![cell.selectedBackgroundView.backgroundColor isEqual:self.selectedBackgroundColor]) {
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor = self.selectedBackgroundColor;
    }*/

//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - event response

- (void)showAnimated:(BOOL)animated duration:(NSTimeInterval)duration
{
    UIView *superView = self;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@240);
        make.bottom.equalTo(superView);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.tableView layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];

}

- (void)dismissAnimated:(BOOL)animated duration:(NSTimeInterval)duration completion:(TLActionSheetHandler)completionHandler
{
    
    // delegate isn't needed anymore because tableView will be hidden (and we don't want delegate methods to be called now)
    self.tableView.delegate = nil;
    self.tableView.userInteractionEnabled = NO;
    // keep the table from scrolling back up
    self.tableView.contentInset = UIEdgeInsetsMake(-self.tableView.contentOffset.y, 0, 0, 0);
    
    void(^tearDownView)(void) = ^(void) {
        [self dismissView];
        if (completionHandler) {
            completionHandler(self);
        }
    };
    
    if (animated) {
        // animate sliding down tableView and cancelButton.
        [UIView animateWithDuration:duration animations:^{
            
            // Shortest shift of position sufficient to hide all tableView contents below the bottom margin.
            // contentInset isn't used here (unlike in -show) because it caused weird problems with animations in some cases.
            CGFloat slideDownMinOffset = (CGFloat)fmin(CGRectGetHeight(self.frame) + self.tableView.contentOffset.y, CGRectGetHeight(self.frame));
            self.tableView.transform = CGAffineTransformMakeTranslation(0, slideDownMinOffset);
        } completion:^(BOOL finished) {
            tearDownView();
        }];
    } else {
        tearDownView();
    }
}


- (void)dismissView {
    UIView *view = self;
    if (view.superview != nil) {
        [view removeFromSuperview];
    }
}

#pragma mark - private methods

- (void)addButtonWithTitle:(NSString *)title image:(UIImage *)image type:(TLActionSheetButtonType)type handler:(TLActionSheetHandler)handler
{
    TLActionSheetItem *item = [[TLActionSheetItem alloc] init];
    item.title = title;
    item.image = image;
    item.type = type;
    item.handler = handler;
    [self.items addObject:item];
}

- (void)showInView:(UIView *)superView
{
    [superView addSubview:self];
    [self addSubview:self.lightView];
    [self addSubview:self.tableView];
    [self setViewsMASConstraint];
    [self setUIContent];
    
    [self showAnimated:YES duration:self.animationDuration];
}


- (void)setUIContent {

}

- (void)setViewsMASConstraint {
    UIView *superView = self.superview;
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView).with.insets(padding);
    }];
    superView = self;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@240);
        make.bottom.equalTo(superView).with.offset(240);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
    }];
    [self.lightView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tableView);
        make.width.equalTo(superView);
        make.centerX.equalTo(superView);
        make.top.equalTo(superView);
    }];
}

#pragma mark - getters and settters

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    
    return _items;
}

- (UIView *)lightView {
    if (_lightView == nil) {
        _lightView = [[UIView alloc] initWithFrame:CGRectZero];
        _lightView.backgroundColor = [UIColor blackColor];
        _lightView.alpha = 0.6;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        [_lightView addGestureRecognizer:tap];
    }

    return _lightView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 45.5;
        _tableView.rowHeight = 45.5;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    }
    
    return _tableView;
}


@end
