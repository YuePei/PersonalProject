//
//  SlideTableViewCell.m
//  FirstProject
//
//  Created by Peyton on 2018/4/25.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "SlideTableViewCell.h"
#import "DetailCollectionViewCell.h"


@interface SlideTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
//topLeftLabel
@property (nonatomic, strong)UILabel *topLeftLabel;
//topRightLabel
@property (nonatomic, strong)UILabel *topRightLabel;
//collectionView
@property (nonatomic, strong)UICollectionView *contentCollectionView;

@end
@implementation SlideTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self contentCollectionView];
        self.contentCollectionView.showsHorizontalScrollIndicator = NO;
        [self topLeftLabel];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
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
        [self.contentView addSubview:_topLeftLabel];
        [_topLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(10);
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
        [self.contentView addSubview:_contentCollectionView];
        [_contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.topLeftLabel.mas_bottom);
            make.right.mas_equalTo(0);
//            make.bottom.mas_equalTo(-10);
            make.height.mas_equalTo(collectionViewCellHeight + 20);
        }];
        
        _contentCollectionView.backgroundColor = [UIColor clearColor];
        

        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        [_contentCollectionView registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _contentCollectionView;
}

@end
