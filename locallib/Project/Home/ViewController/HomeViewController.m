//
//  HomeViewController.m
//  Green
//
//  Created by 天空吸引我 on 2019/5/31.
//  Copyright © 2019 天空吸引我. All rights reserved.
//

#import "HomeViewController.h"
#import "ZJJNetwork.h"
#import "ZJJCarouselView.h"

@interface HomeViewController ()
{
    NSMutableArray *_dataArray;
}
@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ZJJCarouselView *carouselView;

@end

@implementation HomeViewController

#pragma mark - LifeCycle

- (instancetype)init {
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.leftLabel];
    self.navigationItem.leftBarButtonItem = item ;

    [_dataArray addObject:@"1"];
    [_dataArray addObject:@"1"];
    [_dataArray addObject:@"1"];
    [_dataArray addObject:@"1"];

    [self.view addSubview:self.tableView];
    [self testZJJCarouselView];
    [self request];
}


- (void)request {
    NSDictionary *pram = @{
                           @"username":@"110122222",
                           @"passwold":@"q111111"
                           };
    [ZJJNetwork POST:@"login" parameters:pram success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError * _Nullable error, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    }];
}

- (void)testZJJCarouselView {

    NSArray *imageUrls = @[
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525355773455&di=f396b05e29ab5f0e254ac8b748e0a927&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201502%2F13%2F20150213175601_GxesK.thumb.700_0.jpeg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525355773455&di=65b970d6cb5302a7cc3c20892133129b&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201605%2F19%2F20160519232035_zcSmh.jpeg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525355773454&di=7adeec6a3ee9ee3dae9ac69ff46f4648&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201608%2F01%2F20160801205410_vCTKn.thumb.700_0.jpeg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525355773453&di=c4d3bf6254515b07d6cf0669993a645f&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201508%2F22%2F20150822120345_r3vBk.jpeg"
                           ];

    _carouselView.imageUrls = imageUrls;
}

#pragma mark - HTTP

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIEdgeInsets UIEgde = UIEdgeInsetsMake(0, 16, 0, 16);
    [cell setSeparatorInset:UIEgde];
}
#pragma mark - Public

#pragma mark - Private

#pragma mark - Setter

#pragma mark - Getter

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 88, 44)];
        _leftLabel.text = @"绿色";
        _leftLabel.textColor = [UIColor whiteColor];
        _leftLabel.font = [UIFont boldSystemFontOfSize:24];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _leftLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.carouselView;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}

- (ZJJCarouselView *)carouselView {
    if (!_carouselView) {
        _carouselView = [[ZJJCarouselView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) imageUrls:@[] didSelectBlock:^(NSInteger index) {

        }];
    }
    return _carouselView;
}
@end
