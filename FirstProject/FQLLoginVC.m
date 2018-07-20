//
//  FQLLoginVC.m
//  FirstProject
//
//  Created by MacBook Air on 17/10/17.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "FQLLoginVC.h"
#import "UIView+KeyBoardAdjust.h"

@interface FQLLoginVC ()

@property(nonatomic,strong)UIImageView *logoIV;

@property(nonatomic,strong)UITextField *userNameTF;

@property(nonatomic,strong)UITextField *pwdTF;

@property(nonatomic,strong)UIButton *loginBtn;

@property(nonatomic,strong)UIButton *cancleButton;

@property(nonatomic,strong)UIButton *registerButton;

@property(nonatomic,strong)UIButton *forgetPwd;
//weChatLogin
@property (nonatomic, strong)UIButton *weChatLoginButton;
//weiboLogin
@property (nonatomic, strong)UIButton *weiBoLoginButton;
//qqLoginButton
@property (nonatomic, strong)UIButton *qqLoginButton;
//用户协议
@property (nonatomic, strong)UIButton *userProtocol;

@end

@implementation FQLLoginVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self.view adjustAllTextFieldsWithKeyBoard];
    [self weChatLoginButton];
    [self qqLoginButton];
    [self weiBoLoginButton];
    [self userProtocol];
}


#pragma mark Tool Methods

- (void)loginMethod {
    //新增
//    BmobObject *user = [BmobObject objectWithClassName:@"User"];
//    [user setObject:self.userNameTF.text forKey:@"username"];
//    [user setObject:self.pwdTF.text forKey:@"password"];
    //保存
//    [user saveInBackground];
    
    //获取
    BmobQuery *userQuery = [BmobQuery queryWithClassName:@"User"];
    [userQuery whereKey:@"username" equalTo:self.userNameTF.text];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([self.pwdTF.text isEqualToString:[obj objectForKey:@"password"]]) {
                //密码账号匹配成功，登录成功
                [self dismissViewControllerAnimated:YES completion:nil];
                //存储到userDefault中
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault setObject:self.userNameTF.text forKey:@"userName"];
                [userDefault setBool:YES forKey:@"status"];
                [userDefault synchronize];
                NSLog(@".....1...%@",[userDefault objectForKey:@"status"]);
                if ([self.delegate respondsToSelector:@selector(bringUserName:)]) {
                    [self.delegate bringUserName:self.userNameTF.text];
                }
            }else {
                //密码账号不匹配，登录失败
            }
        }
    }];
}
- (void)setUpUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self cancleButton];
    [self logoIV];
    [self userNameTF];
    [self pwdTF];
    [self loginBtn];
    [self registerButton];
    [self forgetPwd];
    
}

- (void)goBack {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)developing {
    //弹框提示的写法
    UIAlertController *altC = [UIAlertController alertControllerWithTitle:@"提示" message:@"工程师正在开发中..." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [altC addAction:ac1];
    
    [self presentViewController:altC animated:YES completion:nil];
}
#pragma mark lazy
- (UIButton *)cancleButton {
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_cancleButton];
        [_cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(10);
            make.width.height.mas_equalTo(50);
        }];
        [_cancleButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
//        [_cancleButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:23 weight:10];
        [_cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

- (UIImageView *)logoIV {
    if (_logoIV == nil) {
        _logoIV = [[UIImageView alloc]init];
        [self.view addSubview:_logoIV];
        [_logoIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.centerX);
            make.width.height.mas_equalTo(150 * SCREEN_PROPORTION);
            make.top.mas_equalTo(SCREEN_HEIGHT / 7);
        }];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://mingxing.facang.com/uploads/allimg/151229/1H54C520-4.jpg"]];
        UIImage *img = [UIImage imageWithData:data];
        _logoIV.image = img;
        
        //设置圆角
        [_logoIV.superview layoutIfNeeded];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_logoIV.bounds cornerRadius:_logoIV.frame.size.width / 2.0];
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        circleLayer.path = path.CGPath;
        
        [circleLayer setFrame:_logoIV.bounds];
        _logoIV.layer.mask = circleLayer;
//        _logoIV.layer.cornerRadius = SCREEN_WIDTH / 8;
    }
    return _logoIV;
}


- (UITextField *)userNameTF {
    if (_userNameTF == nil) {
        _userNameTF = [[UITextField alloc]init];
        [self.view addSubview:_userNameTF];
        [_userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.centerX);
            make.top.equalTo(self.logoIV.bottom).offset(SCREEN_HEIGHT / 20);
            make.width.mas_equalTo(SCREEN_WIDTH / 4 * 3);
            make.height.mas_equalTo(SCREEN_HEIGHT / 18);
        }];
        _userNameTF.borderStyle = UITextBorderStyleRoundedRect;
        [_userNameTF setPlaceholder:@"用户名/手机号"];
    }
    return _userNameTF;
}
- (UITextField *)pwdTF {
    if (_pwdTF == nil) {
        _pwdTF = [[UITextField alloc]init];
        [self.view addSubview:_pwdTF];
        [_pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.centerX);
            make.top.equalTo(self.userNameTF.mas_bottom).offset(SCREEN_HEIGHT / 30);
            make.width.mas_equalTo(SCREEN_WIDTH / 4 * 3);
            make.height.mas_equalTo(SCREEN_HEIGHT / 18);
        }];
        //设置为密文
        [_pwdTF setSecureTextEntry:YES];
        _pwdTF.borderStyle = UITextBorderStyleRoundedRect;
        [_pwdTF setPlaceholder:@"密码"];
    }
    return _pwdTF;
}

- (UIButton *)loginBtn {
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_loginBtn];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.centerX);
            make.top.equalTo(self.pwdTF.bottom).offset(SCREEN_HEIGHT / 20);
            make.width.mas_equalTo(SCREEN_WIDTH / 5 * 3);
            make.height.mas_equalTo(SCREEN_HEIGHT / 20);
        }];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:MAIN_COLOR];
        
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 6;
        
        [_loginBtn addTarget:self action:@selector(loginMethod) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginBtn;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_registerButton];
        [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.loginBtn.bottom).offset(SCREEN_HEIGHT / 55);
            make.left.equalTo(self.loginBtn.left);
        }];
        [_registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _registerButton.titleLabel.font = [UIFont fontWithName:@"Verdana-Italic" size:15];
    }
    return _registerButton;
}
- (UIButton *)forgetPwd {
    if (!_forgetPwd) {
        _forgetPwd = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_forgetPwd];
        [_forgetPwd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.loginBtn.bottom).offset(SCREEN_HEIGHT / 55);
            make.right.equalTo(self.loginBtn.right);
        }];
        [_forgetPwd setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPwd setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        _forgetPwd.titleLabel.font = [UIFont systemFontOfSize:15];
        _forgetPwd.titleLabel.font = [UIFont fontWithName:@"Verdana-Italic" size:15];
     
        [_forgetPwd addTarget:self action:@selector(developing) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _forgetPwd;
}

- (UIButton *)weChatLoginButton {
    if (!_weChatLoginButton) {
        _weChatLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_weChatLoginButton];
        [_weChatLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(40 * SCREEN_PROPORTION);
            make.left.mas_equalTo(self.userNameTF.mas_left);
            make.top.mas_equalTo(self.registerButton.mas_bottom).mas_offset(30 * SCREEN_PROPORTION);
        }];
        [_weChatLoginButton setBackgroundImage:[UIImage imageNamed:@"weChat_login"] forState:UIControlStateNormal];
//        [_weChatLoginButton setBackgroundColor:[UIColor redColor]];
    }
    return _weChatLoginButton;
}

- (UIButton *)qqLoginButton {
    if (!_qqLoginButton) {
        _qqLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_qqLoginButton];
        [_qqLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(30 * SCREEN_PROPORTION);
            make.right.mas_equalTo(self.userNameTF.mas_right);
            make.centerY.mas_equalTo(self.weChatLoginButton.mas_centerY);
        }];
        [_qqLoginButton setBackgroundImage:[UIImage imageNamed:@"qq_login"] forState:UIControlStateNormal];
        //        [_weChatLoginButton setBackgroundColor:[UIColor redColor]];
    }
    return _qqLoginButton;
}

- (UIButton *)weiBoLoginButton {
    if (!_weiBoLoginButton) {
        _weiBoLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_weiBoLoginButton];
        [_weiBoLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(40 * SCREEN_PROPORTION);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.weChatLoginButton.mas_top);
        }];
        [_weiBoLoginButton setBackgroundImage:[UIImage imageNamed:@"微博_login"] forState:UIControlStateNormal];
        //        [_weChatLoginButton setBackgroundColor:[UIColor redColor]];
    }
    return _weiBoLoginButton;
}

- (UIButton *)userProtocol {
    if (!_userProtocol) {
        _userProtocol = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_userProtocol];
        [_userProtocol mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.weChatLoginButton.mas_bottom).mas_offset(30);
        }];
        [_userProtocol setTitleColor:BackgroundColor forState:UIControlStateNormal];
        [_userProtocol.titleLabel setFont:[UIFont systemFontOfSize:12]];
        NSMutableAttributedString * originString = [[NSMutableAttributedString alloc]initWithString:@"创建账号代表您同意用户服务协议"];
        NSRange range = [[originString string] rangeOfString:@"用户服务协议"];
        [originString addAttribute:NSForegroundColorAttributeName value:GREEN_COLOR range:range];
        [_userProtocol setAttributedTitle:originString forState:UIControlStateNormal];
    }
    return _userProtocol;
}
@end
