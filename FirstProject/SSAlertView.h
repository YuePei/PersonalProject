//
//  SSAlertView.h
//  FirstProject
//
//  Created by MacBook Air on 2018/2/5.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SSAlertViewDelegate


@end

@interface SSAlertView : UIView

//backgroundView
@property(nonatomic,strong)UIView *backgroundView;
//title
@property(nonatomic,strong)UILabel *titleLabel;
//content
@property(nonatomic,strong)UILabel *contentLabel;
//icon
@property(nonatomic,strong)UIImageView *headIV;
//button
@property(nonatomic,strong)UIButton *sureBtn;

@end


