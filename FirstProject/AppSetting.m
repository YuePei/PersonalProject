//
//  AppSetting.m
//  FirstProject
//
//  Created by Peyton on 2018/7/23.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "AppSetting.h"

@implementation AppSetting

//获取版本号
- (NSString *)getCurrentBundleVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleVersionString = [infoDic objectForKey:@"CFBundleVersion"];
    return bundleVersionString;
}

@end
