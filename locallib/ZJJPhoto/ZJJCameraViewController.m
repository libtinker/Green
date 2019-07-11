//
//  ZJJCameraViewController.m
//  ZJJPhoto
//
//  Created by 天空吸引我 on 2019/6/28.
//

#import "ZJJCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ConstantConfig.h"
#import "JJKit.h"
#import "ZJJPhotoAlbumViewController.h"

@interface ZJJCameraViewController ()
//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property (nonatomic, strong) AVCaptureDevice *device;

//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property (nonatomic, strong) AVCaptureDeviceInput *input;

//输出图片
@property (nonatomic ,strong) AVCaptureStillImageOutput *imageOutput;

//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property (nonatomic, strong) AVCaptureSession *session;

//图像预览层，实时显示捕获的图像
@property (nonatomic ,strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UIButton *shootButton;//拍摄按钮
@property (nonatomic,strong) UIButton *photoAlbumBtn;//相机按钮
@property (nonatomic,strong) UIButton *cameraBtn;//摄像头

@end

@implementation ZJJCameraViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self cameraDistrict];
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.shootButton];
    [self.view addSubview:self.photoAlbumBtn];
    [self.view addSubview:self.cameraBtn];
}

#pragma mark - HTTP

#pragma mark - Delegate

#pragma mark - Public

#pragma mark - Private
- (void)cameraDistrict {
    //    AVCaptureDevicePositionBack  后置摄像头
    //    AVCaptureDevicePositionFront 前置摄像头
    self.device = [self cameraWithPosition:AVCaptureDevicePositionFront];
    self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];

    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];

    self.session = [[AVCaptureSession alloc] init];
    //     拿到的图像的大小可以自行设定
    //    AVCaptureSessionPreset320x240
    //    AVCaptureSessionPreset352x288
    //    AVCaptureSessionPreset640x480
    //    AVCaptureSessionPreset960x540
    //    AVCaptureSessionPreset1280x720
    //    AVCaptureSessionPreset1920x1080
    //    AVCaptureSessionPreset3840x2160
    self.session.sessionPreset = AVCaptureSessionPreset640x480;
    //输入输出设备结合
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.imageOutput]) {
        [self.session addOutput:self.imageOutput];
    }
    //预览层的生成
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    //设备取景开始
    [self.session startRunning];
    if ([_device lockForConfiguration:nil]) {
        //自动闪光灯，
        if ([_device isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [_device setFlashMode:AVCaptureFlashModeAuto];
        }
        //自动白平衡,但是好像一直都进不去
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        [_device unlockForConfiguration];
    }

}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ){
            return device;
        }
    return nil;
}

// 截取照片
- (void) shutterCamera
{
    AVCaptureConnection * videoConnection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        return;
    }

    [self.imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [UIImage imageWithData:imageData];
        [self.session stopRunning];
        [self saveImageToPhotoAlbum:image];
        NSLog(@"image size = %@",NSStringFromCGSize(image.size));
    }];
}

#pragma - 保存至相册
- (void)saveImageToPhotoAlbum:(UIImage*)savedImage {
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)changeCamera{
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        //给摄像头的切换添加翻转动画
        CATransition *animation = [CATransition animation];
        animation.duration = .5f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"oglFlip";

        AVCaptureDevice *newCamera = nil;
        AVCaptureDeviceInput *newInput = nil;
        //拿到另外一个摄像头位置
        AVCaptureDevicePosition position = [[_input device] position];
        if (position == AVCaptureDevicePositionFront){
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            animation.subtype = kCATransitionFromLeft;//动画翻转方向
        }
        else {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            animation.subtype = kCATransitionFromRight;//动画翻转方向
        }
        //生成新的输入
        newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
        [self.previewLayer addAnimation:animation forKey:nil];
        if (newInput != nil) {
            [self.session beginConfiguration];
            [self.session removeInput:self.input];
            if ([self.session canAddInput:newInput]) {
                [self.session addInput:newInput];
                self.input = newInput;

            } else {
                [self.session addInput:self.input];
            }
            [self.session commitConfiguration];

        } else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }
    }
}
- (void)closeBtnClicked {
    self.tabBarController.selectedIndex = 0;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)shootButtonClicked {
    [self shutterCamera];
}

- (void)photoAlbumBtnClicked {
    ZJJPhotoAlbumViewController *ctrl = [[ZJJPhotoAlbumViewController alloc] init];
    [self presentViewController:ctrl animated:YES completion:nil];
}

- (void)cameraBtnClicked {
    [self changeCamera];
}
#pragma mark - Setter

#pragma mark - Getter
- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithFrame:CGRectMake(0, STATUSBAR_HEIGHT+100, 80, 44) title:@"关闭" titleColor:UIColor.whiteColor font:[UIFont systemFontOfSize:14] target:self action:@selector(closeBtnClicked)];
    }
    return _closeBtn;
}

- (UIButton *)shootButton {
    if (!_shootButton) {
        _shootButton = [UIButton buttonWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, SCREEN_HEIGHT-100, 60, 60) image:nil target:self action:@selector(shootButtonClicked)];
        _shootButton.backgroundColor = [UIColor redColor];
        _shootButton.layer.cornerRadius = 30;
    }
    return _shootButton;
}

- (UIButton *)photoAlbumBtn {
    if (!_photoAlbumBtn) {
        _photoAlbumBtn = [UIButton buttonWithFrame:CGRectMake(0, 0, 40, 40) title:@"相册" titleColor:UIColor.whiteColor font:[UIFont systemFontOfSize:12] target:self action:@selector(photoAlbumBtnClicked)];
        _photoAlbumBtn.backgroundColor = UIColor.yellowColor;
        _photoAlbumBtn.layer.centerY = self.shootButton.layer.centerY;
        _photoAlbumBtn.layer.x = self.shootButton.layer.x -100;
    }
    return _photoAlbumBtn;
}

- (UIButton *)cameraBtn {
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithFrame:CGRectMake(0, 0, 40, 40) title:@"摄像头" titleColor:UIColor.whiteColor font:[UIFont systemFontOfSize:12] target:self action:@selector(cameraBtnClicked)];
        _cameraBtn.backgroundColor = UIColor.yellowColor;
        _cameraBtn.layer.centerY = self.shootButton.layer.centerY;
        _cameraBtn.layer.x = self.shootButton.layer.x +100;
    }
    return _cameraBtn;
}
@end
