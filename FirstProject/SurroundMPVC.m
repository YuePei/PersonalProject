//
//  SurroundMPVC.m
//  FirstProject
//
//  Created by MacBook Air on 2018/3/1.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "SurroundMPVC.h"

@interface SurroundMPVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
//viewModel
@property(nonatomic,strong)SurroundVM *viewModel;
//collectionView
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation SurroundMPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"周边";
//    [self showLeftSideMenu];
    [self collectionView];
    [self setUpUI];
    [self.viewModel getGoodsListWithType:1 CallBack:^(NSError *error) {
        if (!error) {
            //成功
            [self.collectionView reloadData];
        }
    }];
}

- (void)showLeftSideMenu {
    //声明SWRevealViewController
    SWRevealViewController *revealVC = self.revealViewController;
    //让手势左右滑动即可调出SWRevealViewController
    [revealVC panGestureRecognizer];
    [revealVC tapGestureRecognizer];
}
- (void)setUpUI {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.collectionView.mj_header = header;
    
    MJRefreshAutoFooter *footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.mj_footer = footer;
}

- (void)refreshData {
    
    [self.viewModel getGoodsListWithType:1 CallBack:^(NSError *error) {
        if (!error) {
            //成功
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
        }
        else {
            //失败
        }
    }];
    
}
- (void)loadMoreData {
    [self.viewModel getGoodsListWithType:2 CallBack:^(NSError *error) {
        if (!error) {
            //成功
            [self.collectionView.mj_footer endRefreshing];
            [self.collectionView reloadData];
        }else {
            //失败
        }
    }];
}

#pragma mark delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel getCellNumber];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"goodsCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[GoodsCell alloc]init];
    }
    cell.backgroundColor = [UIColor colorWithRed:41 / 255.0 green:52 / 255.0 blue:64 / 255.0 alpha:1];
    [cell.bigIV sd_setImageWithURL:[NSURL URLWithString:[self.viewModel getImgAtIndexPathRow:indexPath.row]]];
    cell.nameLabel.text = [self.viewModel getNameAtIndex:indexPath.row];
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",[self.viewModel getPriceAtIndex:indexPath.row]];
    cell.sellLabel.text = [NSString stringWithFormat:@"%ld次",[self.viewModel getSellNumberAtIndex:indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SDetailVc *sdVC = [[SDetailVc alloc]init];
    [self.navigationController pushViewController:sdVC animated:YES];
}

#pragma mark lazy
- (SurroundVM *)viewModel {
    if(!_viewModel) {
        _viewModel = [SurroundVM new];
    }
    return _viewModel;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 0, 15);
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 15;
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 45) / 2.0, (SCREEN_WIDTH - 45) / 2.0 + 80);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabBarController.tabBar.frame.size.height) collectionViewLayout:flowLayout];
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1];
        [_collectionView registerClass:[GoodsCell class] forCellWithReuseIdentifier:@"goodsCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
@end
