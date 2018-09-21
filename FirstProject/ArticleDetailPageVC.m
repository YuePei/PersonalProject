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
#import "CommentView.h"
#import "ShareListView.h"
#import "UIView+Operations.h"
#import "UIWebView+Tools.h"
#import "UIView+Removable.h"


@interface ArticleDetailPageVC ()<UITextViewDelegate,UITextFieldDelegate>

//articleDetailModel
@property (nonatomic , strong) ArticleDetailModel *articleDetailModel;
//articleDataModel
@property (nonatomic , strong) ArticleDataModel *dataModel;
//WKWebView
@property (nonatomic , strong) UIWebView *wkWebView;
//bottomView
@property (nonatomic, strong)BottomView *bottomView;
//commentView
@property (nonatomic, strong)CommentView *commentView;
//分享控件
@property (nonatomic, strong)ShareListView *shareView;

@end

@implementation ArticleDetailPageVC
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11, *)) {
        self.wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"好文";
    [self wkWebView];
    [self bottomView];
    [self getDetailPageData];
    [self commentView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (UIImage *)screenShotWithFrame:(CGRect )imageRect {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT), NO, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShotImage;
}

#pragma mark ShareViewDelegate
- (UIImage *)getCurrentScreenShot {
    return [self screenShotWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

#pragma mark tools Methods
//调用系统的分享功能
- (void)systemShare{
    //拿到数据才能分享, 没有数据不分享
    if (self.dataModel.originalLink && self.articleTitle && self.mainPicString) {
        NSDictionary *dic = @{@"title": self.articleTitle, @"link":self.dataModel.originalLink, @"imageString":self.mainPicString};
        ShareListView *shareView = [[ShareListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                            shareIcons:@[[UIImage imageNamed:@"weChat"],
                                                                         [UIImage imageNamed:@"朋友圈"],
                                                                         [UIImage imageNamed:@"QQ"],
                                                                         [UIImage imageNamed:@"空间"],
                                                                         [UIImage imageNamed:@"支付宝"],
                                                                         [UIImage imageNamed:@"微博"],
                                                                         [UIImage imageNamed:@"链接"],
                                                                         [UIImage imageNamed:@"更多"]]
                                                           ShareTitles:@[@"微信",@"朋友圈",@"QQ好友",@"QQ空间",@"支付宝",@"微博",@"复制链接", @"更多"]
                                                           andCardInfo:dic];
        UIImage *img = [self screenShotWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [shareView setScreenShotImage:img];
        [shareView getVc:self];
        [[UIApplication sharedApplication].keyWindow addSubview:shareView];
    }
}

- (void)getDetailPageData {
    //拿到数据
    [MainNetwork getArticleDetailInfoByMongold:self.mongold articleId:self.articleId andType:self.aType callBack:^(NSDictionary * dic, NSError *error) {
        NSLog(@"----:%@",dic);
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


- (void)likeFunction {
    if ([self.bottomView.likeBtn.imageView.image isEqual: [UIImage imageNamed:@"喜欢"]]) {
        [self.bottomView.likeBtn setImage:[UIImage imageNamed:@"喜欢1"] forState:UIControlStateNormal];
    }else {
        [self.bottomView.likeBtn setImage:[UIImage imageNamed:@"喜欢"] forState:UIControlStateNormal];
    }
}

- (void)collectFunction {
    if ([self.bottomView.collectBtn.imageView.image isEqual: [UIImage imageNamed:@"收藏"]]) {
        [self.bottomView.collectBtn setImage:[UIImage imageNamed:@"收藏1"] forState:UIControlStateNormal];
    }else {
        [self.bottomView.collectBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    }
}

- (void)commentFunction {
    [self.commentView.contentTextView becomeFirstResponder];
}

- (void)resignContentTextViewFirstResponser {
    [self.commentView.contentTextView resignFirstResponder];
}

- (void)keyBoardWillShow:(NSNotification *)notification
{
    //获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:notification.userInfo];
    // 获取键盘高度
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 定义好动作
    void (^animation)(void) = ^void(void) {
        self.commentView.transform = CGAffineTransformMakeTranslation(0, -(keyBoardHeight + 210));
    };
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
}

- (void)keyBoardWillHide:(NSNotification *)notificaiton
{
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:notificaiton.userInfo];
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 定义好动作
    void (^animation)(void) = ^void(void) {
        self.commentView.transform = CGAffineTransformIdentity;
    };
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
        self.commentView.contentTextView.text = @"";
    } else {
        animation();
    }
}

//计算输入框内的文字高度
- (CGFloat)textHeightForTextView:(UITextView *)textView withTextString:(NSString *)textString {
    CGSize size = CGSizeMake(self.commentView.contentTextView.contentSize.width, CGFLOAT_MAX);
    CGRect rect = [textString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil];
    if (rect.size.height < textView.frame.size.height) {
        return textView.frame.size.height;
    }else {
        return rect.size.height;
    }
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
        [self.bottomView.superview layoutIfNeeded];
        [_wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(- CGRectGetHeight(self.bottomView.frame));
        }];
        _wkWebView.scrollView.showsHorizontalScrollIndicator = NO;
        _wkWebView.backgroundColor = [UIColor whiteColor];
    }
    return _wkWebView;
}

- (BottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[BottomView alloc]init];
        [self.view insertSubview:_bottomView aboveSubview:self.wkWebView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(50 * SCREEN_PROPORTION);
        }];
        _bottomView.backgroundColor = BackgroundColor;
        [_bottomView.collectBtn addTarget:self action:@selector(collectFunction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.likeBtn addTarget:self action:@selector(likeFunction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.shareBtn addTarget:self action:@selector(systemShare) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.commentBtn addTarget:self action:@selector(commentFunction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

//评论框
- (UIView *)commentView {
    if (!_commentView) {
        _commentView = [[CommentView alloc]init];
        [self.view addSubview:_commentView];
        [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(SCREEN_HEIGHT);
            make.height.mas_equalTo(150);
        }];
        _commentView.backgroundColor = BackgroundColor;
        _commentView.contentTextView.delegate = self;
        [_commentView.submitButton addTarget:self action:@selector(resignContentTextViewFirstResponser) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentView;
}





#pragma mark UITextViewDelegate
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    if (textView.frame.size.height > 200) {
//        return NO;
//    }else {
//        CGRect frame = textView.frame;
//        NSLog(@"-------------------------: %lf",frame.origin.y);
//        float height = [self textHeightForTextView:textView withTextString:textView.text];
//        //偏移量
//        CGFloat offsetY = height - frame.size.height;
//        frame.size.height += offsetY;
//        frame.origin.y -= offsetY;
//
//        CGRect commentViewRect = self.commentView.frame;
//        commentViewRect.origin.y -= offsetY;
//        commentViewRect.size.height += offsetY;
//        [UIView animateWithDuration:CGFLOAT_MIN animations:^{
//            textView.frame = frame;
//            self.commentView.frame = commentViewRect;
//        }];
//        return YES;
//    }
//}

//-(void)textViewDidChange:(UITextView *)textView{
//    static CGFloat maxHeight =200.0f;
//    CGRect frame = textView.frame;
//    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
//    CGSize size = [textView sizeThatFits:constraintSize];
//    if(size.height<=frame.size.height) {
//        size.height = 150 - 30 - 10- 30;
//    }else{
//        if(size.height >= maxHeight){
//            size.height = maxHeight;
//            textView.scrollEnabled = YES;// 允许滚动
//        }
//        else{
//            textView.scrollEnabled = NO;// 不允许滚动
//        }
//    }
//    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
//}
@end

