//
//  SDetailVc.m
//  FirstProject
//
//  Created by 乐培培 on 2018/3/12.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "SDetailVc.h"
#import "ShareListView.h"
#import "ShareCollectionViewCell.h"

@interface SDetailVc ()

@property (nonatomic, strong)NSArray *dataArray;
//iconsArray
@property (nonatomic, strong)NSArray *iconsArray;

@end

@implementation SDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.height.mas_equalTo(200);
        make.bottom.mas_equalTo(-20);
    }];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"朋友圈"] forState:UIControlStateNormal];
    [btn setTitle:@"Hi girl!" forState:UIControlStateNormal];
    btn.titleLabel.backgroundColor = [UIColor redColor];
    btn.imageView.backgroundColor = [UIColor brownColor];
    [self adjustButtonImageViewUPTitleDownWithButton:btn];
}

//调整按钮的图文位置
- (void)adjustButtonImageViewUPTitleDownWithButton:(UIButton *)button {
    [button.superview layoutIfNeeded];
    //使图片和文字居左上角
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    CGFloat buttonHeight = CGRectGetHeight(button.frame);
    CGFloat buttonWidth = CGRectGetWidth(button.frame);
    
    CGFloat ivHeight = CGRectGetHeight(button.imageView.frame);
    CGFloat ivWidth = CGRectGetWidth(button.imageView.frame);
    
    CGFloat titleHeight = CGRectGetHeight(button.titleLabel.frame);
    CGFloat titleWidth = CGRectGetWidth(button.titleLabel.frame);
    //调整图片
    float iVOffsetY = buttonHeight / 2.0 - (ivHeight + titleHeight) / 2.0;
    float iVOffsetX = buttonWidth / 2.0 - ivWidth / 2.0;
    [button setImageEdgeInsets:UIEdgeInsetsMake(iVOffsetY, iVOffsetX, 0, 0)];
    
    //调整文字
    float titleOffsetY = iVOffsetY + CGRectGetHeight(button.imageView.frame) + 10;
    float titleOffsetX = 0;
    if (CGRectGetWidth(button.imageView.frame) >= (CGRectGetWidth(button.frame) / 2.0)) {
        //如果图片的宽度超过或等于button宽度的一半
        titleOffsetX = -(ivWidth + titleWidth - buttonWidth / 2.0 - titleWidth / 2.0);
    }else {
        titleOffsetX = buttonWidth / 2.0 - ivWidth - titleWidth / 2.0;
    }
    [button setTitleEdgeInsets:UIEdgeInsetsMake(titleOffsetY , titleOffsetX, 0, 0)];
    
    NSLog(@"   :-(图片宽度(%f) + 文字宽度(%f) - 按钮宽度的一半(%f/2) - 文字宽度的一半(%f/2) = 文字的偏移量(%f))",ivWidth, titleWidth, buttonWidth, titleWidth, titleOffsetX);
}

@end
