//
//  ArticleDetailPageVC.m
//  FirstProject
//
//  Created by MacBook Air on 17/11/2.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "ArticleDetailPageVC.h"
#import <WebKit/WebKit.h>
#import "BottomView.h"

@interface ArticleDetailPageVC ()

//articleDetailModel
@property (nonatomic , strong) ArticleDetailModel *articleDetailModel;
//articleDataModel
@property (nonatomic , strong) ArticleDataModel *dataModel;
//WKWebView
@property (nonatomic , strong) UIWebView *wkWebView;
//bottomView
@property (nonatomic, strong)BottomView *bottomView;


@end

@implementation ArticleDetailPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBarAndGoBackWithGesture];
    [self wkWebView];
    [self bottomView];
    //毛玻璃效果
//    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
//    effectView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    effectView.alpha = 0.3;
//    [self.view addSubview:effectView];
    
    [self getDetailPageData];
}

- (void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}
//调用系统的分享功能
- (void)systemShare{
    
    NSArray *images = @[[UIImage imageNamed:@"beauty"]];
    UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:images applicationActivities:nil];
    [self.navigationController presentViewController:activityController animated:YES completion:nil];
}

#pragma mark tools Methods
- (void)getDetailPageData {
    //拿到数据
    [MainNetwork getArticleDetailInfoByMongold:self.mongold articleId:self.articleId andType:self.aType callBack:^(NSDictionary * dic, NSError *error) {
        
        self.articleDetailModel = [ArticleDetailModel mj_objectWithKeyValues:dic];
        self.dataModel = self.articleDetailModel.data;
        [self shoHtmlStringInWebView];
    }];
    
}
- (void)shoHtmlStringInWebView {
//    NSString *htmlStirng = [NSString stringWithFormat:@"<!DOCTYPE HTML><html><body>%@</body></html>",self.dataModel.htmlContent];
    
    NSString *htmlStirng = [NSString stringWithFormat:@"<html> \n"
     "<head> \n"
     "<style type=\"text/css\"> \n"
     "body {font-size:17px;}\n"
     "p{letter-spacing: 2px;line-height:30px;color:gray;}"
     "</style> \n"
     "</head> \n"
     "<body>"
     "<script type='text/javascript'>"
     "window.onload = function(){\n"
     "var $img = document.getElementsByTagName('img');\n"
     "for(var p in  $img){\n"
     " $img[p].style.width = '100%%';\n"
     "$img[p].style.height ='auto'\n"
     "}\n"
     "}"
     "</script>%@"
     "</body>"
     "</html>",self.dataModel.htmlContent];
    [self.wkWebView loadHTMLString:htmlStirng baseURL:nil];
}

- (void)setNavigationBarAndGoBackWithGesture {
    self.title = @"好文";
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"分享"] style:UIBarButtonItemStylePlain target:self action:@selector(systemShare)];
    NSArray *itemArray = [NSArray arrayWithObjects:shareItem, nil];
    [self.navigationItem setRightBarButtonItems:itemArray];
}

- (void)clickToGetUserName {
    
}

#pragma mark lazy
- (ArticleDetailModel *)articleDetailModel {
    if (!_articleDetailModel) {
        _articleDetailModel = [[ArticleDetailModel alloc]init];
    }
    return _articleDetailModel;
}
- (ArticleDataModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[ArticleDataModel alloc]init];
    }
    return _dataModel;
}
- (UIWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[UIWebView alloc]init];
        [self.view addSubview:_wkWebView];
        [_wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        _wkWebView.scrollView.showsHorizontalScrollIndicator = NO;
        _wkWebView.backgroundColor = [UIColor whiteColor];
    }
    return _wkWebView;
}

- (BottomView *)bottomView {
    if (!_bottomView) {
//        _bottomView = [[NSBundle mainBundle] loadNibNamed:@"BottomView" owner:self options:nil].firstObject;
//        [_bottomView setFrame:CGRectMake(0, SCREEN_HEIGHT - 50 * SCREEN_PROPORTION - 64, SCREEN_WIDTH, 50 * SCREEN_PROPORTION)];
        _bottomView = [[BottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50 * SCREEN_PROPORTION - 64, SCREEN_WIDTH, 50 * SCREEN_PROPORTION)];
        [self.view insertSubview:_bottomView aboveSubview:self.wkWebView];
        _bottomView.backgroundColor = BACK_COLOR;
    }
    return _bottomView;
}
@end
