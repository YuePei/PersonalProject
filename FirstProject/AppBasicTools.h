//
//  AppBasicTools.h
//  FirstProject
//
//  Created by MacBook Air on 2017/12/14.
//  Copyright © 2017年 BJ. All rights reserved.
//

#ifndef AppBasicTools_h
#define AppBasicTools_h

//状态栏高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏高度
#define kNavBarHeight 44.0
//tabbar高度
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

//屏幕宽高
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//适配
#define SCREEN_PROPORTION [UIScreen mainScreen].bounds.size.width / 375.0

//背景颜色，浅灰色
#define BACK_COLOR [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1]


//https://uat.faqile.com/api/article/list?page=1&size=5&type=-1
#define BASIC_URL @"https://uat.faqile.com/api/"
//文章列表字段
#define ARTICLE_BASIC_URL @"article/list"
//文章详情页字段
#define ARTICLE_DETAIL_URL @"article/detail"


#endif /* AppBasicTools_h */
