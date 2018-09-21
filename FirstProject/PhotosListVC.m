//
//  PhotosListVC.m
//  FirstProject
//
//  Created by MacBook Air on 2018/2/20.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "PhotosListVC.h"
#import "WaterFallFlowLayout.h"

@interface PhotosListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFallDelegate>
//collectionView
@property(nonatomic,strong)UICollectionView *collectionView;
//flowLayout
@property(nonatomic,strong)WaterFallFlowLayout *flowLayout;
//photosArray
@property(nonatomic,copy)NSMutableArray *photosArray;
//GifViewModel
@property(nonatomic,strong)GifViewModel *gifVM;

@end

@implementation PhotosListVC

static int offset = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self collectionView];
    self.tabBarController.tabBar.hidden = YES;
    [self.gifVM getGifListWithApiKey:nil limit:20 offSet:0 CallBackBlock:^(id dic, NSError *error) {
        [self.collectionView reloadData];
        offset = 20;
    }];
    [self setUpUI];
}
#pragma mark ToolMethods
- (void)setUpUI {
    //头部刷新
    MJRefreshNormalHeader *nomalHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.collectionView.mj_header = nomalHeader;
    //脚部刷新
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.mj_footer = footer;
}
- (void)refreshData {
    //手动刷新
    [self.collectionView.mj_header beginRefreshing];
    [self.gifVM getGifListWithApiKey:nil limit:20 offSet:0 CallBackBlock:^(id dic, NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
        offset = 20;
    }];
}
- (void)loadMoreData {
    [self.collectionView.mj_footer beginRefreshing];
    [self.gifVM getMoreGifWithApiKey:@"anyString" limit:20 offSet:offset CallBackBlock:^(id dic, NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
        offset += 20;
    }];
}
#pragma mark delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  1;
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.gifVM getGifNumber];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[PhotoCollectionViewCell alloc]init];
        
    }
    cell.photoIV.backgroundColor = [UIColor darkGrayColor];
    [cell.photoIV sd_setImageWithURL:[NSURL URLWithString:[self.gifVM getUrlAtIndexPathRow:indexPath.row]]];
    NSLog(@".................%@",[self.gifVM getUrlAtIndexPathRow:indexPath.row]);
    return cell;
}

#pragma mark waterFallDelegate


- (float)getHeightWithLayout:(WaterFallFlowLayout *)waterFallLayout AtIndexPath:(NSIndexPath *)indexpath {
    return 100 + arc4random() % 100;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark lazy

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height) collectionViewLayout:self.flowLayout];
        [self.view addSubview:_collectionView];
        [_collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"photoCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (WaterFallFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[WaterFallFlowLayout alloc]init];
        _flowLayout.delegate = self;
    }
    return _flowLayout;
}
- (GifViewModel *)gifVM {
    if (!_gifVM) {
        _gifVM = [[GifViewModel alloc]init];
    }
    return _gifVM;
}


@end
