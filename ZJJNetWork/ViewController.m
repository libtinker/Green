//
//  ViewController.m
//  ZJJNetWork
//
//  Created by ZJJ on 2017/12/16.
//  Copyright © 2017年 ZJJ. All rights reserved.
//

#import "ViewController.h"
#import "UserHandler.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *pram = @{
                           @"username":@"131*******",
                           @"passwold":@"q111111"
                           };
    [UserHandler requestLoginWithParam:pram withSuccess:^(id obj) {
        
    } failed:^(id obj) {
        
    }];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
