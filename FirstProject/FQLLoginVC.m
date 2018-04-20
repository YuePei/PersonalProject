//
//  FQLLoginVC.m
//  FirstProject
//
//  Created by MacBook Air on 17/10/17.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "FQLLoginVC.h"
#import "CustomMBProgressHUD.h"


@interface FQLLoginVC ()

@property(nonatomic,strong)UIImageView *logoIV;

@property(nonatomic,strong)UITextField *userNameTF;

@property(nonatomic,strong)UITextField *pwdTF;

@property(nonatomic,strong)UIButton *loginBtn;

@property(nonatomic,strong)UIButton *cancleButton;

@property(nonatomic,strong)UIButton *registerButton;

@property(nonatomic,strong)UIButton *forgetPwd;


@end

@implementation FQLLoginVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    //初始化一个自定义view的MBProgressHUD
//    UIImageView *imaV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30 )];
//    imaV.image = [UIImage imageNamed:@"加载进度"];
//    [CustomMBProgressHUD setHudWithImageName:imaV title:@"Hi girl, welcome!" description:nil andHideAfterDelay:2];
    
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
            make.width.height.mas_equalTo(SCREEN_WIDTH / 4);
            make.top.mas_equalTo(SCREEN_HEIGHT / 7);
        }];
        _logoIV.backgroundColor = [UIColor colorWithRed:0 green:154 / 255.0 blue:216 / 255.0 alpha:1];
        _logoIV.layer.cornerRadius = SCREEN_WIDTH / 8;
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
        [_loginBtn setBackgroundColor:[UIColor colorWithRed:0 green:154 / 255.0 blue:216 / 255.0 alpha:1]];
        
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
        [_registerButton setTitleColor:[UIColor colorWithRed:0 green:154 / 255.0 blue:216 / 255.0 alpha:1] forState:UIControlStateNormal];
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
        [_forgetPwd setTitleColor:[UIColor colorWithRed:0 green:154 / 255.0 blue:216 / 255.0 alpha:1] forState:UIControlStateNormal];
        _forgetPwd.titleLabel.font = [UIFont systemFontOfSize:15];
        _forgetPwd.titleLabel.font = [UIFont fontWithName:@"Verdana-Italic" size:15];
     
        [_forgetPwd addTarget:self action:@selector(developing) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _forgetPwd;
}
@end
