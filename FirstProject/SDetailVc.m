//
//  SDetailVc.m
//  FirstProject
//
//  Created by 乐培培 on 2018/3/12.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "SDetailVc.h"
#import "ShareListView.h"
#import "ShareCollectionViewCell.h"

@interface SDetailVc ()

@property (nonatomic, strong)NSArray *dataArray;
//iconsArray
@property (nonatomic, strong)NSArray *iconsArray;

@end

@implementation SDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    ShareListView *view = [[ShareListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - NavBarHeight) shareIcons:self.iconsArray andShareTitles:self.dataArray];
    [self.view addSubview:view];
}

#pragma mark lazy
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:@"微信",
                      @"朋友圈",
                      @"QQ好友",
                      @"QQ空间",
                      @"支付宝",
                      @"微博",
                      @"复制链接", nil];
    }
    return _dataArray;
}

- (NSArray *)iconsArray {
    if (!_iconsArray) {
        _iconsArray = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"weChat"],
                       [UIImage imageNamed:@"朋友圈"],
                       [UIImage imageNamed:@"QQ"],
                       [UIImage imageNamed:@"空间"],
                       [UIImage imageNamed:@"支付宝"],
                       [UIImage imageNamed:@"微博"],
                       [UIImage imageNamed:@"链接"], nil];
    }
    return _iconsArray;
}
@end
