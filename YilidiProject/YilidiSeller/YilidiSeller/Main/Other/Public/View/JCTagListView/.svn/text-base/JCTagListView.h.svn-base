//
//  JCTagListView.h
//  JCTagListView
//
//  Created by 李京城 on 15/7/3.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^JCTagListViewBlock)(NSInteger index,NSArray *selectedTags,NSArray *tags);

@interface JCTagListView : UIView

@property (nonatomic, strong) UIColor *tagStrokeColor;// default: lightGrayColor
@property (nonatomic, strong) UIColor *tagTextColor;// default: darkGrayColor
@property (nonatomic, strong) UIColor *tagBackgroundColor;// default: clearColor
@property (nonatomic, strong) UIColor *tagSelectedBackgroundColor;// default: rgb(217,217,217)
@property (nonatomic, strong) UIColor *tagSelectedTextColor;// default: rgb(217,217,217)
@property (nonatomic, strong) UIFont *tagTextFont;// default: darkGrayColor

@property (nonatomic,assign)CGFloat itemHeight;

@property (nonatomic,assign)CGFloat minuHorizonalSpace;
@property (nonatomic,assign)CGFloat minuVerticalSpace;
@property (nonatomic,assign)UIEdgeInsets contentSectionInset;


@property (nonatomic, assign) CGFloat tagCornerRadius;// default: 10
@property (nonatomic, assign) BOOL canSelectTags;// default: NO

@property (nonatomic, assign) BOOL canSelectMutialTags;// default: YES use with canCancelSelectedTag normaly
@property (nonatomic, assign) BOOL canCancelSelectedTag;//when one selected,click it cancel selected default: YES
@property (nonatomic,assign)CGFloat contentHeight;//total content height

@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong, readonly) NSMutableArray *selectedTags;

@property (nonatomic, strong) UICollectionView *collectionView;

- (void)reloadData;

- (void)setCompletionBlockWithSelected:(JCTagListViewBlock)completionBlock;

@end
