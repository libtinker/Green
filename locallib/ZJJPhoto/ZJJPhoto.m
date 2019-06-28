//
//  ZJJPhoto.m
//  Pods-Green
//
//  Created by 天空吸引我 on 2019/6/24.
//

#import "ZJJPhoto.h"
#import "JJAlertController.h"
#import "ConstantConfig.h"

#define THUMBNAILSIZE CGSizeMake(([UIScreen mainScreen].bounds.size.width-6)/4, ([UIScreen mainScreen].bounds.size.width-6)/4)
@interface ZJJAsset ()
@end

@implementation ZJJAsset

- (NSString *)name {
    if ([_asset isKindOfClass:[PHAsset class]]) {
        return [_asset valueForKey:@"filename"];
    }
    return @"unknown.JPG";
}

- (NSTimeInterval)duration {
    if ([_asset isKindOfClass:[PHAsset class]]) {
        return [(PHAsset *)_asset duration];
    }
    return 0;
}

- (void)setFileSize:(void (^)(NSInteger))fileSize {
    _fileSize = fileSize;

    if (_asset && _fileSizeCache > 0) {
        _fileSize(_fileSizeCache);
        return;
    }

    if (self.mediaType == PHAssetMediaTypeVideo) {
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        [[PHImageManager defaultManager] requestAVAssetForVideo:_asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            if ([asset isKindOfClass:[AVURLAsset class]]) {
                AVURLAsset *urlAsset = (AVURLAsset *)asset;
                NSNumber *size;

                [urlAsset.URL getResourceValue:&size forKey:NSURLFileSizeKey error:nil];
                _fileSizeCache = [size floatValue]; // _cacheFileSize / (1024 * 1024) 转MB
                _fileSize(_fileSizeCache);
            }
        }];
    }else {
        [[PHImageManager defaultManager] requestImageDataForAsset:_asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            _fileSizeCache = imageData.length; // _cacheFileSize / (1024 * 1024) 转MB
            _fileSize(_fileSizeCache);
        }];
    }
}

- (void)setThumbnail:(void (^)(UIImage * _Nonnull))thumbnail {
    _thumbnail = thumbnail;

    if (_asset && _thumbImageCache) {
        _thumbnail(_thumbImageCache);
        return;
    }

    if ([_asset isKindOfClass:[PHAsset class]]) {
        PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
        requestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;

        [[PHImageManager defaultManager] requestImageForAsset:_asset targetSize:THUMBNAILSIZE contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            BOOL download = ![info[PHImageCancelledKey] boolValue] && ![info[PHImageErrorKey] boolValue] && ![info[PHImageResultIsDegradedKey] boolValue];

            if (download) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _thumbImageCache = result;
                    _thumbnail(_thumbImageCache);
                });
            }
        }];
    }
}

- (void)setFullImage:(void (^)(UIImage * _Nonnull))fullImage {
    _fullImage = fullImage;

    if (_asset&&_fullImageCache){
        _fullImage(_fullImageCache);
        return;
    }

    if ([_asset isKindOfClass:[PHAsset class]]) {
        PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
        requestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;

        CGFloat photoWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat aspectRatio = ((PHAsset*)_asset).pixelWidth / (CGFloat)((PHAsset*)_asset).pixelHeight;
        CGFloat multiple = [UIScreen mainScreen].scale;
        CGFloat pixelWidth = photoWidth * multiple;
        CGFloat pixelHeight = pixelWidth / aspectRatio;

        //允许从iCloud上下载
        requestOptions.networkAccessAllowed = YES;
        requestOptions.progressHandler = ^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
            if (self.getNetworkProgressHandler) {
                self.getNetworkProgressHandler(progress, error, stop, info);
            }
        };

        [[PHImageManager defaultManager] requestImageForAsset:_asset targetSize:CGSizeMake(pixelWidth, pixelHeight) contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            BOOL download = ![info[PHImageCancelledKey] boolValue] && ![info[PHImageErrorKey] boolValue] && ![info[PHImageResultIsDegradedKey] boolValue];

            if (download) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _fullImageCache = result;
                    _fullImage(_fullImageCache);
                 });
            }
        }];
    }

}
@end

@implementation ZJJPhoto
singleton_implementation();

#pragma mark - 保存视频到相册
- (void)saveVideo:(NSString *)videoPath {
    if ([self cheackAccessPermissions]) {
        UISaveVideoAtPathToSavedPhotosAlbum(videoPath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *alertString = error?error.description:@"已成功保存至相册";
    [self alertTitle:nil content:alertString];
}

#pragma mark - 获取相册内所有照片资源
- (NSArray<PHAsset *> *)getAllAssetWithMediaType:(PHAssetMediaType)mediaType ascending:(BOOL)ascending {
    if (![self cheackAccessPermissions]) {
        return nil;
    }
     NSMutableArray<PHAsset *> *assets = [NSMutableArray array];

    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    //ascending 为YES时，按照照片的创建时间升序排列;为NO时，则降序排列
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];

    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:mediaType options:option];

    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj) {
            ZJJAsset *photo = [[ZJJAsset alloc] init];
            photo.asset = obj;
            [assets addObject:photo];
        }
    }];

    return assets;
}

//检查访问权限
- (BOOL)cheackAccessPermissions {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        // 这里便是无访问权限
        [self alertTitle:@"无访问权限" content:@"请在设备的\"设置-隐私-照片\"选项中，允许%@访问您的手机相册。"];
        return NO;
    }
    return YES;
}

//弹窗
- (void)alertTitle:(NSString *)title content:(NSString *)content {
     [JJAlertController alertControllerWithTitle:title message:content actionNames:@[@"确定"] handle:nil];
}

@end
