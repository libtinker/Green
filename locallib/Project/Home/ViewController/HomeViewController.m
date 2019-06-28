//
//  HomeViewController.m
//  Green
//
//  Created by 天空吸引我 on 2019/5/31.
//  Copyright © 2019 天空吸引我. All rights reserved.
//


#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "ZJJNetwork.h"
#import "BaseTableView.h"
#import "JJAlertController.h"
#import "RouterManager.h"
#import "LocalNotification.h"
#import "ConstantConfig.h"
#import "ZJJPhotoAlbumViewController.h"


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,HomeTableViewCellDelegate>
{
    NSMutableArray *_dataArray;
    NSIndexPath *_beforeIndexPath;
    HomeTableViewCell *_beforeCell;
}
@property (nonatomic,strong) BaseTableView *tableView;
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
    self.view.layer.contents = (id)[UIImage imageNamed:@"img_video_loading"].CGImage;
    self.navigationItem.title = @"推荐";
    [self.view addSubview:self.tableView];

    [self requestRecommend];
    [LocalNotification addObserverForName:UserDidLoginNotification UsingBlock:^(NSNotification * _Nonnull note) {

    }];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.backgroundColor = [UIColor clearColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [_beforeCell pause];
}

#pragma mark - HTTP

- (void)requestRecommend {
    [ZJJNetwork POST:@"recommend" parameters:nil success:^(id  _Nullable responseObject) {
        NSArray *dataArray = responseObject[@"data"];
        if (dataArray&&dataArray.count>0) {
            [_dataArray removeAllObjects];
            [_dataArray addObjectsFromArray:dataArray];
            [self.tableView reloadData];

            _beforeIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            _beforeCell = [_tableView cellForRowAtIndexPath:_beforeIndexPath];
            NSDictionary *dict = _dataArray[0];
            [_beforeCell setData:dict];
        }
        [self.tableView endRefreshing];
    } failure:^(NSError * _Nullable error, id  _Nullable responseObject) {
        [self.tableView endRefreshing];
    }];
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HomeTableViewCell.class) forIndexPath:indexPath];
    cell.delegate = self;

    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
    NSIndexPath *indexPath = [self getIndexPathWithScrollView:scrollView];
    if (indexPath.row!=_beforeIndexPath.row) {
        [_beforeCell pause];

        HomeTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        NSDictionary *dict = _dataArray[indexPath.row];
        [cell setData:dict];

        _beforeIndexPath = indexPath;
        _beforeCell = cell;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;// 返回YES表示隐藏，返回NO表示显示
}

// 分享
- (void)share:(NSString *)vedioPath {
    WS(weakSelf)
    [ZJJNetwork download:vedioPath progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(id  _Nullable responseObject) {
        NSURL *url = responseObject;
        [weakSelf savePhoto:url];
    } failure:^(NSError * _Nullable error, id  _Nullable responseObject) {

    }];
}

- (void)praise {
    ZJJPhotoAlbumViewController *ctrl = [[ZJJPhotoAlbumViewController alloc] init];
    [self presentViewController:ctrl animated:YES completion:nil];
}

#pragma mark - Public

#pragma mark - Private

- (void)savePhoto:(NSURL *)url {
    NSURL *openUrl = [NSURL URLWithString:[@"Green://photo/save?data=" stringByAppendingString:url.path]];
    [[UIApplication sharedApplication] openURL:openUrl options:nil completionHandler:^(BOOL success) {

    }];
}

- (NSIndexPath *)getIndexPathWithScrollView:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.y/self.tableView.frame.size.height;
    return [NSIndexPath indexPathForRow:page inSection:0];
}
#pragma mark - Setter

#pragma mark - Getter

- (UITableView *)tableView {
    if(!_tableView){
        _tableView = [[BaseTableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.rowHeight = self.view.frame.size.height;
        [_tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:NSStringFromClass(HomeTableViewCell.class)];
        _tableView.pagingEnabled = YES;
        [_tableView headerWithRefreshingBlock:^{
            [self requestRecommend];
        }];
    }
    return _tableView;
}
@end
