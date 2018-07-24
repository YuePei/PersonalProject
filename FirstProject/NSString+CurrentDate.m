//
//  NSString+CurrentDate.m
//  FirstProject
//
//  Created by Peyton on 2018/7/23.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "NSString+CurrentDate.h"

@implementation NSString (CurrentDate)

+ (NSString *)ys_getCurrentDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    return dateString;
}
@end
