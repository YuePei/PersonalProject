//
//  CommentView.h
//  FirstProject
//
//  Created by Peyton on 2018/5/3.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentView : UIView
//textView
@property (nonatomic, strong)UITextView *contentTextView;
//submitBtn
@property (nonatomic, strong)UIButton *submitButton;
//at
@property (nonatomic, strong)UIButton *atButton;
//expression
@property (nonatomic, strong)UIButton *expressionButton;

@end
