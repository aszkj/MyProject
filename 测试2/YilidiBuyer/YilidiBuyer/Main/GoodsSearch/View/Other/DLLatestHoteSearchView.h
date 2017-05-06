//
//  DLLatestHoteSearchView.h
//  YilidiBuyer
//
//  Created by yld on 16/5/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LatestHoteSearchSelectKeyWordsBlock)(NSString *selectKeywords);

@interface DLLatestHoteSearchView : UIView

@property (nonatomic,copy)LatestHoteSearchSelectKeyWordsBlock latestHoteSearchSelectKeyWordsBlock;

@property (nonatomic,assign)BOOL show;


@end
