//
//  ViewController.m
//  ZJJNetWork
//
//  Created by ZJJ on 2017/12/16.
//  Copyright © 2017年 ZJJ. All rights reserved.
//

#import "ViewController.h"
#import "ZJJNetwork.h"

@interface ViewController ()
{
    ZJJNetwork *network;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    network = [[ZJJNetwork alloc] init];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSDictionary *pram = @{
                           @"username":@"110122222",
                           @"passwold":@"q111111"
                           };
    [network POST:@"login" parameters:pram success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError * _Nullable error, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
