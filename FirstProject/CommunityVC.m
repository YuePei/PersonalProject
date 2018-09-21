//
//  CommunityVC.m
//  FirstProject
//
//  Created by MacBook Air on 17/10/24.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "CommunityVC.h"
#import "PhotosListVC.h"

@interface CommunityVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

//collectionView
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation CommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self collectionView];
    self.navigationItem.title = @"足迹";
}

#pragma mark UIScrollViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CommunityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CommunityCell alloc]init];
    }
    
    if (indexPath.row == 0) {
        cell.bottomIV.image = [UIImage imageNamed:@"stars"];
    }else if (indexPath.row == 1 ){
        cell.bottomIV.image = [UIImage imageNamed:@"mountain"];
    }else if (indexPath.row == 2 ){
        cell.bottomIV.image = [UIImage imageNamed:@"beauty"];
    }else if (indexPath.row == 3 ){
        cell.bottomIV.image = [UIImage imageNamed:@"stars"];
    }else if (indexPath.row == 4 ){
        cell.bottomIV.image = [UIImage imageNamed:@"beauty"];
    }else if (indexPath.row == 5 ){
        cell.bottomIV.image = [UIImage imageNamed:@"mountain"];
    }
//    [cell gradientLayer];
    cell.authorIV.image = [UIImage imageNamed:@"头像"];
    cell.titleL.text = @"Here's the title!And what will happen if the sentence is too long?";
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[PhotosListVC new] animated:YES];
    }else if (indexPath.row == 1) {
        
    }else if (indexPath.row == 2) {
        
    }else if (indexPath.row == 3) {
        
    }else if (indexPath.row == 4) {
        
    }else if (indexPath.row == 5) {
        
    }
}

#pragma mark lazy

- (UICollectionView *)collectionView {
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 20;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    if (SCREEN_WIDTH > 414.0) {
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH - 20) / 2.0 + 102);
    }else {
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH - 20) / 2.0 + 72);
    }
//    flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 228);
    
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabBarController.tabBar.bounds.size.height) collectionViewLayout:flowLayout];
        [_collectionView setCollectionViewLayout:flowLayout];
        [self.view addSubview:_collectionView];
        [_collectionView makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
    }
    [_collectionView registerClass:[CommunityCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[CustomCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    return _collectionView;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    CustomCollectionReusableView *reusableView = nil;
//    if (kind == UICollectionElementKindSectionHeader) {
//        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
//    }
//    [reusableView.leftButton setTitle:@"今日最佳推荐" forState:UIControlStateNormal];
//    return reusableView;
//}
@end
