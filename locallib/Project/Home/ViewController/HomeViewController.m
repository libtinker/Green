//
//  HomeViewController.m
//  Green
//
//  Created by 天空吸引我 on 2019/5/31.
//  Copyright © 2019 天空吸引我. All rights reserved.
//


#import "HomeViewController.h"
#import "HomeTableViewCell.h"

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
        //测试
        NSString * urlString1 = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
        NSString * urlString2 = [[NSBundle mainBundle] pathForResource:@"test2" ofType:@"mp4"];
        _dataArray = [[NSMutableArray alloc] init];
        [_dataArray addObject:urlString1];
        [_dataArray addObject:urlString2];
        [_dataArray addObject:urlString1];
        [_dataArray addObject:urlString2];
        [_dataArray addObject:urlString1];
        [_dataArray addObject:urlString2];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐";
    [self.view addSubview:self.tableView];
    dispatch_async(dispatch_get_main_queue(), ^{
        _beforeIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        _beforeCell = [_tableView cellForRowAtIndexPath:_beforeIndexPath];
        [_beforeCell playUrlString:_dataArray[0]];
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [_beforeCell pause];
}

#pragma mark - HTTP


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
        [cell playUrlString:_dataArray[indexPath.row]];

        _beforeIndexPath = indexPath;
        _beforeCell = cell;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging");
    _beforeIndexPath = [self getIndexPathWithScrollView:scrollView];
    _beforeCell = [_tableView cellForRowAtIndexPath:_beforeIndexPath];
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
