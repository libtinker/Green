//
//  MineViewController.m
//  Green
//
//  Created by 天空吸引我 on 2019/5/31.
//  Copyright © 2019 天空吸引我. All rights reserved.
//

#import "MineViewController.h"
#import "ZJJPhotoAlbumViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    // Do any additional setup after loading the view.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ZJJPhotoAlbumViewController *ctrl = [[ZJJPhotoAlbumViewController alloc] init];
    [self presentViewController:ctrl animated:YES completion:nil];
}
#pragma mark - HTTP

#pragma mark - Delegate


#pragma mark - Public

#pragma mark - Private

#pragma mark - Setter

#pragma mark - Getter

@end
