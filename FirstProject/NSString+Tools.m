//
//  NSString+Tools.m
//  FirstProject
//
//  Created by Peyton on 2018/8/17.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "NSString+Tools.h"

@implementation NSString (Tools)

-  (int)charNumber {
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUTF8StringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding] ;i++) {
        if (*p) {
            if(*p == '\xe4' || *p == '\xe5' || *p == '\xe6' || *p == '\xe7' || *p == '\xe8' || *p == '\xe9')
            {
                strlength--;
            }
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}
@end
