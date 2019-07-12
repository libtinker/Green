//
//  ZJJPhotoAlbumViewController.m
//  ZJJPhoto
//
//  Created by 天空吸引我 on 2019/6/26.
//

#import "ZJJPhotoAlbumViewController.h"
#import "UIView+JJAdd.h"
#import "UIButton+JJAdd.h"
#import "ConstantConfig.h"
#import "ZJJPhoto.h"
#import "NSObject+JJAdd.h"
#import "CALayer+JJAdd.h"
#import "ZJJNetwork.h"

@interface ImageBrowsingView : UIView
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation ImageBrowsingView

+ (void)showFullImage:(UIImage *)image {
    ImageBrowsingView *view = [[ImageBrowsingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) image:image];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        _imageView = [[UIImageView alloc] initWithImage:image];
        _imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        _imageView.center = self.center;
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}
@end

@interface ZJJPhotoCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *photoImageView;
@property (nonatomic,strong) ZJJAsset *asset;

@property (nonatomic,strong) UIButton *chooseBtn;
@property (nonatomic,strong) UIView *maskView;

@property (nonatomic,copy) void (^chooseBlock)(UIImage *image,BOOL isSeleted);
@end

@implementation ZJJPhotoCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self.contentView addSubview:_photoImageView];

        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.49];
        [self.contentView addSubview:_maskView];
        _maskView.hidden = YES;

        _chooseBtn = [UIButton buttonWithFrame:CGRectMake(frame.size.width-25, 10, 15, 15) image:nil target:self action:@selector(chooseBtnClicked)];
        _chooseBtn.layer.masksToBounds = YES;
        _chooseBtn.layer.cornerRadius = 7.5;
        _chooseBtn.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_chooseBtn];
    }
    return self;
}

- (void)setAsset:(ZJJAsset *)asset {
    _asset = asset;
    self.photoImageView.image = _asset.thumbImageCache;

    __weak typeof(self) weakSelf = self;
    [_asset setThumbnail:^(UIImage * _Nonnull image) {
        weakSelf.photoImageView.image = image;
        [weakSelf setNeedsLayout];
    }];
}

- (void)chooseBtnClicked {
    _chooseBtn.selected = !_chooseBtn.selected;
    if (_chooseBtn.selected) {
        _maskView.hidden = NO;
        _chooseBtn.backgroundColor = [UIColor redColor];
    }else{
        _maskView.hidden = YES;
        _chooseBtn.backgroundColor = [UIColor grayColor];
    }
    if (_chooseBlock) {
        _chooseBlock(self.photoImageView.image,_chooseBtn.selected);
    }
}
@end


@interface ZJJPhotoCollectionView : UICollectionView <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UIImageView *testImageView;
@property (nonatomic,strong) NSMutableArray<UIImage *> *uploadArray;

@property (nonatomic,copy) void(^chooseImagesBlock)(NSArray *data);
@end

static NSString *ZJJPhotoCollectionViewCell = @"ZJJPhotoCollectionViewCell";
@implementation ZJJPhotoCollectionView

+ (ZJJPhotoCollectionView *)createVideoCollectionViewWithframe:(CGRect)frame {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 2.0;
    layout.minimumLineSpacing = 2.0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-6)/4, (SCREEN_WIDTH-6)/4);
    ZJJPhotoCollectionView *view = [[ZJJPhotoCollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = UIColor.whiteColor;
        _uploadArray = [[NSMutableArray alloc] init];

        _testImageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 400, 200, 200)];
        [self addSubview:_testImageView];
        [self registerClass:ZJJPhotoCell.class forCellWithReuseIdentifier:ZJJPhotoCollectionViewCell];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
// 指定Section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 指定section中的collectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

// 配置section中的collectionViewCell的显示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJJPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZJJPhotoCollectionViewCell forIndexPath:indexPath];
    ZJJAsset *asset = _dataArray[indexPath.item];
    cell.asset = asset;
    WS(weakSelf)
    cell.chooseBlock = ^(UIImage *image, BOOL isSeleted) {
        if (isSeleted) {
            [weakSelf.uploadArray addObject:image];
        }else {
            if ([weakSelf.uploadArray containsObject:image]) {
                [weakSelf.uploadArray removeObject:image];
            }
        }
        if (weakSelf.chooseImagesBlock) {
            weakSelf.chooseImagesBlock(weakSelf.uploadArray);
        }
    };

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     ZJJAsset *asset = _dataArray[indexPath.item];
    [asset setFullImage:^(UIImage * _Nonnull image) {
        [ImageBrowsingView showFullImage:image];
    }];
}

@end

@interface ZJJVideoCollectionView : UICollectionView <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UIImageView *testImageView;
@end

@implementation ZJJVideoCollectionView

+ (ZJJVideoCollectionView *)createVideoCollectionViewWithframe:(CGRect)frame {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 2.0;
    layout.minimumLineSpacing = 2.0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
   layout.itemSize = CGSizeMake((SCREEN_WIDTH-6)/4, (SCREEN_WIDTH-6)/4);
    ZJJVideoCollectionView *view = [[ZJJVideoCollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = UIColor.whiteColor;
        _testImageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 400, 200, 200)];
        [self addSubview:_testImageView];
        [self registerClass:ZJJPhotoCell.class forCellWithReuseIdentifier:NSStringFromClass(ZJJPhotoCell.class)];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
// 指定Section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 指定section中的collectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

// 配置section中的collectionViewCell的显示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJJPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(ZJJPhotoCell.class) forIndexPath:indexPath];
    ZJJAsset *asset = _dataArray[indexPath.item];
    cell.asset = asset;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}
@end

@interface ZJJPhotoAlbumViewController ()

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UIButton *titleBtn;
@property (nonatomic,strong) UIButton *videoBtn;
@property (nonatomic,strong) UIButton *photoBtn;
@property (nonatomic,strong) UIButton *nextBtn;

@property (nonatomic,strong) ZJJVideoCollectionView *videoCollectionView;
@property (nonatomic,strong) ZJJPhotoCollectionView *photoCollectionView;
@end

@implementation ZJJPhotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.closeBtn];
    [self.contentView addSubview:self.titleBtn];
    [self.contentView addSubview:self.nextBtn];
    self.titleBtn.layer.centerX = self.contentView.layer.centerX;
    [self.contentView addSubview:self.videoBtn];
    [self.contentView addSubview:self.photoBtn];
    [self.contentView addSubview:self.videoCollectionView];
    [self.contentView addSubview:self.photoCollectionView];
    [self.contentView bringSubviewToFront:self.videoCollectionView];

    [self getVideoData];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark ---- getter----
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUSBAR_HEIGHT)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [_contentView setPartRoundWithCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadius:10.0];
    }
    return _contentView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithFrame:CGRectMake(0, 0, 60, 44) title:@"关闭" titleColor:UIColor.blackColor font:[UIFont systemFontOfSize:14] target:self action:@selector(closeBtnClicked)];
    }
    return _closeBtn;
}

- (UIButton *)titleBtn {
    if (!_titleBtn) {
        _titleBtn = [UIButton buttonWithFrame:CGRectMake(0, 0, 120, 44) title:@"所有照片" titleColor:UIColor.blackColor font:[UIFont systemFontOfSize:14] target:self action:@selector(titleBtnClieked)];
    }
    return _titleBtn;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithFrame:CGRectMake(SCREEN_WIDTH-60, 0, 60, 44) title:@"下一步" titleColor:UIColor.blackColor font:[UIFont systemFontOfSize:14] target:self action:@selector(nextBtnClieked)];
        _nextBtn.hidden = YES;
    }
    return _nextBtn;
}

- (UIButton *)videoBtn {
    if (!_videoBtn) {
        _videoBtn = [UIButton buttonWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleBtn.frame), SCREEN_WIDTH/2, 44) title:@"视频" titleColor:UIColor.blackColor font:[UIFont systemFontOfSize:14] target:self action:@selector(videoBtnClicked)];
    }
    return _videoBtn;
}


- (UIButton *)photoBtn {
    if (!_photoBtn) {
        _photoBtn = [UIButton buttonWithFrame:CGRectMake(SCREEN_WIDTH/2, CGRectGetMaxY(self.titleBtn.frame), SCREEN_WIDTH/2, 44) title:@"照片" titleColor:UIColor.lightGrayColor font:[UIFont systemFontOfSize:14] target:self action:@selector(photoBtnClicked)];
    }
    return _photoBtn;
}

- (ZJJVideoCollectionView *)videoCollectionView {
    if (!_videoCollectionView) {
        _videoCollectionView = [ZJJVideoCollectionView createVideoCollectionViewWithframe:CGRectMake(0, CGRectGetMaxY(self.videoBtn.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.videoBtn.frame)-STATUSBAR_HEIGHT)];
    }
    return _videoCollectionView;
}

- (ZJJPhotoCollectionView *)photoCollectionView {
    if (!_photoCollectionView) {
        _photoCollectionView = [ZJJPhotoCollectionView createVideoCollectionViewWithframe:CGRectMake(0, CGRectGetMaxY(self.videoBtn.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.videoBtn.frame)-STATUSBAR_HEIGHT)];
        WS(weakSelf)
        _photoCollectionView.chooseImagesBlock = ^(NSArray *data) {
            if (data.count>0) {
                weakSelf.nextBtn.hidden = NO;
            }else{
                weakSelf.nextBtn.hidden = YES;
            }
        };
    }
    return _photoCollectionView;
}

- (void)closeBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)titleBtnClieked {

}

- (void)nextBtnClieked {
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i=0; i<_photoCollectionView.uploadArray.count; i++) {
        UIImage *image = _photoCollectionView.uploadArray[i];
        FileItem *item = [[FileItem alloc] init];
        item.name = @"file";
        item.data = UIImagePNGRepresentation(image);
        item.fileName = [@"test" stringByAppendingFormat:@"%d.png",i];
        item.mimeType = @"image/png";
        [dataArray addObject:item];
    }
    ZJJNetwork *network = [[ZJJNetwork alloc] init];
    [network upload:@"http://172.30.14.63:6061/upload" parameters:@{@"name":@"ceshi"} FileItems:dataArray progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(id  _Nullable responseObject) {

    } failure:^(NSError * _Nullable error, id  _Nullable responseObject) {

    }];
}

- (void)videoBtnClicked {
    [self getVideoData];
}

- (void)photoBtnClicked {
    [self.contentView bringSubviewToFront:self.photoCollectionView];
    if (self.photoCollectionView.dataArray.count == 0) {
        NSArray *array = [[ZJJPhoto share] getAllAssetWithMediaType:PHAssetMediaTypeImage ascending:YES];
        NSLog(@"照片数量：%d",array.count);
        self.photoCollectionView.dataArray = array;
        [self.photoCollectionView reloadData];
    }
}

- (void)getVideoData {
    [self.contentView bringSubviewToFront:self.videoCollectionView];
    if (self.videoCollectionView.dataArray == 0) {
        NSArray *array = [[ZJJPhoto share] getAllAssetWithMediaType:PHAssetMediaTypeVideo ascending:YES];
        NSLog(@"照片数量：%d",array.count);
        self.videoCollectionView.dataArray = array;
        [self.videoCollectionView reloadData];
    }
}
@end
