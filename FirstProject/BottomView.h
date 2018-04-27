//
//  BottomView.h
//  FirstProject
//
//  Created by Peyton on 2018/4/27.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomView : UIView
//collectBtn
@property (nonatomic, strong)UIButton *collectBtn;
//commentView
@property (nonatomic, strong)UIButton *commentBtn;
//likeBtn
@property (nonatomic, strong)UIButton *likeBtn;
//shareBtn
@property (nonatomic, strong)UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end
