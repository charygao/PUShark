//
//  ZYImageViewController.m
//  jietiwuyou
//
//  Created by zhouyi on 15/1/27.
//  Copyright (c) 2015年 创序科技. All rights reserved.
//

#import "ZYImageViewController.h"

@interface ZYImageViewController ()

@end

@implementation ZYImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.bottomType == ZYImageViewControllerBottom_viewer) {
        self.bottomContainer = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-40, CGRectGetWidth(self.view.frame), 40)];
        [self.bottomContainer setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.410]];
        [self.view addSubview:self.bottomContainer];
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [deleteBtn setImage:[UIImage imageNamed:@"icon_genra_delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(delegateImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomContainer addSubview:deleteBtn];
        [deleteBtn setCenter:CGPointMake(CGRectGetWidth(self.view.frame)/2, 20)];
    }else if (self.bottomType == ZYImageViewControllerBottom_danceer){
        self.bottomContainer = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-40, CGRectGetWidth(self.view.frame), 40)];
        [self.bottomContainer setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.410]];
        [self.view addSubview:self.bottomContainer];
    }else{
        NSLog(@"Nothing");
    }
    [self.bottomContainer setHidden:YES];
}

-(void)delegateImage:(UIButton*)btn{
    if (self.deleteBlock) {
         self.deleteBlock(self);
    }
}
- (void)deviceOrientationDidChange:(NSNotification *)notification{
    UIDeviceOrientation orientaiton = [[UIDevice currentDevice] orientation];
    
    switch (orientaiton) {
        case UIDeviceOrientationPortrait:
            [self  rotation_bottomContainer:0.0];
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            [self  rotation_bottomContainer:90.0*2];
            break;
        case UIDeviceOrientationLandscapeLeft:
            [self  rotation_bottomContainer:90.0*3];
            break;
        case UIDeviceOrientationLandscapeRight:
            [self  rotation_bottomContainer:90.0];
            break;
        default:
            break;
    }
}

-(void)rotation_bottomContainer:(float)n
{
    [self.bottomContainer setFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-40, CGRectGetWidth(self.view.frame), 40)];
    UIButton *deleteBtn = self.bottomContainer.subviews[0];
    [deleteBtn setCenter:CGPointMake(CGRectGetWidth(self.view.frame)/2, 20)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
