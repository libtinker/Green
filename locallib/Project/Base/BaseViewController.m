//
//  BaseViewController.m
//  Green
//
//  Created by 天空吸引我 on 2019/5/31.
//  Copyright © 2019 天空吸引我. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)setLeftBarButtonItemWithTitle:(NSString *)title action:(nullable SEL)action {
    self.navigationItem.leftBarButtonItem =   [[UIBarButtonItem alloc] initWithTitle:title style:UIBarStyleBlack target:self action:action];
}

- (void)setRightBarButtonItemWithTitle:(NSString *)title action:(nullable SEL)action {
     self.navigationItem.rightBarButtonItem =   [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:action];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
