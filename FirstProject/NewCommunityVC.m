//
//  NewCommunityVC.m
//  FirstProject
//
//  Created by Peyton on 2018/4/25.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "NewCommunityVC.h"
#import "SlideTableViewCell.h"


@interface NewCommunityVC ()<UITableViewDelegate,UITableViewDataSource>
//tableView
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation NewCommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self tableView];
}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SlideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"slideTableViewCell"];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130 * SCREEN_PROPORTION + 20 + 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0000000000001;
    }else {
        return 4;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}
#pragma mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SlideTableViewCell class] forCellReuseIdentifier:@"slideTableViewCell"];
    }
    return _tableView;
}

@end
