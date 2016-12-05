//
//  PUSharkWeb.h
//  PUShark
//
//  Created by zhouyi on 2016/12/5.
//  Copyright © 2016年 zhouyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView(PUSharkWeb)

/**
 返回webView内坐标点对应的html元素相对于当前屏幕的位置

 @param pt touch点
 @return 元素的frame
 */
- (CGRect)imgFrameWithPoint:(CGPoint)pt;

/**
 设置或返回当前页面相对于窗口显示区左上角的 X 位置

 @return X 位置
 */
- (CGFloat)getWindowPageXOffset;

/**
 设置或返回当前页面相对于窗口显示区左上角的 Y 位置

 @return Y 位置
 */
- (CGFloat)getWindowPageYOffset;

/**
  返回webView内坐标点对应的html元素的相对垂直偏移位置

 @param pt touch点
 @return 相对垂直偏移位置
 */
- (CGFloat)getOffsetTopWithPoint:(CGPoint)pt;

/**
 返回webView内坐标点对应的html元素的相对水平偏移位置

 @param pt touch点
 @return 相对水平偏移位置
 */
- (CGFloat)getOffsetLeftWithPoint:(CGPoint)pt;

/**
 返回webView内坐标点对应的html元素的宽度

 @param pt touch点
 @return 元素的宽度
 */
- (CGFloat)getElementWidthWithPoint:(CGPoint)pt;

/**
 返回webView内坐标点对应的html元素的宽度

 @param pt touch点
 @return 元素的高度
 */
- (CGFloat)getElementHeightWithPoint:(CGPoint)pt;

/**
 返回webView内点击的图片的URL

 @param pt touch点
 @return 图片的URL
 */
- (NSString*)elementImgUrlWithPoint:(CGPoint)pt;


@end
