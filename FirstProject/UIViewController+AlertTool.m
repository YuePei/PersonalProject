//
//  UIViewController+AlertTool.m
//  FirstProject
//
//  Created by Peyton on 2018/8/14.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "UIViewController+AlertTool.h"

@implementation UIViewController (AlertTool)
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message alertStyle:(UIAlertControllerStyle )alertStyle cancleActionTitle:(NSString *)cancelTitle cancelBlock:(void(^)(void))cancelBlock sureActionTitle:(NSString *)sureTitle sureBlock:(void(^)(void))sureBlock completion:(void (^)(void))completion{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertStyle];
    
    //取消
    if (cancelTitle) {
        if (cancelBlock) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                cancelBlock();
            }];
            [alertController addAction:cancelAction];
        }else {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
        }
        
        
    }
    //确定
    if (sureTitle) {
        if (sureBlock) {
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                sureBlock();
            }];
            [alertController addAction:sureAction];
        }else {
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:sureAction];
        }
        
    }
    //展现alertController
    if (completion) {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
            completion();
        }];
    } else {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
    
    
}
@end
