//
//  FKSelectPhotoView.m
//  FKLibraryExample
//
//  Created by frank on 2018/9/7.
//  Copyright © 2018年 zmosa. All rights reserved.
//

#import "FKSelectPhotoView.h"
#import "FKSelectPhotoCell.h"
#import "TZImagePickerController.h"
//#import <GKPhotoBrowser.h>
static NSString *const ID = @"FKSelectPhotoCell";

@interface FKSelectPhotoView()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) NSArray *datas;
@property(nonatomic, weak) UICollectionView *collectionView;

@end

@implementation FKSelectPhotoView

- (NSArray *)datas
{
    if (!_datas) {
        _datas = @[@""];
    }
    return _datas;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    // 设置初始值
    self.maxCount = 9;
    self.column = 3;
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    // 这里设置的只是初始值，会在代理中改变
    CGFloat itemWH = (fkScreenW - 24 - 20) / 3;
    flowlayout.itemSize = CGSizeMake(itemWH, itemWH);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[FKSelectPhotoCell class] forCellWithReuseIdentifier:ID];
//    collectionView.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.scrollEnabled = false;
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    collectionView.clipsToBounds = false;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FKSelectPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.data = self.datas[indexPath.item];
    if ([cell.data isKindOfClass:[NSString class]] && [cell.data isEqualToString:@""] && self.addBtnBgImg) {
        cell.addBtnBgImg = self.addBtnBgImg;
    }
    cell.deleteBlock = ^(id data) {
        if ([data isKindOfClass:[UIImage class]]) { // 删除本地图片
            NSMutableArray *array = [NSMutableArray arrayWithArray:self.images];
            NSMutableArray *assets = [NSMutableArray arrayWithArray:self.selectedAssets];
            if ([array containsObject:data]) {
                NSInteger index = [array indexOfObject:data];
                [array removeObject:data];
                [assets removeObjectAtIndex:index];
            }
            self.images = array;
            self.selectedAssets = assets;
            [self.collectionView reloadData];
            [self adjustFrame];
        } else if ([data isKindOfClass:[NSString class]]) { // 删除网络图片
            // 通知代理进行删除
            if ([self.delegate respondsToSelector:@selector(selectPhotoView:deleteUrl:)]) {
                [self.delegate selectPhotoView:self deleteUrl:data];
            }
        }
    };
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemW = (collectionView.fk_size.width - 10 * 2) / 3;
    if (self.column) {
        itemW =  (collectionView.fk_size.width - 10 * (self.column - 1)) / self.column;
    }
    if (self.itemH == 0) {
        return CGSizeMake(itemW, itemW);
    }
    return CGSizeMake(itemW, self.itemH);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id data = self.datas[indexPath.item];
    if ([data isKindOfClass:[NSString class]] && [data isEqualToString:@""]) { // 添加图片
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCount - self.urls.count delegate:nil];
        // 选中的相册资源信息
        imagePickerVc.selectedAssets = [NSMutableArray arrayWithArray:self.selectedAssets];
        // 你可以通过block或者代理，来得到用户选择的照片.
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            self.selectedAssets = assets;
            self.images = photos;
            [self.collectionView reloadData];
            [self adjustFrame];
        }];
        [self.superVC presentViewController:imagePickerVc animated:YES completion:nil];
    } else { // 查看图片
//        NSMutableArray *photos = [NSMutableArray new];
//        for (UIImage *image in self.images) {
//            GKPhoto *photo = [GKPhoto new];
//            photo.image = image;
//            [photos addObject:photo];
//        }
//        for (NSString *url in self.urls) {
//            GKPhoto *photo = [GKPhoto new];
//            photo.url = [NSURL URLWithString:url];
//            [photos addObject:photo];
//        }
//        NSInteger currentIndex = 0;
//        if ([data isKindOfClass:[NSString class]]) {
//            currentIndex = [self.urls indexOfObject:data];
//        } else {
//            currentIndex = self.urls.count + [self.images indexOfObject:data];
//        }
//        GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:currentIndex];
//        browser.showStyle = GKPhotoBrowserShowStyleNone;
//        [browser showFromVC:self.superVC];
    }
}

- (void)adjustFrame
{
    if (self.itemH == 0) {
        self.itemH = (fkScreenW - 24 - 10 * (self.column - 1)) / self.column;
    }
    NSInteger rows = (self.datas.count - 1) / self.column + 1;
    CGFloat height = self.itemH * rows + 10 * (rows - 1);
    self.fk_height = height;
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(selectPhotoViewAdjustFrame:)]) {
        [self.delegate selectPhotoViewAdjustFrame:self];
    }
}

- (void)setItemH:(CGFloat)itemH
{
    _itemH = itemH;
    
    [self.collectionView reloadData];
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    [self setupDatas];
}

- (void)setUrls:(NSArray *)urls
{
    _urls = urls;
    
    [self setupDatas];
}

- (void)setupDatas
{
    NSMutableArray *array = [NSMutableArray array];
    if (_urls) {
        [array addObjectsFromArray:_urls];
    }
    if (_images) {
        [array addObjectsFromArray:_images];
    }
    if (_urls.count + _images.count < _maxCount) { // 当图片加满了就不显示添加按钮
        [array addObject:@""];
    }
    self.datas = array;
    
    [self.collectionView reloadData];
    [self adjustFrame];
}

@end
