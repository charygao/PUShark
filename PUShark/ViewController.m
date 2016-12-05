//
//  ViewController.m
//  PUShark
//
//  Created by zhouyi on 2016/11/27.
//  Copyright (c) 2016 zhouyi. All rights reserved.
//

#import "ViewController.h"
#import "NewsDetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnClick:(id)sender {
    NewsDetailViewController *a = [[NewsDetailViewController alloc]init];
    a.url = @"https://nianxi.net/ios/ios-crash-reporter.html";
    [self presentViewController:a animated:YES completion:nil];
}
@end
