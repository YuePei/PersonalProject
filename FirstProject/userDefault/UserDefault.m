//
//  UserDefault.m
//  Layer
//
//  Created by Peyton on 2018/8/7.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "UserDefault.h"

@implementation UserDefault
+ (void)setUserName:(NSString *)userName {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:userName forKey:@"userNmae"];
    [ud synchronize];
}

+ (NSString *)getUserName {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:@"userName"];
}

//密码
+ (void)setPassword:(NSString *)password {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:password forKey:@"password"];
    [ud synchronize];
}

+ (NSString *)getPassword {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:@"password"];
}

//登录状态
+ (void)setLoginStatus:(bool)loginStatus {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@(loginStatus) forKey:@"loginStatus"];
    [ud synchronize];
}

+ (bool)getLoginStatus {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:@"loginStatus"];
}
@end
