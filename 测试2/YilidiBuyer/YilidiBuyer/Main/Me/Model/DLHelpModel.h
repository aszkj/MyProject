//
//  DLHelpModel.h
//  YilidiBuyer
//
//  Created by yld on 16/5/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLHelpModel : BaseModel
@property (nonatomic,strong)NSString *content;
@property (nonatomic,assign)CGFloat cellHeight;

-(instancetype)initWithcontent:(NSString *)content;
@end
