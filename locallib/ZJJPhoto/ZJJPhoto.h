//
//  ZJJPhoto.h
//  Pods-Green
//
//  Created by 天空吸引我 on 2019/6/24.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "SingLeton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJJAsset : PHAsset
@property (nonatomic, strong) id asset;

@property (nonatomic, copy) NSString *name;//文件名称
@property (nonatomic, assign) NSTimeInterval duration;//视频时长
@property (nonatomic, getter=isSelected, assign) BOOL selected;

@property (nonatomic, copy) void (^thumbnail)(UIImage *image);
@property (nonatomic, copy) void (^fullImage)(UIImage *image);
@property (nonatomic, copy) void (^fileSize)(NSInteger size);

@property (nonatomic, copy) void (^getNetworkProgressHandler)(double, NSError *, BOOL *, NSDictionary *);

@property (nonatomic, strong) UIImage *thumbImageCache;//缩略图缓存
@property (nonatomic, strong) UIImage *fullImageCache;//原图缓存
@property (nonatomic, assign) NSInteger fileSizeCache;//文件大小缓存
@end

@interface ZJJPhoto : NSObject
singleton_interface();
- (void)saveVideo:(NSString *)videoPath;//保存视频到相册

/**
 读取相册内所有图片资源

 @param ascending ascending 为YES时，按照照片的创建时间升序排列;为NO时，则降序排列
 @return 图片资源
 */

/**
 根据mediaType读取相册内所有图片资源或者视频资源

 @param mediaType 资源类型
 @param ascending ascending 为YES时，按照照片的创建时间升序排列;为NO时，则降序排列
 @return 资源
 */
- (NSArray<PHAsset *> *)getAllAssetWithMediaType:(PHAssetMediaType)mediaType ascending:(BOOL)ascending;
@end

NS_ASSUME_NONNULL_END
