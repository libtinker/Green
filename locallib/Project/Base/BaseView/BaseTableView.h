//
//  BaseTableView.h
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 进入刷新状态的回调 */
typedef void (^JJRefreshComponentRefreshingBlock)(void);

@interface BaseTableView : UITableView

/**
 下拉刷新

 @param refreshingBlock 刷新触发事件
 */
- (void)headerWithRefreshingBlock:(JJRefreshComponentRefreshingBlock)refreshingBlock;

/**
 上拉加载

 @param refreshingBlock 刷新触发事件
 */
- (void)footerWithRefreshingBlock:(JJRefreshComponentRefreshingBlock)refreshingBlock;

/**
 结束刷新
 */
- (void)endRefreshing;
@end

NS_ASSUME_NONNULL_END
