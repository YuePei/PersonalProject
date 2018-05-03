

//
//  MainPageHeaderView.m
//  FirstProject
//
//  Created by Peyton on 2018/5/3.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "MainPageHeaderView.h"
#import "DetailCollectionViewCell.h"

@interface MainPageHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation MainPageHeaderView

- (void)drawRect:(CGRect)rect {
    [self contentCollectionView];
}
#pragma mark collectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[DetailCollectionViewCell alloc]init];
    }
    //    cell.backgroundColor = [UIColor brownColor];
    int i = 1 + arc4random() % 4;
    cell.mainIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
    return cell;
}

#pragma mark lazy
- (UILabel *)topLeftLabel {
    if (!_topLeftLabel) {
        _topLeftLabel = [[UILabel alloc]init];
        [self addSubview:_topLeftLabel];
        [_topLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(30);
        }];
        _topLeftLabel.text = @"热门专题推荐";
    }
    return _topLeftLabel;
}
- (UICollectionView *)contentCollectionView {
    //设置每个cell的宽度和高度
    float collectionViewCellWidth = 190 * SCREEN_PROPORTION;
    float collectionViewCellHeight = 130 * SCREEN_PROPORTION;
    if (!_contentCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 20;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(collectionViewCellWidth, collectionViewCellHeight);
        //初始化collectionView
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, collectionViewCellHeight + 20) collectionViewLayout:layout];
        _contentCollectionView.contentSize = CGSizeMake(10 + 4 * layout.itemSize.width + 3 * 20 + 10, layout.itemSize.height );
        [self addSubview:_contentCollectionView];
        [_contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.topLeftLabel.mas_bottom);
            make.right.mas_equalTo(0);
            //            make.bottom.mas_equalTo(-10);
            make.height.mas_equalTo(collectionViewCellHeight + 20);
        }];
        
        _contentCollectionView.backgroundColor = [UIColor whiteColor];
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        [_contentCollectionView registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _contentCollectionView;
}

@end
