//
//  MerchantPosterTableView.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/11/7.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "BaseTabbarTypeTableView.h"


@interface MerchantPosterTableView : BaseTabbarTypeTableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign)PosterType posterType;

@end
