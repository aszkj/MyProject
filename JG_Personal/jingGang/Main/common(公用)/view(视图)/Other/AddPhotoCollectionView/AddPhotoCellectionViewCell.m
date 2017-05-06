//
//  AddPhotoCellectionViewCell.m
//  jingGang
//
//  Created by 张康健 on 15/9/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "AddPhotoCellectionViewCell.h"

@implementation AddPhotoCellectionViewCell

- (void)awakeFromNib {
    
}

-(void)layoutSubviews {
    [super layoutSubviews];

#pragma warn - 注意这个方法，在表调用reload之后，每个cell是不会在调用这个方法的，因为这个方法一般是cell创建完返回，或手动调用setNeedsDisplay才会调这个方法，因为表在调用reload之前每个cell早就创建好了，，所以表再调用reload这个方法根本不会调用，所以在这个方法里面给数据源赋值要注意，，
#pragma warn - 如果是在cell内部有很多操作可经常更改该cell的数据源，那么那么可以放在这个方法里面赋值，每次cell内部数据源更改，就调用setNeedsDisplay,像上次的宝贝评价页等，，
#pragma warn - 如果是是外部表需要经常刷新,reload,外部可能cell经常需要增删等，那么尽量不要再这个方法里赋值数据源，在下面的给模型赋值的里面赋值数据源就行
//    NSLog(@"img %@",self.photoImgView.image);
    
}

-(void)setPhotoDataModel:(PhotoDataModel *)photoDataModel {
    _photoDataModel = photoDataModel;
    self.photoImgView.image = _photoDataModel.photoImg;

}


@end
