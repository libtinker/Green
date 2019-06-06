//
//  BaseTableView.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/6.
//

#import "BaseTableView.h"
#import "JJHeader.h"
#import "JJFooter.h"

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)headerWithRefreshingBlock:(JJRefreshComponentRefreshingBlock)refreshingBlock {
    self.mj_header = [JJHeader headerWithRefreshingBlock:^{
        refreshingBlock();
    }];
}

- (void)footerWithRefreshingBlock:(JJRefreshComponentRefreshingBlock)refreshingBlock {
    self.mj_footer = [JJFooter footerWithRefreshingBlock:^{
        refreshingBlock();
    }];
}

- (void)endRefreshing {
    if (self.mj_header) {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer) {
        [self.mj_footer endRefreshing];
    }
}
@end
