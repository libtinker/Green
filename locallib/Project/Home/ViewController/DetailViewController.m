//
//  ViewController.m
//  AVPlayer
//
//  Created by 天空吸引我 on 2019/4/14.
//  Copyright © 2019 天空吸引我. All rights reserved.
//

#import "DetailViewController.h"
#import "VideoView.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    VideoView *view = [[VideoView alloc] initWithFrame:self.view.frame urlString:self.url];
    [self.view addSubview:view];
}
@end
