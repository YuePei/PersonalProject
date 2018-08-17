//
//  SurroundMPVC.m
//  FirstProject
//
//  Created by MacBook Air on 2018/3/1.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "SurroundMPVC.h"
#import "UIViewController+AlertTool.h"
#import "SurroundPresentAnimation.h"
#import "UITabBarController+tabBarController.h"

@interface SurroundMPVC ()<UICollectionViewDelegate,UICollectionViewDataSource, UINavigationControllerDelegate>
//viewModel
@property(nonatomic,strong)SurroundVM *viewModel;
//转场动画
@property (nonatomic, strong)SurroundPresentAnimation *presentAnimation;

@end

@implementation SurroundMPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    self.hidesBottomBarWhenPushed = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"周边";
    self.navigationController.delegate = self;
    _presentAnimation = [SurroundPresentAnimation new];
//    [self showLeftSideMenu];
    [self collectionView];
    [self setUpUI];
    [self.viewModel getGoodsListWithType:1 CallBack:^(NSError *error) {
        if (!error) {
            //成功
            [self.collectionView reloadData];
        }else {
            //失败
            [self presentAlertWithTitle:@"提示" message:@"网络有点慢, 请稍后" alertStyle:UIAlertControllerStyleAlert cancleActionTitle:nil cancelBlock:nil sureActionTitle:@"确定" sureBlock:^{
                [self refreshData];
            } completion:nil];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
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
            [self presentAlertWithTitle:@"提示" message:@"网络有点慢, 请稍后" alertStyle:UIAlertControllerStyleAlert cancleActionTitle:nil cancelBlock:nil sureActionTitle:@"确定" sureBlock:^{
                [self refreshData];
            } completion:nil];
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
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
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
    NSString *imageString = [self.viewModel getImgAtIndexPathRow:indexPath.row];
    
    sdVC.imageString = imageString;
    sdVC.goodsNameString = [self.viewModel getNameAtIndex:indexPath.row];
    sdVC.priceLabel.text = [NSString stringWithFormat:@"¥ %@",[self.viewModel getPriceAtIndex:indexPath.row]];
    sdVC.oldPriceLabel.text = @"原价 998";
    sdVC.soldCount.text = [NSString stringWithFormat:@"包邮  已售: %ld",[self.viewModel getSellNumberAtIndex:indexPath.row]];
    [self.tabBarController hideTabBarWithAnimationDuration:0.3f];
    [self.navigationController pushViewController:sdVC animated:YES];
}

#pragma mark UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[SDetailVc class]]) {
        return self.presentAnimation;
    }else {
        return nil;
    }
}

#pragma mark toolMethods

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
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 15;
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 35) / 2.0, (SCREEN_WIDTH - 35) / 2.0 + 80);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabBarController.tabBar.frame.size.height) collectionViewLayout:flowLayout];
        [self.view addSubview:_collectionView];
//        _collectionView.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1];
        _collectionView.backgroundColor = [UIColor darkGrayColor];
        [_collectionView registerClass:[GoodsCell class] forCellWithReuseIdentifier:@"goodsCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
@end
