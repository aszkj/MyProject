        //
//  IntegralGoodsPhotoTextDetailView.m
//  jingGang
//
//  Created by 张康健 on 15/11/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "GoodsPhotoTextDetailView.h"
#define kIntegralDetailViewTriggleDistance 50


@interface GoodsPhotoTextDetailView()<UIScrollViewDelegate,UIWebViewDelegate> {

}

//图文详情web
@property (weak, nonatomic) IBOutlet UIWebView *ptPhotoDetailWeb;


@end

@implementation GoodsPhotoTextDetailView


-(void)awakeFromNib{
    [super awakeFromNib];
    self.ptPhotoDetailWeb.delegate = self;
    [self _initInfo];
}

-(void)_initInfo{
    //不能在这里面初始化topBar属性，

    //设置父视图代理
    self.ptPhotoDetailWeb.scrollView.delegate = self;
    self.ptPhotoDetailWeb.scalesPageToFit = YES;
    for (UIView *_aView in [self.ptPhotoDetailWeb subviews])
    {
        if ([_aView isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO];
            //右侧的滚动条
            
            [(UIScrollView *)_aView setShowsHorizontalScrollIndicator:NO];
            //下侧的滚动条
            
            for (UIView *_inScrollview in _aView.subviews)
            {
                if ([_inScrollview isKindOfClass:[UIImageView class]])
                {
                    _inScrollview.hidden = YES;  //上下滚动出边界时的黑色的图片
                }
            }
        }
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    2、都有效果
//    NSString *js=@"var script = document.createElement('script');"
//    "script.type = 'text/javascript';"
//    "script.text = \"function ResizeImages() { "
//    "var myimg,oldwidth;"
//    "var maxwidth = %f;"
//    "for(i=0;i <document.images.length;i++){"
//    "myimg = document.images[i];"
//    "if(myimg.width > maxwidth){"
//    "oldwidth = myimg.width;"
//    "myimg.width = %f;"
//    "}"
//    "}"
//    "}\";"
//    "document.getElementsByTagName('head')[0].appendChild(script);";
//    js=[NSString stringWithFormat:js,355,355];
//    [webView stringByEvaluatingJavaScriptFromString:js];
//    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
//
//    NSString *js = @"function imgAutoFit() { \
//    var imgs = document.getElementsByTagName('img'); \
//    for (var i = 0; i < imgs.length; ++i) {\
//    var img = imgs[i];   \
//    img.style.maxWidth = %f;   \
//    } \
//    }";
//    js = [NSString stringWithFormat:js, 750];
//    [webView stringByEvaluatingJavaScriptFromString:js];
//    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
}

#pragma mark - layout subviews
-(void)layoutSubviews{
    [super layoutSubviews];
}


#pragma mark - web ScrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y < -kIntegralDetailViewTriggleDistance) {
        if (self.upBlock) {
            self.upBlock();
        }
    }
}

- (NSString *)_gotPackagedHtmlStrWithOriginalHtmlStr:(NSString *)orignalHtmlStr{
    return [NSString stringWithFormat:@"<html> \n"
            "<head> \n"
            "<style type=\"text/css\"> \n"
            "body {font-size:15px;}\n"
            "</style> \n"
            "</head> \n"
            "<body>"
            "<script type='text/javascript'>"
            "window.onload = function(){\n"
            "var $img = document.getElementsByTagName('img');\n"
            "for(var p in  $img){\n"
            " $img[p].style.width = '100%%';\n"
            "$img[p].style.height ='auto'\n"
            "}\n"
            "}"
            "</script>%@"
            "</body>"
            "</html>",orignalHtmlStr];
}

#pragma mark - setter Method
-(void)setPtPhotoDetailWebUrlStr:(NSString *)ptPhotoDetailWebUrlStr{
    
    [_ptPhotoDetailWeb loadHTMLString:[self _gotPackagedHtmlStrWithOriginalHtmlStr:ptPhotoDetailWebUrlStr] baseURL:nil];
    _ptPhotoDetailWebUrlStr = ptPhotoDetailWebUrlStr;
}


@end






