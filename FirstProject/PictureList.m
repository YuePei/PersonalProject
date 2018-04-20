//
//  PictureList.m
//  FirstProject
//
//  Created by MacBook Air on 2018/2/20.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "PictureList.h"

@interface PictureList () <MWPhotoBrowserDelegate>
//photosArray
@property(nonatomic,copy)NSMutableArray *photosArray;
//缩略图
@property(nonatomic,copy)NSMutableArray *thumbsArray;

@end

@implementation PictureList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc]initWithDelegate:self];
    [photoBrowser setCurrentPhotoIndex:0];
    photoBrowser.displayActionButton = YES;//显示分享按钮(左右划动按钮显示才有效)
    photoBrowser.displayNavArrows = YES; //显示左右划动
    photoBrowser.displaySelectionButtons = YES; //是否显示选择图片按钮
    photoBrowser.alwaysShowControls = NO; //控制条始终显示
    photoBrowser.zoomPhotosToFill = YES; //是否自适应大小
    photoBrowser.enableGrid = YES;//是否允许网络查看图片
    photoBrowser.startOnGrid = YES; //是否以网格开始;
    photoBrowser.enableSwipeToDismiss = YES;
    photoBrowser.autoPlayOnAppear = NO;//是否自动播放视频
    [self.navigationController pushViewController:photoBrowser animated:YES];
}


#pragma mark Delegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photosArray.count;
}
- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photosArray.count) {
        return self.photosArray[index];
    }else {
        return nil;
    }
}

//
#pragma mark lazy
- (NSMutableArray *)photosArray {
    if (!_photosArray) {
        _photosArray = [NSMutableArray array];
        for (int i = 0; i < 5;  i ++) {
            MWPhoto *photo = [MWPhoto photoWithImage:[UIImage imageNamed:@"dog"]];
            [_photosArray addObject:photo];
        }
    }
    return _photosArray;
}
- (NSMutableArray *)thumbsArray {
    if (!_thumbsArray) {
        _thumbsArray = [NSMutableArray array];
        
    }
    return _thumbsArray;
}

@end
