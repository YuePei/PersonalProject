//
//  ArticleDetailPageVC.h
//  FirstProject
//
//  Created by MacBook Air on 17/11/2.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleDetailPageVC : UIViewController
//articleTitle
@property (nonatomic, strong)NSString *articleTitle;
//mongold
@property (nonatomic , copy) NSString *mongold;
//articleId
@property (nonatomic , assign) NSInteger articleId;
//type
@property (nonatomic , assign) NSInteger aType;
//文章列表页的列表图
@property (nonatomic, strong)NSString *mainPicString;

@end
