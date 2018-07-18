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
//分割线
@property (nonatomic , strong) UIView *separaterLine;
//分割线上面的view
@property (nonatomic , strong) UIView *topView;
//顶部左边的按钮，截图编辑
@property (nonatomic , strong) UIButton *screenShotButton;
//顶部右边的按钮，添加
@property (nonatomic , strong) UIButton *addExpressionButton;

@end

@implementation ShareListView

static const float leftMargin = 30.0;
static const float rightMargin = 30.0;
static const float topMargin = 10.0;
static const float bottomMargin = 10.0;
static const float rowInterval = 30.0;
static const float columnInterval = 20.0;
static const float itemWidth = 50.0;
static const float itemHeight = itemWidth + 25;
static const float buttonWidth_Height = 100;


#pragma mark initMethods
- (instancetype)initWithFrame:(CGRect)frame shareIcons:(NSArray *)icons andShareTitles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        self.array = titles;
        self.icons = icons;
        NSLog(@"......%f",titles.count);
        self.backgroundColor = [UIColor colorWithRed:1 / 255.0 green:1 / 255.0 blue:1 / 255.0 alpha:0];
        [self collectionView];
        [self middleView];
        [self separaterLine];
        [self topView];
        [self screenShotButton];
        [self addExpressionButton];
        [self addGesture];
        [self showBackgroundColor];
        [self showMiddleView];
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
    
    return cell;
}
#pragma mark toolMethods
- (void)addGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMiddleView)];
    [self addGestureRecognizer:tapGesture];
}
//隐藏分享模块
- (void)hideMiddleView {

    [UIView animateWithDuration:0.5 animations:^{
        [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0]];
        [self.middleView setFrame:CGRectMake(self.middleView.frame.origin.x, CGRectGetHeight(self.frame), CGRectGetWidth(self.middleView.frame), CGRectGetHeight(self.middleView.frame))];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//显示分享模块
- (void)showMiddleView {
    
    NSLog(@"----:%@",self.middleView);
    [self.middleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
    }];
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseIn animations:^{

        [self.middleView.superview layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        NSLog(@"Show animation finished.");
    }];
}

//显示背景色
- (void)showBackgroundColor {
    [UIView animateWithDuration:0.3 animations:^{
        [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    }];
}

//调整按钮的图文位置
- (void)adjustButtonImageViewUPTitleDownWithButton:(UIButton *)button {
    [self.topView layoutIfNeeded];
    [button setBackgroundColor:[UIColor grayColor]];
    button.imageView.backgroundColor = [UIColor redColor];
    //使图片和文字居左上角
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //调整图片
    float iVOffsetY = CGRectGetHeight(button.frame) / 2.0 - (CGRectGetHeight(button.imageView.frame) + CGRectGetHeight(button.titleLabel.frame)) / 2.0;
    float iVOffsetX = CGRectGetWidth(button.frame) / 2.0 - CGRectGetWidth(button.imageView.frame) / 2.0;
    [button setImageEdgeInsets:UIEdgeInsetsMake(iVOffsetY, iVOffsetX, 0, 0)];
    
    //调整文字
    float titleOffsetY = iVOffsetY + CGRectGetHeight(button.imageView.frame) + 10;
    float titleOffsetX = 0;
    if (CGRectGetWidth(button.imageView.frame) >= (CGRectGetWidth(button.frame) / 2.0)) {
        //如果图片的宽度超过或等于button宽度的一半
        titleOffsetX = -(CGRectGetWidth(button.imageView.frame)
                         + CGRectGetWidth(button.titleLabel.frame)
                         - CGRectGetWidth(button.frame) / 2.0
                         - CGRectGetWidth(button.titleLabel.frame) / 2.0);
        NSLog(@"-(图片宽度(%f) + 文字宽度(%f) - 按钮宽度的一半(%f/2) - 文字宽度的一半(%f/2) = 文字的偏移量(%f))",CGRectGetWidth(button.imageView.frame), CGRectGetWidth(button.titleLabel.frame), CGRectGetWidth(button.frame), CGRectGetWidth(button.titleLabel.frame), titleOffsetX);
    }else {
        titleOffsetX = CGRectGetWidth(button.frame) / 2.0 - CGRectGetWidth(button.imageView.frame) - CGRectGetWidth(button.titleLabel.frame) / 2.0;
    }
    [button setTitleEdgeInsets:UIEdgeInsetsMake(titleOffsetY , titleOffsetX, 0, 0)];
}

#pragma mark lazy
- (UIView *)middleView {
    if (!_middleView) {
        _middleView = [UIView new];
        [self addSubview:_middleView];
        [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(225);
            make.bottom.mas_equalTo(225);
        }];
//        [_middleView setFrame:CGRectMake(10, 667, 355, 225)];
        _middleView.backgroundColor = [UIColor whiteColor];
        _middleView.layer.cornerRadius = 10;
        _middleView.layer.masksToBounds = YES;
        NSLog(@"middleView:%@",_middleView);
    }
    return _middleView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        [self.middleView addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.separaterLine.mas_top);
        }];
        _topView.backgroundColor = [UIColor clearColor];
    }
    return _topView;
}

- (UIButton *)screenShotButton {
    if (!_screenShotButton) {
        _screenShotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [_screenShotButton setFrame:CGRectMake(20, 20, 60, 60)];
        [self.topView addSubview:_screenShotButton];
        [_screenShotButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.topView.centerY);
            make.centerX.mas_equalTo(self.topView.centerX).offset(- (CGRectGetWidth(self.frame) - 20) / 4.0);
            make.width.height.mas_equalTo(buttonWidth_Height);
            //            make.height.mas_equalTo(80);
        }];
        [_screenShotButton setTitle:@"截图编辑" forState:UIControlStateNormal];
        [_screenShotButton setImage:[UIImage imageNamed:@"图片剪切"] forState:UIControlStateNormal];
        _screenShotButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_screenShotButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setNeedsLayout];
        [self layoutIfNeeded];
        [self adjustButtonImageViewUPTitleDownWithButton:_screenShotButton];
    }
    return _screenShotButton;
}

- (UIButton *)addExpressionButton {
    if (!_addExpressionButton) {
        
        _addExpressionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.topView addSubview:_addExpressionButton];
        [_addExpressionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.topView.centerY);
            make.centerX.mas_equalTo(self.topView.centerX).mas_offset((CGRectGetWidth(self.frame) - 20) / 4.0);
            make.width.height.mas_equalTo(100);
            //            make.height.mas_equalTo(80);
        }];
        [_addExpressionButton setTitle:@"添加表情" forState:UIControlStateNormal];
        [_addExpressionButton setImage:[UIImage imageNamed:@"表情"] forState:UIControlStateNormal];
        _addExpressionButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_addExpressionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self adjustButtonImageViewUPTitleDownWithButton:_addExpressionButton];
    }
    return _addExpressionButton;
}

- (UIView *)separaterLine {
    if (!_separaterLine) {
        _separaterLine = [[UIView alloc]init];
        [self.middleView addSubview:_separaterLine];
        [_separaterLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.bottom.mas_equalTo(self.collectionView.mas_top).mas_offset(-10);
            make.height.mas_equalTo(1);
        }];
        _separaterLine.backgroundColor = BACK_COLOR;
    }
    return _separaterLine;
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
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [self.middleView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(itemHeight + topMargin + bottomMargin);
        }];
        _collectionView.contentSize = CGSizeMake(leftMargin + columnCount * itemWidth + (columnCount -1) * columnInterval + rightMargin, CGRectGetHeight(_collectionView.frame));
        
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

