//
//  PopoverListView.h
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import <UIKit/UIKit.h>
@class PopoverListView;

@protocol PopoverListViewDataSource <NSObject>
@required

- (UITableViewCell *)popoverListView:(PopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)popoverListView:(PopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section;

@end

@protocol PopoverListViewDelegate <NSObject>
@optional

- (void)popoverListView:(PopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath;

- (void)popoverListViewCancel:(PopoverListView *)popoverListView;

- (CGFloat)popoverListView:(PopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PopoverListView : UIView<UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_listView;
    UIControl *_overlayView;
    UIButton *_cancelBtn;
}

@property (nonatomic, weak) id<PopoverListViewDataSource> datasource;
@property (nonatomic, weak) id<PopoverListViewDelegate>   delegate;
@property (nonatomic, strong) UITableView *listView;

- (void)show;
- (void)dismiss;

@end
