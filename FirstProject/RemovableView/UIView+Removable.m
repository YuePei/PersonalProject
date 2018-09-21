//
//  UIView+Removable.m
//  test1
//
//  Created by Peyton on 2018/8/29.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "UIView+Removable.h"

@implementation UIView (Removable)

- (void)makeRemovable {
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizer:)];
    [self addGestureRecognizer:panGesture];
    
}

#pragma mark toolMethods
- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGesture {
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            NSLog(@"begin");
        }
            break;
        case UIGestureRecognizerStateChanged: {
            
            CGPoint translation = [panGesture translationInView:self.superview];
            self.center = CGPointMake(self.center.x + translation.x, self.center.y + translation.y);
            //关键，不设为零会不断递增，视图会突然不见
            [panGesture setTranslation:CGPointZero inView:self.superview];
            
        }
            break;
        case UIGestureRecognizerStateEnded:
            break;
        case UIGestureRecognizerStateCancelled:
            break;
        default:
            break;
    }
}
@end
