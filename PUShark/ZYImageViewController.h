//
//  ZYImageViewController.h
//  jietiwuyou
//
//  Created by zhouyi on 15/1/27.
//  Copyright (c) 2015年 创序科技. All rights reserved.
//

#import "JTSImageViewController.h"

typedef NS_ENUM(NSInteger, ZYImageViewControllerBottom) {
    ZYImageViewControllerBottom_none,//直接隐藏
    ZYImageViewControllerBottom_viewer,//不带删除
    ZYImageViewControllerBottom_danceer,//带删除
};




@interface ZYImageViewController : JTSImageViewController

typedef void (^JTSImageViewControllerDeleteBlock)(ZYImageViewController* obj);

@property (nonatomic, copy) JTSImageViewControllerDeleteBlock deleteBlock;
@property (assign, nonatomic) ZYImageViewControllerBottom bottomType;

@property(strong,nonatomic) UIView *bottomContainer;

@end


