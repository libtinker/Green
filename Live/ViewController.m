//
//  ViewController.m
//  Live
//
//  Created by 天空吸引我 on 2019/5/30.
//  Copyright © 2019 天空吸引我. All rights reserved.
//

#import "ViewController.h"
#import <ZJJNetwork.h>

@interface ViewController ()
{
    ZJJNetwork *network;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
