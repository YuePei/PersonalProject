//
//  PersonCenterVC.m
//  FirstProject
//
//  Created by MacBook Air on 17/11/3.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "PersonCenterVC.h"
#import "PCTableViewCell.h"

@interface PersonCenterVC ()<UITableViewDelegate,UITableViewDataSource,BringBackUserNameDelegate>
//tableVIew
@property(nonatomic,strong)UITableView *tableView;
//headView
@property(nonatomic,strong)UIView *tableViewHeaderView;
//背景大图
@property (nonatomic, strong)UIImageView *topBigIV;

@property (nonatomic, assign) BOOL statusBarStyleControl;
//头像
@property (nonatomic, strong)UIImageView *headPortraitIV;
//用户名
@property (nonatomic, strong)UILabel *userNameLabel;
//用户简介
@property (nonatomic, strong)UILabel *userIntroductionLabel;

@end

@implementation PersonCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self setUpUI];
    [self tableView];
    [self topBigIV];
    [self headPortraitIV];
    [self userNameLabel];
    [self userIntroductionLabel];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    if ([userDefaults boolForKey:@"status"]) {
//        NSLog(@"He logined!");
//        self.userNameLabel.text = [userDefaults objectForKey:@"userName"];
//        self.userNameLabel.textColor = [UIColor blackColor];
//    }else {
//        NSLog(@"Did not login now!");
//        self.userNameLabel.text = @"未登录";
//        self.userNameLabel.textColor = [UIColor darkGrayColor];
//    }
}
#pragma mark Tool Methods
- (void)setUpUI {
    //设置右边的设置控件
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"设置"] style:UIBarButtonItemStylePlain target:self action:@selector(goToSettingPage)];
    [self.navigationItem setRightBarButtonItem:settingItem];
}

- (void)goToSettingPage {
    SettingVC *settingVC = [SettingVC new];
    [self.navigationController pushViewController:settingVC animated:YES];
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
    PCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pcCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PCTableViewCell" owner:self options:nil].firstObject;
    }
    cell.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.section == 0 && indexPath.row == 0) {
        
        cell.iconIV.image = [UIImage imageNamed:@"消息"];
        cell.titleLabel.text = @"消息";
    }else if(indexPath.section == 0 && indexPath.row == 1) {
        
        cell.titleLabel.text = @"购物车";
        cell.iconIV.image = [UIImage imageNamed:@"关于我们"];
    }else if(indexPath.section == 0 && indexPath.row == 2) {
        
        cell.rightLabel.hidden = NO;
        cell.rightLabel.text = [NSString stringWithFormat:@"%.2ld",(long)[[SDImageCache sharedImageCache] getSize]];
        cell.titleLabel.text = @"收藏";
        cell.iconIV.image = [UIImage imageNamed:@"清除"];
    }else if(indexPath.section == 0 && indexPath.row == 3) {

        cell.titleLabel.text = @"收获喜欢";
        cell.iconIV.image = [UIImage imageNamed:@"消息"];
    }else if(indexPath.section == 0 && indexPath.row == 4) {

        cell.titleLabel.text = @"清除缓存";
        cell.iconIV.image = [UIImage imageNamed:@"帮助"];
    }else if(indexPath.section == 0 && indexPath.row == 5) {

        cell.titleLabel.text = @"其他";
        cell.iconIV.image = [UIImage imageNamed:@"其它"];
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
    return 55;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offsetY = scrollView.contentOffset.y;
    if (offsetY < -300) {
        [self.topBigIV updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(offsetY);
            make.height.mas_equalTo(-offsetY);
        }];
        [self.topBigIV layoutIfNeeded];

//        下面是用frame的形式
//        CGRect rect = self.topBigIV.frame;
//        rect.origin.y = offsetY;
//        rect.size.height = -offsetY;
//        self.topBigIV.frame = rect;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

#pragma mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        [_tableView registerClass:[PCTableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        //去掉cell之间的横线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //设置顶部的偏移量
        _tableView.contentInset = UIEdgeInsetsMake(300, 0, 0, 0);
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        
    }
    return _tableView;
}

- (UIImageView *)topBigIV {
    if (!_topBigIV) {
        _topBigIV = [[UIImageView alloc]init];
        [self.tableView addSubview:_topBigIV];
        [_topBigIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.top.mas_equalTo(-300);
            make.height.mas_equalTo(300);
        }];
        _topBigIV.contentMode = UIViewContentModeScaleAspectFill;
        _topBigIV.clipsToBounds = YES;
        _topBigIV.image = [UIImage imageNamed:@"pcImage"];
    }
    return _topBigIV;
}

- (UIImageView *)headPortraitIV {
    if (!_headPortraitIV) {
        _headPortraitIV = [[UIImageView alloc]init];
        [self.tableView addSubview:_headPortraitIV];
        [self.topBigIV.superview layoutIfNeeded];
        [_headPortraitIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(ysTopHeight - 300);
            make.height.width.mas_equalTo(100);
        }];
        _headPortraitIV.backgroundColor = MAIN_COLOR;
        //绘制圆角
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
        CAShapeLayer *layer = [CAShapeLayer layer];
        [layer setFrame:CGRectMake(0, 0, 100, 100)];
        layer.path = path.CGPath;
        _headPortraitIV.layer.mask = layer;
        //设定图片
        _headPortraitIV.image = [UIImage imageNamed:@"头像"];
    }
    return _headPortraitIV;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc]init];
        [self.tableView addSubview:_userNameLabel];
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.headPortraitIV.mas_bottom).mas_offset(20);
        }];
        //设置文字颜色
        _userNameLabel.textColor = [UIColor whiteColor];
        
        //赋值
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([ud stringForKey:@"userName"] == nil) {
            //未登录
            _userNameLabel.text = DEFAULT_USER_NAME;
        }else {
            _userNameLabel.text = [ud stringForKey:@"userName"];
        }
    }
    return _userNameLabel;
}

- (UILabel *)userIntroductionLabel {
    if (!_userIntroductionLabel) {
        _userIntroductionLabel = [[UILabel alloc]init];
        [self.tableView addSubview:_userIntroductionLabel];
        [_userIntroductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.userNameLabel.mas_bottom).offset(20);
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(50);
        }];
        _userIntroductionLabel.textColor = BackgroundColor;
        _userIntroductionLabel.font = [UIFont systemFontOfSize:15];
        _userIntroductionLabel.numberOfLines = 2;
        _userIntroductionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _userIntroductionLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    _userIntroductionLabel.text = @"欲买桂花同载酒  终不似  少年游";
    return _userIntroductionLabel;
}
@end
