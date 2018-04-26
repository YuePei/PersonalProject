//
//  MainPageVC.m
//  FirstProject
//
//  Created by MacBook Air on 17/10/17.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "MainPageVC.h"
#import <pthread.h>
#import "UIButton+CountButton.h"
#import <objc/runtime.h>
#import <objc/message.h>


#define NAVBAR_CHANGE_POINT 10

@interface MainPageVC ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton *loginBtn;

@property(nonatomic,strong)NSMutableArray<UIImage *> *imagesArray;

@property(nonatomic,strong)NSMutableArray<UIImage *> *pullingArray;

@property(nonatomic,strong)ArticleModel *articleModel;

@property(nonatomic,strong)ArticleVideModel *articleVM;

@property(nonatomic,strong)UISearchBar *searchBar;
//faildBtn
@property(nonatomic,strong)UIButton *failedBtn;
//page
@property(nonatomic,assign)NSInteger page;

@end


@implementation MainPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self refreshData];
}
- (void)goodMethods {
    
}
- (void)handleLeftGesture {
    NSLog(@"用户触发了首页左侧的右滑手势！");
//    do Nothing...
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
#pragma mark TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.articleVM getArticlesNumber];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if([[self.articleVM getBigImageWithIndex:indexPath.section] isEqualToString:@""]){
        //无图
        NoPictureTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noPicCell"];
        if (!cell) {
            cell = [[NoPictureTVCell alloc]init];
        }
        //为cell赋值
        cell.userName.text = [self.articleVM getArticleTitleWithIndex:indexPath.section];
        [UILabel changeWordSpaceForLabel:cell.userName WithSpace:1];
        cell.contentLabel.text = [self.articleVM getContentLabelWithIndex:indexPath.section];
        //设置行间距和字间距
        [UILabel changeLineSpacingForLabel:cell.contentLabel WithSpace:11];
        return cell;
    }else {
        //如果有图
        FirstKindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            cell = [[FirstKindTableViewCell alloc]init];
        }
        //为cell赋值
        cell.userName.text = [self.articleVM getArticleTitleWithIndex:indexPath.section];
        [UILabel changeWordSpaceForLabel:cell.userName WithSpace:1];
        cell.contentLabel.text = [self.articleVM getContentLabelWithIndex:indexPath.section];
        //设置行间距和字间距
        [UILabel changeLineSpacingForLabel:cell.contentLabel WithSpace:11];
//        [cell.contentIV sd_setImageWithURL:[NSURL URLWithString:[self.articleVM getBigImageWithIndex:indexPath.section]] placeholderImage:[UIImage imageNamed:@"test"]];
        [cell.contentIV sd_setImageWithURL:[NSURL URLWithString:[self.articleVM getBigImageWithIndex:indexPath.section]]];
        
        return cell;
    }
    
}

//设置cell的高度自适应
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([[self.articleVM getBigImageWithIndex:indexPath.section] isEqualToString:@""]){
        return [tableView fd_heightForCellWithIdentifier:@"noPicCell" cacheByIndexPath:indexPath configuration:^(NoPictureTVCell *cell) {
            //无图
            NSLog(@"无图");
            cell.userName.text = [self.articleVM getArticleTitleWithIndex:indexPath.section];
            cell.contentLabel.text = [self.articleVM getContentLabelWithIndex:indexPath.section];
            [UILabel changeLineSpacingForLabel:cell.contentLabel WithSpace:11];
        }];
        
    }else {
        return [tableView fd_heightForCellWithIdentifier:@"cell1" cacheByIndexPath:indexPath configuration:^(FirstKindTableViewCell * cell) {
            //如果有图
            NSLog(@"有图");
            cell.userName.text = [self.articleVM getArticleTitleWithIndex:indexPath.section];
            cell.contentLabel.text = [self.articleVM getContentLabelWithIndex:indexPath.section];
            //设置label的行间距
            [UILabel changeLineSpacingForLabel:cell.contentLabel WithSpace:11];
//            [cell.contentIV sd_setImageWithURL:[NSURL URLWithString:[self.articleVM getBigImageWithIndex:indexPath.section]] placeholderImage:[UIImage imageNamed:@"test"]];
            [cell.contentIV sd_setImageWithURL:[NSURL URLWithString:[self.articleVM getBigImageWithIndex:indexPath.section]]];
        }];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleDetailPageVC *dpVC = [[ArticleDetailPageVC alloc]init];
    dpVC.mongold = [self.articleVM getMongoldWithIndex:indexPath.section];
    dpVC.articleId = [self.articleVM getArticleIdWithIndex:indexPath.section];
    dpVC.aType = [self.articleVM getArticleTypeWithIndex:indexPath.section];
    [self.navigationController pushViewController:dpVC animated:YES];

}
//设置cell之间的灰色间隙高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return 0;
    }else {
        return 6;
    }
}

#pragma mark UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    if (scrollView == self.tableView) {
//        UIColor * color = [UIColor colorWithRed:2/255.0 green:119/255.0 blue:255/255.0 alpha:1];
//        CGFloat offsetY = scrollView.contentOffset.y;
//        CGFloat alpha = (64 - offsetY / 3) / 64;
//        if (offsetY > 0) {
//            //上拉
//            //CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY / 3) / 64));
//            [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
//        } else {
//            //下拉
//            [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
//        }
//    }
//}
#pragma mark Tool Methods
- (void)setUpUI {
    [self tableView];
    [self searchBar];
    //隐藏掉navigationBar上的黑线
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];

    //gif刷新方式
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    gifHeader.stateLabel.hidden = YES;
    //设置刷新动画gif
    [gifHeader setImages:self.imagesArray duration:10 forState:MJRefreshStateIdle];
    [gifHeader setImages:self.pullingArray duration:1 forState:MJRefreshStatePulling];
    [gifHeader setImages:self.imagesArray duration:0.7 forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_header = gifHeader;
    
    //上拉加载更多
    MJRefreshAutoGifFooter *gifFooter = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [self loadNextPageData];
    }];
    [gifFooter setImages:self.imagesArray duration:0.3 forState:MJRefreshStateIdle];
    [gifFooter setImages:self.imagesArray duration:0.3 forState:MJRefreshStatePulling];
    [gifFooter setImages:self.imagesArray duration:0.3 forState:MJRefreshStateRefreshing];
    gifFooter.refreshingTitleHidden = YES;
    gifFooter.stateLabel.hidden = YES;
    self.tableView.mj_footer = gifFooter;
    
}
//加载下一页内容
- (void)loadNextPageData {
    self.page ++;
    [self.articleVM loadMoreDataByPage:self.page Size:10 andType:-1 callBack:^(id dic, NSError *err) {
        if (!err) {
            //成功
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        }else {
            //失败
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}

- (void)refreshData {
    self.page = 1;
    [self.articleVM getArticlesInfoByPage:self.page Size:10 andType:-1 callBack:^(NSDictionary * dic,NSError *err) {
        if (!err) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }else {
            //请求失败做些什么？
            [self.tableView.mj_header endRefreshing];
            //请求按钮
            [UIView animateWithDuration:0.3 animations:^{
                self.failedBtn.hidden = NO;
            }];
        }
    }];
}
- (void)goToLogin{
    [self.navigationController presentViewController:[[FQLLoginVC alloc]init] animated:YES completion:nil];
}

- (void)startCountDown {
    [self.failedBtn countDownTime:10 withNomalTitle:@"Click here to refresh!" countDownTitle:@"waiting" finishBlock:^{
        
    } isInteraction:NO];
}

#pragma mark lazy
- (ArticleVideModel *)articleVM {
    if (!_articleVM) {
        _articleVM = [[ArticleVideModel alloc]init];
    }
    return _articleVM;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT + 74) style:UITableViewStyleGrouped];
        //解决cell距wrapperView的偏移
//        CGRect frame = CGRectMake(0, 0, 0,CGFLOAT_MIN);
        CGRect frame = CGRectMake(0, 0, 0,20);
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[FirstKindTableViewCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[NoPictureTVCell class] forCellReuseIdentifier:@"noPicCell"];
        [_tableView setShowsVerticalScrollIndicator:NO];
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
    }
    return _tableView;
}

- (UIButton *)loginBtn {
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_loginBtn];
        
        [_loginBtn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.centerX);
            make.centerY.equalTo(self.view.centerY);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(300);
        }];
        [_loginBtn setTitle:@"Click Me To Login" forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:[UIColor colorWithRed:0 green:154 / 255.0 blue:216 / 255.0 alpha:1]];
    }
    
    [_loginBtn addTarget:self action:@selector(goToLogin) forControlEvents:UIControlEventTouchUpInside];
    return _loginBtn;
    
}

- (NSMutableArray<UIImage *> *)imagesArray {
    if (_imagesArray == nil) {
        _imagesArray = [[NSMutableArray alloc]init];
        for (int i = 1; i <= 60; i ++) {
            //未标题-7_0059_图层-1
            if (i > 50) {
                UIImage *ima = [UIImage imageNamed:[NSString stringWithFormat:@"未标题-7_000%d_图层-%d",(60 - i),i]];
                
                [_imagesArray addObject:ima];
            }else {
                UIImage *ima = [UIImage imageNamed:[NSString stringWithFormat:@"未标题-7_00%d_图层-%d",(60 - i),i]];
                [_imagesArray addObject:ima];
            }
        }
    }
    return _imagesArray;
}

- (NSMutableArray<UIImage *> *)pullingArray {
    if (!_pullingArray) {
        _pullingArray = [[NSMutableArray alloc]init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"未标题-7_0000_图层-60"]];
        [_pullingArray addObject:image];
    }
    return _pullingArray;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 2, SCREEN_WIDTH - 40, 40)];
        
        [self.navigationController.navigationBar addSubview:_searchBar];
        UIView *searchBarFirstSubView = _searchBar.subviews.firstObject;
        UIView *secondSubview = [searchBarFirstSubView.subviews firstObject];
        [secondSubview removeFromSuperview];
        _searchBar.placeholder = @"搜索内容";
//        _searchBar.hidden = YES;
    }
    return _searchBar;
}

- (UIButton *)failedBtn {
    if (!_failedBtn) {
        _failedBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [self.view addSubview:_failedBtn];
    [_failedBtn setTitle:@"Click here to refresh!" forState:UIControlStateNormal];
    [_failedBtn setBackgroundColor:[UIColor brownColor]];
    [_failedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_failedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.centerY.equalTo(self.view.centerY);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(200);
    }];
    _failedBtn.layer.masksToBounds = YES;
    _failedBtn.layer.cornerRadius = 6;
    _failedBtn.hidden = YES;
    [_failedBtn addTarget:self action:@selector(startCountDown) forControlEvents:UIControlEventTouchUpInside];
    
    return _failedBtn;
}


@end
