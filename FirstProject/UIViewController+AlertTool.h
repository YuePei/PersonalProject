//
//  UIViewController+AlertTool.h
//  FirstProject
//
//  Created by Peyton on 2018/8/14.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AlertTool)

/**
 @param title           alertController的标题
 @param message         alertController的message
 @param alertStyle      alertController类型, 是从中心显示还是从底部显示
 @param cancelTitle     取消按钮标题
 @param cancelBlock     点击取消按钮触发的block, 与上面的取消按钮标题对应, 如果取消按钮标题为nil, 这里也应该为nil
 @param sureTitle       确认标题按钮
 @param sureBlock       点击确认按钮触发的block, 与上面的确认按钮标题对应, 如果确认按钮标题为nil, 这里也应该为nil
 @param completion      将alertController present出来后需要做什么的block
 
 */
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message alertStyle:(UIAlertControllerStyle )alertStyle cancleActionTitle:(NSString *)cancelTitle cancelBlock:(void(^)(void))cancelBlock sureActionTitle:(NSString *)sureTitle sureBlock:(void(^)(void))sureBlock completion:(void (^)(void))completion;

@end
