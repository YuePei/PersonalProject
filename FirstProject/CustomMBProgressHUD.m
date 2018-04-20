//
//  CustomMBProgress_hud.m
//  FirstProject
//
//  Created by Peyton on 2018/3/20.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "CustomMBProgressHUD.h"
@interface CustomMBProgressHUD ()
//MBProgress_hud
@property (nonatomic, strong)MBProgressHUD *hud;

@end
@implementation CustomMBProgressHUD
- (instancetype)initWithView:(UIView *)view {
    if (self = [super init]) {
        if (!_hud) {
            _hud = [[MBProgressHUD alloc]init];
            //加载在window上
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:_hud];
            //让屏幕其他地方可点击--------------重要
            _hud.userInteractionEnabled = NO;
            //设置样式
            _hud.mode = MBProgressHUDModeCustomView;
            UIImageView *imaV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30 )];
            SetViewRadius(imaV, 15);
            //设置动画
            CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            basicAnimation.toValue = @(M_PI * 2);
            basicAnimation.repeatCount = 10;
            basicAnimation.duration = 1.f;
            [view.layer addAnimation:basicAnimation forKey:nil];
            imaV.image = [UIImage imageNamed:@"加载进度"];
            _hud.customView = view;
            //透明度
            _hud.opacity = 1;
            //展示
            [_hud show:YES];
//            _hud.detailsLabelText = @"Requesting data...";
//            _hud.labelText = @"Dear User";
            
            _hud.removeFromSuperViewOnHide = YES;
        }
        
    }
    return self;
}

+ (void)setHudWithImageName:(UIView *)view title:(NSString *)title description:(NSString *)description andHideAfterDelay:(float)delay {
    CustomMBProgressHUD *hud = [[CustomMBProgressHUD alloc]initWithView:view];
    [hud.hud hide:YES afterDelay:delay];
    hud.hud.labelText = title;
    hud.hud.detailsLabelText = description;
}
@end
