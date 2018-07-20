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
#import "FMDB.h"
#import "MainPageHeaderView.h"

#define NAVBAR_CHANGE_POINT 10

@interface MainPageVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray<UIImage *> *imagesArray;

@property(nonatomic,strong)NSMutableArray<UIImage *> *pullingArray;

@property(nonatomic,strong)ArticleModel *articleModel;

@property(nonatomic,strong)ArticleVideModel *articleVM;

@property(nonatomic,strong)UISearchBar *searchBar;
//page
@property(nonatomic,assign)NSInteger page;
//FMDB
@property (nonatomic, strong)FMDatabase *db;

@end


@implementation MainPageVC

static int networkSituation = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self configFMDB];
    [self refreshData];
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
    if (networkSituation) {
        return [self.articleVM getArticlesNumber];
    }else {
        return [self getTitlesFromFMDB].count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (networkSituation) {
        if([[self.articleVM getBigImageWithIndex:indexPath.section] isEqualToString:@""]){
            //无图
            NSLog(@"...................无图...................");
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
            NSLog(@"...................有图...................");
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
            [cell.contentIV sd_setImageWithURL:[NSURL URLWithString:[self.articleVM getBigImageWithIndex:indexPath.section]]];
//            [cell.contentIV setImage:[UIImage imageNamed:@"4"]];
            
            return cell;
        }
    }else {
        //网络不好,用本地数据,采用无图cell
        NoPictureTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noPicCell"];
        if (!cell) {
            cell = [[NoPictureTVCell alloc]init];
        }
        //为cell赋值
        NSLog(@"...................网络不好...................");
        if ([self getTitlesFromFMDB].count > 0 && [self getAbstractFromFMDB].count > 0) {
            cell.userName.text = [self getTitlesFromFMDB][indexPath.section];
            cell.contentLabel.text = [self getAbstractFromFMDB][indexPath.section];
            //设置行间距和字间距
            [UILabel changeWordSpaceForLabel:cell.userName WithSpace:1];
            [UILabel changeLineSpacingForLabel:cell.contentLabel WithSpace:11];
        }
        
        return cell;
    }
}

//设置cell的高度自适应
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(networkSituation) {
        if([[self.articleVM getBigImageWithIndex:indexPath.section] isEqualToString:@""]){
            return [tableView fd_heightForCellWithIdentifier:@"noPicCell" cacheByIndexPath:indexPath configuration:^(NoPictureTVCell *cell) {
                //无图
                cell.userName.text = [self.articleVM getArticleTitleWithIndex:indexPath.section];
                cell.contentLabel.text = [self.articleVM getContentLabelWithIndex:indexPath.section];
                [UILabel changeLineSpacingForLabel:cell.contentLabel WithSpace:11];
            }];
            
        }else {
            return [tableView fd_heightForCellWithIdentifier:@"cell1" cacheByIndexPath:indexPath configuration:^(FirstKindTableViewCell * cell) {
                //如果有图
                cell.userName.text = [self.articleVM getArticleTitleWithIndex:indexPath.section];
                cell.contentLabel.text = [self.articleVM getContentLabelWithIndex:indexPath.section];
                //设置label的行间距
                [UILabel changeLineSpacingForLabel:cell.contentLabel WithSpace:11];
                //            [cell.contentIV sd_setImageWithURL:[NSURL URLWithString:[self.articleVM getBigImageWithIndex:indexPath.section]] placeholderImage:[UIImage imageNamed:@"test"]];
                [cell.contentIV sd_setImageWithURL:[NSURL URLWithString:[self.articleVM getBigImageWithIndex:indexPath.section]]];
            }];
        }
    }else {
        return [tableView fd_heightForCellWithIdentifier:@"noPicCell" cacheByIndexPath:indexPath configuration:^(NoPictureTVCell *cell) {
            //无图
            if ([self getTitlesFromFMDB].count > 0 && [self getAbstractFromFMDB].count > 0) {
                cell.userName.text = [self getTitlesFromFMDB][indexPath.section];
                cell.contentLabel.text = [self getAbstractFromFMDB][indexPath.section];
                //设置行间距和字间距
                [UILabel changeWordSpaceForLabel:cell.userName WithSpace:1];
                [UILabel changeLineSpacingForLabel:cell.contentLabel WithSpace:11];
            }
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleDetailPageVC *dpVC = [[ArticleDetailPageVC alloc]init];
    if (networkSituation) {
        dpVC.mongold = [self.articleVM getMongoldWithIndex:indexPath.section];
        dpVC.articleId = [self.articleVM getArticleIdWithIndex:indexPath.section];
        dpVC.aType = [self.articleVM getArticleTypeWithIndex:indexPath.section];
    }else {
        dpVC.mongold = [self getMongoIdFromFMDB][indexPath.section];
        dpVC.articleId = [[self getArticleIdFromFMDB][indexPath.section] floatValue];
        dpVC.aType = [[self getATypeFromFMDB][indexPath.section] floatValue];
    }
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

#pragma mark FMDB
//配置FMDB
- (void)configFMDB {
    
    NSString *sqlFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"TodayNextYear.sqlite"];
    if(!_db) {
        _db = [FMDatabase databaseWithPath:sqlFilePath];
    }
    if ([self.db open]) {
        NSLog(@"Open database succeed!...................");
//        BOOL success = [self.db executeUpdate:@"create table if not exists articles (id integer PRIMARY KEY AUTOINCREMENT,authorName text not null,abstractWords text,mongoId text,articleId float,aType float)"];
        BOOL success = [self.db executeUpdate:@"create table if not exists articles (id integer PRIMARY KEY AUTOINCREMENT,authorName text not null,abstractWords text,mongoId text,articleId double,aType double)"];
        if (success) {
            NSLog(@"Create table succeed!...................");
        }else {
            NSLog(@"Create table failed!...................");
        }
    }else {
        NSLog(@"Open database failed!...................");
    }
}

- (NSArray *)getTitlesFromFMDB {
    FMResultSet *result = [self.db executeQuery:@"select * from articles"];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        NSString *nameString = [result stringForColumn:@"authorName"];
        [array addObject:nameString];
    }
    return array;
}

- (NSArray *)getAbstractFromFMDB {
    FMResultSet *result = [self.db executeQuery:@"select * from articles"];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        NSString *abstract = [result stringForColumn:@"abstractWords"];
        [array addObject:abstract];
    }
    return array;
}

- (NSArray *)getMongoIdFromFMDB {
    FMResultSet *result = [self.db executeQuery:@"select * from articles"];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        NSString *abstract = [result stringForColumn:@"mongoId"];
        [array addObject:abstract];
    }
    return array;
}

- (NSArray *)getArticleIdFromFMDB {
    FMResultSet *result = [self.db executeQuery:@"select * from articles"];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        NSInteger abstract = [result longForColumn:@"articleId"];
        [array addObject:@(abstract)];
    }
    return array;
}

- (NSArray *)getATypeFromFMDB {
    FMResultSet *result = [self.db executeQuery:@"select * from articles"];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        NSInteger abstract = [result longForColumn:@"aType"];
        [array addObject:@(abstract)];
    }
    return array;
}

- (void)setNoSignal {
    networkSituation = 0;
    [self.tableView reloadData];
}

#pragma mark ToolMethods
- (void)setUpUI {
    [self tableView];
    [self searchBar];
    //gif刷新方式
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
//    gifHeader.stateLabel.hidden = YES;
    [gifHeader setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    //设置刷新动画gif
//    [gifHeader setImages:self.imagesArray duration:10 forState:MJRefreshStateIdle];
//    [gifHeader setImages:self.pullingArray duration:1 forState:MJRefreshStatePulling];
//    [gifHeader setImages:self.imagesArray duration:0.7 forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = gifHeader;
    
    //上拉加载更多
    MJRefreshAutoGifFooter *gifFooter = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [self loadNextPageData];
    }];
//    [gifFooter setImages:self.imagesArray duration:0.3 forState:MJRefreshStateIdle];
//    [gifFooter setImages:self.imagesArray duration:0.3 forState:MJRefreshStatePulling];
//    [gifFooter setImages:self.imagesArray duration:0.3 forState:MJRefreshStateRefreshing];
//    gifFooter.refreshingTitleHidden = YES;
//    gifFooter.stateLabel.hidden = YES;
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
            self.page --;
        }
    }];
}

- (void)refreshData {
    self.page = 1;
    [self.articleVM getArticlesInfoByPage:self.page Size:10 andType:-1 callBack:^(NSDictionary * dic,NSError *err) {
        if (!err) {
            [self.tableView.mj_header endRefreshing];
            NSLog(@"---网络请求完毕-----------------------刷新");
            [self.tableView reloadData];
            //缓存数据
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //1.删除过去的数据,清表
                [self.db executeUpdate:@"DELETE FROM articles"];
                //2.插入新数据数据
                for (int i = 0; i < 10; i++) {
                    BOOL success1 = [self.db executeUpdate:@"insert into articles(authorName, abstractWords, mongoId, articleId, aType) values(?, ?, ?, ?, ?);",[self.articleVM getArticleTitleWithIndex:i], [self.articleVM getContentLabelWithIndex:i], [self.articleVM getMongoldWithIndex:i], @([self.articleVM getArticleIdWithIndex:i]), @([self.articleVM getArticleTypeWithIndex:i])];
                    if (success1) {
                        NSLog(@"Insert data succeed!");
                    }
                }
            });
            
        }else {
            NSLog(@"refresh failed");
            //请求失败做些什么？
            [self.tableView.mj_header endRefreshing];
            //列表显示从FMDB中拿到的数据,可以通过通知的方式,告知代理方法,展示本地数据
            [self setNoSignal];
        }
    }];
}

//裁剪图片
- (UIImage *)cutImageWithImage:(UIImage *)image targetSize:(CGSize )targetSize {
    
    UIImage *image1 = image;
    //原图片尺寸
    CGFloat imageWidth = image1.size.width;
    CGFloat imageHeight = image1.size.height;
    //目标尺寸
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    //最终比例
    CGFloat scaleFactor = 0;
    CGPoint startPoint = CGPointMake(0, 0);
    
    //如果图片是竖着的，即图片高度大于宽度
    if (imageWidth < imageHeight) {
        CGFloat tempW = targetWidth;
        CGFloat tempH = targetHeight;
        
        targetWidth = tempH;
        targetHeight = tempW;
    }
    //如果图片大小 < 目标图片大小, 那就返回该图片,不做切割
    if (targetWidth > imageWidth && targetHeight > imageHeight) {
        return image1;
    }
    if (CGSizeEqualToSize(CGSizeMake(imageWidth, imageHeight), CGSizeMake(targetWidth, targetHeight)) == NO) {
        //如果两个尺寸不同则可以开始切割
        CGFloat widthFactor = targetWidth / imageWidth;
        CGFloat heightFactor = targetHeight / imageHeight;
        if (widthFactor < 1 && heightFactor < 1) {
            //源图片尺寸宽高都比目标尺寸的宽高都大
            //判断哪个比例更小, 按照更小的比例
            if (widthFactor < heightFactor) {
                scaleFactor = widthFactor;
            }else {
                scaleFactor = heightFactor;
            }
        }else if (widthFactor > 1 && heightFactor < 1) {
            //
            scaleFactor = widthFactor;
        }else if(widthFactor < 1 && heightFactor > 1) {
            //
            scaleFactor = heightFactor;
        }else {
            //目标尺寸的宽高都大于原始图片的尺寸的宽高, 建议不要做放大处理, 图片易失真
        }
    }
    targetHeight = scaleFactor * imageHeight;
    targetWidth = scaleFactor * imageWidth;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin= startPoint;
    thumbnailRect.size.width = targetWidth;
    thumbnailRect.size.height = targetHeight;
    [image1 drawInRect:thumbnailRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
    
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
        
        MainPageHeaderView *view = [[MainPageHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        view.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView = view;
    }
    return _tableView;
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
        
//        [self.navigationController.navigationBar addSubview:_searchBar];
        UIView *searchBarFirstSubView = _searchBar.subviews.firstObject;
        UIView *secondSubview = [searchBarFirstSubView.subviews firstObject];
        [secondSubview removeFromSuperview];
        _searchBar.placeholder = @"搜索内容";
//        _searchBar.hidden = YES;
    }
    return _searchBar;
}


@end
