//
//  HomeViewController.m
//  Green
//
//  Created by 天空吸引我 on 2019/5/31.
//  Copyright © 2019 天空吸引我. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailViewController.h"
#import "ZJJNetwork.h"
#import "JJCarouselView.h"

@interface HomeViewController ()
{
    NSMutableArray *_dataArray;
    NSMutableArray *_imgArray;
    NSArray *_carouselArray;
}
@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) JJCarouselView *carouselView;

@end

@implementation HomeViewController

#pragma mark - LifeCycle

- (instancetype)init {
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc] init];
        _imgArray = [[NSMutableArray alloc] init];
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
    [self requestRecommend];
}

#pragma mark - HTTP
- (void)requestRecommend {
    NSDictionary *pram = @{
                           @"username":@"110122222",
                           @"passwold":@"q111111"
                           };
    __weak NSMutableArray *imgCarouseArr = _imgArray;
    [ZJJNetwork POST:@"recommend" parameters:pram success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *arr = responseObject[@"data"];
        _carouselArray = arr;
        for (int i=0; i<arr.count; i++) {
            NSDictionary *dict = arr[i];
            [imgCarouseArr addObject:dict[@"img_url"]];
        }
        self.carouselView.imageUrls = (NSArray *)imgCarouseArr;
    } failure:^(NSError * _Nullable error, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    }];
}

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

- (JJCarouselView *)carouselView {
    if (!_carouselView) {
        _carouselView = [[JJCarouselView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) imageUrls:@[] imgClicked:^(NSInteger index) {
            DetailViewController *ctrl = [[DetailViewController alloc] init];
            NSDictionary *dict = _carouselArray[index];
            ctrl.url = dict[@"url"];
            [self presentViewController:ctrl animated:NO completion:nil];
        }];
    }
    return _carouselView;
}
@end
