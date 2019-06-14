//
//  LoginView.h
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginView : UIView

@property (nonatomic,copy) void(^loginBlock)(NSString *userName,NSString *password);
@end

NS_ASSUME_NONNULL_END
