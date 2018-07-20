//
//  SettingVC.m
//  FirstProject
//
//  Created by 乐培培 on 2018/3/14.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "SettingVC.h"
#import "NewCommunityVC.h"

@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BackgroundColor;
    [self tableView];
    
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }else {
        return 10;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults boolForKey:@"status"]) {
            return 1;
        }else {
            return 0;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"修改密码";
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = @"关于我们";
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        cell.textLabel.text = @"去评分";
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults boolForKey:@"status"]) {
            cell.textLabel.text = @"退出登录";
            cell.textAlignment = NSTextAlignmentCenter;
            cell.textColor = [UIColor redColor];
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self.navigationController pushViewController:[NewCommunityVC new] animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        //跳转到App Store评价
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1253355672?mt=8"]];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:NO forKey:@"status"];
        [userDefaults synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    }
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    //去掉cell之间的横线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.separatorColor = [UIColor lightGrayColor];
    
//    CGRect frame = CGRectMake(0, 0, 0,CGFLOAT_MIN);
//    CGRect frame = CGRectMake(0, 0, 0,10);
//    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:frame];
    
    return _tableView;
}

@end
