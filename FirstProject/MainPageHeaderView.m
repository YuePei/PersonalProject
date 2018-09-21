

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
//titles
@property (nonatomic, strong)NSArray *titles;
//轮播scrollview
@property (nonatomic , strong) UIScrollView *scrollView;
//小圆点
@property (nonatomic , strong) UIPageControl *pageControl;
//自动轮播时间控制
@property (nonatomic , strong) NSTimer *timer;

@end
@implementation MainPageHeaderView
static float const scrollViewHeight = 180;
//用于记录计时器计时循环
static NSInteger pageNumber = 0;
static int const timeInterval = 2;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self scrollView];
        [self contentCollectionView];
        [self imagesArray];
        [self pageControl];
        self.timer  = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(automaticallyPlayArround) userInfo:nil repeats:YES];
        //第一块放最后一张，最后一块放第一张图
        for (int i = 0; i < self.imagesArray.count + 2; i ++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, scrollViewHeight)];
            [self.scrollView addSubview:imageView];
            if (i == 0) {
                //第一张放最后一张图
                imageView.image = self.imagesArray[self.imagesArray.count - 1];
            }else if(i == self.imagesArray.count + 1) {
                //最后一张放第一张图
                imageView.image = self.imagesArray[0];
            }else{
                imageView.image = self.imagesArray[i - 1];
            }
        }
    }
    return self;
}

#pragma mark collectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[DetailCollectionViewCell alloc]init];
    }
    cell.mainIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"world_%ld",indexPath.row]];
    cell.titleLabel.text = self.titles[indexPath.row];
    return cell;
}

#pragma mark toolMethods
- (void)automaticallyPlayArround {
    if (pageNumber == 0) {
        //跳转到下一个图片
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset = CGPointMake((2 + pageNumber) * SCREEN_WIDTH, 0);
        }];
    }else if (pageNumber == self.imagesArray.count) {
        //将位置摆正
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        pageNumber = 0;
        //跳转到下一个图片
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset = CGPointMake((2 + pageNumber) * SCREEN_WIDTH, 0);
        }];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset = CGPointMake((2 + pageNumber) * SCREEN_WIDTH, 0);
        }];
    }
    pageNumber ++;
}
- (void)beginTimer {
    if (self.timer) {
        [self stopTimer];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(automaticallyPlayArround) userInfo:nil repeats:YES];
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //设置pageControl的显示合理
    float offsetX = scrollView.contentOffset.x;
    if (offsetX < SCREEN_WIDTH) {
        self.pageControl.currentPage = self.imagesArray.count - 1;
    }else if (offsetX >= SCREEN_WIDTH * (self.imagesArray.count + 1) && offsetX < SCREEN_WIDTH * (self.imagesArray.count + 2)) {
        self.pageControl.currentPage = 0;
    }else {
        self.pageControl.currentPage = offsetX / SCREEN_WIDTH - 1;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}
//在滑动结束减速时的代理方法中设置偏移
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == (self.imagesArray.count + 1) * SCREEN_WIDTH) {
        //当滚动到最后一张的时候，其实显示的是数组中的第一张图，应该让scrollView滚动到第二位的地方
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    }else if(scrollView.contentOffset.x == 0) {
        //当滚动到第一位的时候，显示的是数组中的最后一张图片，所以应该滚动到第四位的地方
        self.scrollView.contentOffset = CGPointMake(self.imagesArray.count * SCREEN_WIDTH, 0);
    }
    //启动定时器
    [self beginTimer];
    //拖拽结束后给记录轮播到第几张的变量赋值，如果不做这步操作，会出现一次跳多格的情况
    NSInteger number = (NSInteger)self.scrollView.contentOffset.x/SCREEN_WIDTH;
    if (number == self.imagesArray.count+1){//在最后一张(向右才会到这里)
        pageNumber = 0;
    }else if(number == 0){//在scrollView的第一张(向左才会到这里)
        pageNumber = self.imagesArray.count -1;
    }else{
        pageNumber = number - 1;
    }
}

#pragma mark lazy
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(scrollViewHeight);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        _scrollView.contentSize = CGSizeMake((self.imagesArray.count + 2) * SCREEN_WIDTH, scrollViewHeight);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        //默认让数组的0号元素先展示，如果这里不进行设置，鉴于我们的做法，会导致最后一个图片展示在第一位
        [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
        _scrollView.delegate = self;
    }
    
    return _scrollView;
}

- (UICollectionView *)contentCollectionView {
    
    static const int countPerLine = 5;
    static const int lineNumber = 2;
    static const int lineSpacing = 23;
    static const int interitemSpacing = 20;
    
    if (!_contentCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = lineSpacing;
        layout.minimumInteritemSpacing = interitemSpacing;
        layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        float w = (SCREEN_WIDTH - layout.sectionInset.left - layout.sectionInset.right - interitemSpacing * (countPerLine - 1)) / countPerLine;
        layout.itemSize = CGSizeMake(w, w + 25);
        
        float collectionViewHeight = layout.sectionInset.top + layout.sectionInset.bottom + layout.itemSize.height * lineNumber + (lineNumber - 1)* layout.minimumLineSpacing;
        
        //初始化collectionView
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, collectionViewHeight) collectionViewLayout:layout];
        
        [self addSubview:_contentCollectionView];
        [_contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.scrollView.mas_bottom).mas_offset(10);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(collectionViewHeight);
        }];
        
        _contentCollectionView.backgroundColor = [UIColor whiteColor];
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        [_contentCollectionView registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _contentCollectionView;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = [NSArray arrayWithObjects:@"精选文章", @"儿童文学", @"网络文学", @"大牛博客", @"时尚博主", @"情感专区", @"小  记", @"古  文", @"小  说", @"经  典", nil];
    }
    return _titles;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        [self insertSubview:_pageControl aboveSubview:self.scrollView];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(100);
            make.bottom.mas_equalTo(self.scrollView.mas_bottom).offset(10);
        }];
        _pageControl.numberOfPages = self.imagesArray.count;
    }
    return _pageControl;
}
- (NSMutableArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray new];
        _imagesArray = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"pic1"],[UIImage imageNamed:@"pic2"],[UIImage imageNamed:@"pic3"], [UIImage imageNamed:@"pic4"],nil];
    }
    return _imagesArray;
}

@end
