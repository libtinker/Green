//
//  HomeTableViewCell.h
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HomeTableViewCellDelegate <NSObject>
- (void)praise;
- (void)comments;
- (void)share:(NSString *)vedioPath;
@end

@interface HomeTableViewCell : UITableViewCell
@property (nonatomic,weak) id<HomeTableViewCellDelegate> delegate;
@property (nonatomic,strong) NSDictionary *data;
- (void)playUrlString:(NSString *)urlString ;
- (void)pause;

@end

NS_ASSUME_NONNULL_END
