//
//  HomeTableViewCell.h
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell
- (void)playUrlString:(NSString *)urlString ;
- (void)pause;
- (void)setData:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
