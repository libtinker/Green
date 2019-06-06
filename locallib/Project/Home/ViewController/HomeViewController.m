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

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArray;
    NSIndexPath *_beforeIndexPath;
    HomeTableViewCell *_beforeCell;
}
@property (nonatomic,strong) UITableView *tableView;
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
    self.navigationItem.title = @"推荐";
    [self.view addSubview:self.tableView];

    [self requestRecommend];
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
            [_dataArray addObjectsFromArray:dataArray];
            [self.tableView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                _beforeIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                _beforeCell = [_tableView cellForRowAtIndexPath:_beforeIndexPath];
                NSDictionary *dict = _dataArray[0];
                 [_beforeCell setData:dict];
            });
        }
    } failure:^(NSError * _Nullable error, id  _Nullable responseObject) {

    }];
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HomeTableViewCell.class) forIndexPath:indexPath];
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

#pragma mark - Public

#pragma mark - Private

- (NSIndexPath *)getIndexPathWithScrollView:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.y/self.tableView.frame.size.height;
    NSLog(@"%d",page);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:page inSection:0];
    return indexPath;
}
#pragma mark - Setter

#pragma mark - Getter

- (UITableView *)tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = self.view.frame.size.height;
        [_tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:NSStringFromClass(HomeTableViewCell.class)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.pagingEnabled = YES;
    }
    return _tableView;
}
@end
