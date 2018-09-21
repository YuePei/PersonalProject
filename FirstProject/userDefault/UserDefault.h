//
//  UserDefault.h
//  Layer
//
//  Created by Peyton on 2018/8/7.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefault : NSObject
//用户名
+ (void)setUserName:(NSString *)userName;
+ (NSString *)getUserName;

//密码
+ (void)setPassword:(NSString *)password;
+ (NSString *)getPassword;

//登录状态
+ (void)setLoginStatus:(bool)loginStatus;
+ (bool)getLoginStatus;

@end
