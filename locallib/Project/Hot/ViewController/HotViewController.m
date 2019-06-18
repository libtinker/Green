//
//  HotViewController.m
//  Project
//
//  Created by 天空吸引我 on 2019/6/18.
//

#import "HotViewController.h"
#import "BaseTableView.h"
#import "HotTableViewCell.h"

@interface HotViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) BaseTableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation HotViewController

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

    self.navigationItem.title = @"好友";
    [self.view addSubview:self.tableView];
}

#pragma mark - HTTP

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HotTableViewCell.class) forIndexPath:indexPath];
    return cell;
}
#pragma mark - Public

#pragma mark - Private

#pragma mark - Setter

#pragma mark - Getter
- (UITableView *)tableView {
    if(!_tableView){
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = [UIScreen mainScreen].bounds.size.width*9/16+60;
        [_tableView registerClass:[HotTableViewCell class] forCellReuseIdentifier:NSStringFromClass(HotTableViewCell.class)];
        [_tableView headerWithRefreshingBlock:^{
        }];
    }
    return _tableView;
}
@end
