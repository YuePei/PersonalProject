//
//  ShareListView.h
//  FirstProject
//
//  Created by Peyton on 2018/7/10.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareListView : UIView

/**
 @param frame       位置
 @param icons       图标
 @param titles      标题
 @param cardInfo    分享卡片上的信息, 包含title, link, imageString
 */
- (instancetype)initWithFrame:(CGRect)frame shareIcons:(NSArray *)icons ShareTitles:(NSArray *)titles andCardInfo:(NSDictionary *)cardInfo;

- (void)getVc:(UIViewController *)vc;

/**
 * 设置截图
 */
- (void)setScreenShotImage:(UIImage *)image;

- (void)hideShareViewWithFinishBlock:(void (^)())finishBlock;

- (void)showMiddleView;
@end

