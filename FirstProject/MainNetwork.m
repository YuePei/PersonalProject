//
//  MainNetwork.m
//  FirstProject
//
//  Created by MacBook Air on 2017/12/14.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "MainNetwork.h"

@implementation MainNetwork

+ (void)getArticleListFromInternetByPage:(NSInteger)page Size:(NSInteger)size andType:(NSInteger)type callBackBlock:(void (^)(id obj,NSError *error))callBackBlock {
    
//    https://uat.faqile.com/api/article/list?page=1&size=5&type=-1
    [FQLHttpTools get:[NSString stringWithFormat:@"%@%@?page=%ld&size=%ld&type=%ld",BASIC_URL,ARTICLE_BASIC_URL,page,size,type] parameters:nil success:^(NSDictionary * obj) {
        
        callBackBlock(obj,nil);
        
    } failure:^(NSError *error) {
        callBackBlock(nil,error);
    }];
}

+ (void)getArticleDetailInfoByMongold:(NSString *)mongold articleId:(NSInteger)articleId andType:(NSInteger)type callBack:(void (^)(id, NSError *))callBock {
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]init];
    //加载在window上
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:hud];
    //让屏幕其他地方可点击--------------重要
    hud.userInteractionEnabled = NO;
    //设置样式
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *imaV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30 )];
    SetViewRadius(imaV, 15);
    //设置动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basicAnimation.toValue = @(M_PI * 2);
    basicAnimation.repeatCount = 10;
    basicAnimation.duration = 1.f;
    [imaV.layer addAnimation:basicAnimation forKey:nil];
    imaV.image = [UIImage imageNamed:@"加载进度"];
    hud.customView = imaV;
    //透明度
    hud.opacity = 1;
    //展示
    [hud show:YES];
    hud.detailsLabelText = @"Requesting data...";
    hud.labelText = @"Dear User";
    hud.removeFromSuperViewOnHide = YES;
    
    [FQLHttpTools get:[NSString stringWithFormat:@"%@%@?mongoId=%@&articleId=%ld&type=%ld",BASIC_URL,ARTICLE_DETAIL_URL,mongold,articleId,type] parameters:nil success:^(id obj) {
        [hud hide:YES];
        callBock(obj,nil);
    } failure:^(NSError *error) {
        [hud hide:YES];
        callBock(nil,error);
    }];
}

@end
