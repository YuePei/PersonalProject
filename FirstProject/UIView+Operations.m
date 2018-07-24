//
//  UIView+Operations.m
//  FirstProject
//
//  Created by Peyton on 2018/7/24.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "UIView+Operations.h"

@implementation UIView (Operations)

- (UIViewController *)getViewController {
    for (UIView *v = [self superview]; v; v = v.superview) {
        NSLog(@"view: %@",v);
        UIResponder *nextResponder = [v nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return(UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
