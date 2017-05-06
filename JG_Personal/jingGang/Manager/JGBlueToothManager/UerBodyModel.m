//
//  UerBodyModel.m
//  WKLBle
//
//  Created by 张康健 on 15/6/9.
//  Copyright (c) 2015年 baoyx. All rights reserved.
//

#import "UerBodyModel.h"




@implementation UerBodyModel

-(id)init{

    self = [super init];
    if (self) {
        //初始化默认设置
        self.goalSteps = 7000;
        
        NSNumber *goalStep = [[NSUserDefaults standardUserDefaults] objectForKey:kGoalStep] ;
        if (!goalStep) {
            self.goalSteps = 7000;
        }else{
            self.goalSteps = [goalStep integerValue];
        }
        
        
        
        self.goalSleepMinute = 480;
        self.genderType = GenderTypeMan;
        self.age = 23;
        self.height = 169;
        self.weight = 108;
    }

    return self;
}


-(void)setAllValueWithGoalSteps:(NSInteger)goalSteps
                     genderType:(GenderType)genderType
                            age:(NSInteger)age
                         height:(NSInteger)height
                         weight:(NSInteger)weight
{

    self.goalSteps = goalSteps;
    self.genderType = genderType;
    self.age = age;
    self.height = height;
    self.weight = weight;

}



@end
