//
//  H5page_URL.h
//  jingGang
//
//  Created by 张康健 on 15/6/16.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "GlobeObject.h"


#ifndef jingGang_H5page_URL_h
#define jingGang_H5page_URL_h
#pragma mark - 面部，人体模型







//面部模型
#define Face_Man_H5  [NSString stringWithFormat:@"%@/static/app/face.jsp",StaticBase_Url]
#define Face_Women_H5  [NSString stringWithFormat:@"%@/static/app/faceLady.jsp",StaticBase_Url]

//症状模型
#define Body_Man_H5  [NSString stringWithFormat:@"%@/static/app/bodily.jsp",StaticBase_Url]
#define Body_Women_H5  [NSString stringWithFormat:@"%@/static/app/bodilyLady.jsp",StaticBase_Url]

//形体模型
#define Figure_Man_H5  [NSString stringWithFormat:@"%@/static/app/form.jsp",StaticBase_Url]
#define Figure_Women_H5  [NSString stringWithFormat:@"%@/static/app/formLady.jsp",StaticBase_Url]

//关于云e生
#define AboutYunESheng  [NSString stringWithFormat:@"%@/static/app/about.jsp",StaticBase_Url]

//问答详情url
#define kConsultDetailWebUrlWithID(consulID)  [NSString stringWithFormat:@"%@%@%@",Base_URL,@"/consulting/my_consulting?id=",consulID]


#endif
