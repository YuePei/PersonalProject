//
//  ShareListView.m
//  FirstProject
//
//  Created by Peyton on 2018/7/10.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "ShareListView.h"
#import "ShareCollectionViewCell.h"

@interface ShareListView () <UICollectionViewDelegate, UICollectionViewDataSource>

//中间的view, 用来展示collectionView和其他的View
@property (nonatomic, strong)UIView *middleView;
//collectionView
@property (nonatomic, strong)UICollectionView *collectionView;
//array
@property (nonatomic, strong)NSArray *array;
//icons
@property (nonatomic, strong)NSArray *icons;

@end

@implementation ShareListView

static const float leftMargin = 30.0;
static const float rightMargin = 30.0;
static const float topMargin = 10.0;
static const float bottomMargin = 10.0;
static const float rowInterval = 30.0;
static const float columnInterval = 20.0;
static const float itemWidth = 50.0;
static const float itemHeight = itemWidth + 40;

#pragma mark initMethods
- (instancetype)initWithFrame:(CGRect)frame shareIcons:(NSArray *)icons andShareTitles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        self.array = titles;
        self.icons = icons;
        self.backgroundColor = [UIColor colorWithRed:1 / 255.0 green:1 / 255.0 blue:1 / 255.0 alpha:0.5];
        [self collectionView];
        [self middleView];
    }
    return self;
}


#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shareCell" forIndexPath:indexPath];
    [cell setCellWithLogoImage:self.icons[indexPath.row] name:self.array[indexPath.row]];
    NSLog(@"0000000000-----:%f",CGRectGetHeight(cell.frame));
    return cell;
}

#pragma mark lazy
- (UIView *)middleView {
    if (!_middleView) {
        _middleView = [UIView new];
        [self addSubview:_middleView];
        [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(300);
        }];
        _middleView.backgroundColor = [UIColor whiteColor];
    }
    return _middleView;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        //一共有多少个cell
        long columnCount = self.array.count;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = rowInterval;
        layout.minimumInteritemSpacing = columnInterval;
        layout.sectionInset = UIEdgeInsetsMake(topMargin, leftMargin, bottomMargin, rightMargin);
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.contentSize = CGSizeMake(leftMargin + columnCount * itemWidth + (columnCount -1) * columnInterval + rightMargin, CGRectGetHeight(_collectionView.frame));
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [self.middleView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(itemHeight);
        }];
        
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"ShareCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"shareCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSArray *)array {
    if (!_array) {
        _array = [NSArray array];
    }
    return _array;
}

- (NSArray *)icons {
    if (!_icons) {
        _icons = [NSArray array];
    }
    return _icons;
}
@end
