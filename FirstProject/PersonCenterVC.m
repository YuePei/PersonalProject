//
//  PersonCenterVC.m
//  FirstProject
//
//  Created by MacBook Air on 17/11/3.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "PersonCenterVC.h"

@interface PersonCenterVC ()<UITableViewDelegate,UITableViewDataSource,BringBackUserNameDelegate>
//tableVIew
@property(nonatomic,strong)UITableView *tableView;
//middleIV
@property(nonatomic,strong)UIImageView *middleIV;
//bkIV
@property(nonatomic,strong)UIImageView *bkIV;
//userNameLabel
@property(nonatomic,strong)UILabel *userNameLabel;
//introductionLabel
@property(nonatomic,strong)UILabel *introductionLabel;
//headView
@property(nonatomic,strong)UIView *tableViewHeaderView;

@property (nonatomic, assign) BOOL statusBarStyleControl;

@end

@implementation PersonCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACK_COLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpUI];
    [self createMiddleView];
    [self tableView];
    [self bkIV];
    //30 基于iPhone6
    //plus 30 * plus的宽度/6的宽度
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults boolForKey:@"status"]) {
        NSLog(@"He logined!");
        self.userNameLabel.text = [userDefaults objectForKey:@"userName"];
        self.userNameLabel.textColor = [UIColor blackColor];
    }else {
        NSLog(@"Did not login now!");
        self.userNameLabel.text = @"未登录";
        self.userNameLabel.textColor = [UIColor darkGrayColor];
    }
}
#pragma mark Tool Methods
- (void)setUpUI {
    //设置顶部导航栏的icon的颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置barButtonItem的字体大小和颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:21]};
    
    //设置右边的设置控件
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"设置"] style:UIBarButtonItemStylePlain target:self action:@selector(goToSettingPage)];
    [self.navigationItem setRightBarButtonItem:settingItem];
}
- (void)goToSettingPage {
    SettingVC *settingVC = [SettingVC new];
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
}
//设置NavigationBar中间的视图
- (void)createMiddleView {
    UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 58.6666, 44)];
    middleView.backgroundColor = [UIColor clearColor];
    _middleIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 58.666,58.666)];
    _middleIV.backgroundColor = [UIColor redColor];
    _middleIV.image = [UIImage imageNamed:@"fitness"];
    //
    self.middleIV.layer.anchorPoint = CGPointMake(0.5, 0.37931);
    //设置圆角
    _middleIV.layer.masksToBounds = YES;
    _middleIV.layer.cornerRadius = _middleIV.bounds.size.width / 2;
    [middleView addSubview:_middleIV];
    [self.navigationItem setTitleView:middleView];
}
- (UIColor *)randomColor {
    float rColor = arc4random() % 255;
    float gColor = arc4random() % 255;
    float bColor = arc4random() % 255;
    return [UIColor colorWithRed:rColor / 255 green:gColor / 255 blue:bColor / 255 alpha:1];
}

- (void)loginMethod {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //判断是否已经是登录状态
    if(![userDefault boolForKey:@"status"]) {
        //未登录，跳出登录页面
        FQLLoginVC *loginVC = [FQLLoginVC new];
        loginVC.delegate = self;
        [self.navigationController presentViewController:loginVC animated:YES completion:^{
            //
        }];
    }else {
        //已登录，进入个人信息页面
    }
    
}
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont fontWithName:@"AppleGothic" size:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.section == 0 && indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"修改个人资料";
    }else if(indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = @"关于我们";
        
    }else if(indexPath.section == 0 && indexPath.row == 2) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"AppleGothic" size:15];
        cell.detailTextLabel.font = [UIFont fontWithName:@"AppleGothic" size:15];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2lf",(long)[[SDImageCache sharedImageCache] getSize]];
        
        cell.textLabel.text = @"清除缓存";
    }else if(indexPath.section == 0 && indexPath.row == 3) {
        
        cell.textLabel.text = @"帮助与反馈";
    }else if(indexPath.section == 0 && indexPath.row == 4) {
        
        cell.textLabel.text = @"消息通知";
    }else if(indexPath.section == 0 && indexPath.row == 5) {
        
        cell.textLabel.text = @"其他";
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0 && indexPath.row == 0){
        NSLog(@"something else?");
    }else if(indexPath.section == 0 && indexPath.row == 1){
        NSLog(@"something else?");
    }else if(indexPath.section == 0 && indexPath.row == 2){
        NSLog(@"something else?");
    }else if(indexPath.section == 0 && indexPath.row == 3){
        NSLog(@"something else?");
    }else if(indexPath.section == 0 && indexPath.row == 4){
        NSLog(@"something else?");
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_HEIGHT / 15;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offsetY = scrollView.contentOffset.y;
    //设置圆图的缩放
//    if (offsetY > 0 && offsetY <= 150) {
//        self.middleIV.transform = CGAffineTransformMakeScale(1- offsetY / 300, 1- offsetY / 300);
//    }else if(offsetY > 150) {
//        self.middleIV.transform = CGAffineTransformMakeScale(0.45, .45);
//    }else if (offsetY < 0 && offsetY >= -150) {
//        self.middleIV.transform = CGAffineTransformMakeScale(1 + offsetY / -300, 1 + offsetY / -300);
//    }else if (offsetY < -150) {
//        self.middleIV.transform = CGAffineTransformMakeScale(1.5, 1.5);
//    }
    //在这里offsetY基础偏移是-136，而不是0
    if (offsetY > -136 && offsetY <= 14) {
        self.middleIV.transform = CGAffineTransformMakeScale(1- (offsetY + 136) / 300, 1- (offsetY + 136) / 300);
    }else if(offsetY > 14) {
        self.middleIV.transform = CGAffineTransformMakeScale(0.45, .45);
    }else if (offsetY < -136 && offsetY >= -286) {
        self.middleIV.transform = CGAffineTransformMakeScale(1 + (offsetY + 136) / -300, 1 + (offsetY + 136) / -300);
    }else if (offsetY < -286) {
        self.middleIV.transform = CGAffineTransformMakeScale(1.5, 1.5);
    }
    //设置背景图的缩放
    if (offsetY < 0) {
        self.bkIV.transform = CGAffineTransformMakeScale(-offsetY / 500 + 1, -offsetY / 500 + 1);
    }
    
}

- (void)bringUserName:(NSString *)userName {
    self.userNameLabel.text = userName;
}
#pragma mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    }
    [self.view addSubview:_tableView];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    [_tableView registerClass:[cell class] forCellReuseIdentifier:@"cell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    //去掉cell之间的横线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = [UIColor grayColor];
    //设置顶部的偏移量
    _tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(136, 0, 0, 0);
    _tableView.tableHeaderView = [self tableViewHeaderView];
    return _tableView;
}

- (UIImageView *)bkIV {
    if (!_bkIV) {
        _bkIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.9)];
    }
    [self.view insertSubview:_bkIV belowSubview:self.tableView];
    _bkIV.image = [UIImage imageNamed:@"fitness1"];
    return _bkIV;
}
- (UIView *)tableViewHeaderView {
    if (!_tableViewHeaderView) {
        _tableViewHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        //毛玻璃效果
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithFrame:_tableViewHeaderView.frame];
        visualView.effect = effect;
        visualView.alpha = 0.6;
        [_tableViewHeaderView addSubview:visualView];
        [self userNameLabel];
        [self introductionLabel];
    }
    
    return _tableViewHeaderView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc]init];
        //用户名
        _userNameLabel = [[UILabel alloc]init];
        [_userNameLabel setFont:[UIFont fontWithName:@"AppleGothic" size:25]];
        [self.tableViewHeaderView addSubview:_userNameLabel];
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.mas_equalTo(20);
        }];
        //添加手势，未登录时，弹出登录页面
        _userNameLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginMethod)];
        [_userNameLabel addGestureRecognizer:tapGes];
    }
    return _userNameLabel;
}
- (UILabel *)introductionLabel {
    if (!_introductionLabel) {
        _introductionLabel = [[UILabel alloc]init];
        //简介
        [self.tableViewHeaderView addSubview:_introductionLabel];
        [_introductionLabel setFont:[UIFont fontWithName:@"AppleGothic" size:16]];
        _introductionLabel.textColor = [self randomColor];
        [_introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userNameLabel.mas_left);
            make.top.mas_equalTo(self.userNameLabel.mas_bottom).mas_offset(10);
            make.right.mas_equalTo(-20);
        }];
        _introductionLabel.numberOfLines = 2;
        _introductionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _introductionLabel.text = @"She's a good woman!BalabalaBal abalaBalab alaBalabal aBalabalaBalabala BalabalaBal abalaBal abalaBal abalaBalabalaBal abalaB alabala Balaba laBalabala";
    }
    
    
    return _introductionLabel;
}
@end
