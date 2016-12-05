//
//  PUSharkWeb.m
//  PUShark
//
//  Created by zhouyi on 2016/12/5.
//  Copyright © 2016年 zhouyi. All rights reserved.
//

#import "UIWebView+PUSharkWeb.h"

@implementation UIWebView(PUSharkWeb)

- (CGFloat)getOffsetTopWithPoint:(CGPoint)pt{
    NSString * getTopStr =[NSString stringWithFormat:
                        @"var script = document.createElement('script');"
                        "script.type = 'text/javascript';"
                        "script.text = \"function getAbsTop(e){"
                        "var offsetTop=e.offsetTop;"
                        "if(e.offsetParent!=null){"
                        "offsetTop+=getAbsTop(e.offsetParent);"
                        "}"
                        "return offsetTop;"
                        "};"
                        "function getTop(){"
                        "var ele = document.elementFromPoint(%f,%f);"
                        "return getAbsTop(ele);"
                        "}\";"
                        "document.getElementsByTagName('head')[0].appendChild(script);",pt.x,pt.y];
    [self stringByEvaluatingJavaScriptFromString:getTopStr];
    NSString *jsString = [self stringByEvaluatingJavaScriptFromString:@"getTop()"];
    return [jsString floatValue];
}

- (CGFloat)getOffsetLeftWithPoint:(CGPoint)pt{
    NSString * getLeftStr =[NSString stringWithFormat:
                        @"var script = document.createElement('script');"
                        "script.type = 'text/javascript';"
                        "script.text = \"function getAbsLeft(e){"
                        "var offsetLeft = e.offsetLeft;"
                        "if(e.offsetParent!=null){"
                        "offsetLeft += getAbsLeft(e.offsetParent);"
                        "}"
                        "return offsetLeft;"
                        "};"
                        "function getLeft(){"
                        "var ele = document.elementFromPoint(%f,%f);"
                        "return getAbsLeft(ele);"
                        "}\";"
                        "document.getElementsByTagName('head')[0].appendChild(script);",pt.x,pt.y];
    [self stringByEvaluatingJavaScriptFromString:getLeftStr];
    NSString *jsString = [self stringByEvaluatingJavaScriptFromString:@"getLeft()"];
    return [jsString floatValue];
}

- (CGFloat)getElementWidthWithPoint:(CGPoint)pt{
    NSString *jsString = [NSString stringWithFormat:@"document.elementFromPoint(%f,%f).offsetWidth",pt.x,pt.y];
    return [[self stringByEvaluatingJavaScriptFromString:jsString] floatValue];
}
- (CGFloat)getElementHeightWithPoint:(CGPoint)pt{
    NSString *jsString = [NSString stringWithFormat:@"document.elementFromPoint(%f,%f).offsetHeight",pt.x,pt.y];
    return [[self stringByEvaluatingJavaScriptFromString:jsString] floatValue];
}
- (CGFloat)getWindowPageXOffset{
    return [[self stringByEvaluatingJavaScriptFromString:@"window.pageXOffset"] floatValue];
}
- (CGFloat)getWindowPageYOffset{
     return [[self stringByEvaluatingJavaScriptFromString:@"window.pageYOffset"] floatValue];
}
- (CGRect)imgFrameWithPoint:(CGPoint)pt{
    CGFloat pageXoffset = [self getWindowPageXOffset];
    CGFloat pageYoffet = [self getWindowPageYOffset];
    CGFloat elementOffsetLeft = [self getOffsetLeftWithPoint:pt];
    CGFloat elemnrtOffsetTop = [self getOffsetTopWithPoint:pt];
    CGFloat elementWidth = [self getElementWidthWithPoint:pt];
    CGFloat elementHeight = [self getElementHeightWithPoint:pt];
    return CGRectMake(elementOffsetLeft - pageXoffset, elemnrtOffsetTop - pageYoffet, elementWidth, elementHeight);
}
- (NSString*)elementImgUrlWithPoint:(CGPoint)pt{
    NSString *jsString = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];
    NSString *imgUrl = [self stringByEvaluatingJavaScriptFromString:jsString];
    NSString *fileType = [[imgUrl componentsSeparatedByString:@"."] lastObject];
    if ([fileType isEqualToString:@"png"] || [fileType isEqualToString:@"jpg"]) {
        if (imgUrl.length > 0) {
            return imgUrl;
        }
    }
    return nil;
}

@end
