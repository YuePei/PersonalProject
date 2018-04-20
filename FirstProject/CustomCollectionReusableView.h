//
//  CustomCollectionReusableView.h
//  FirstProject
//
//  Created by 乐培培 on 2018/3/14.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionReusableView : UICollectionReusableView
//右侧的label
@property (nonatomic , strong) UIButton *rightButton;
//左侧的label
@property (nonatomic , strong) UIButton *leftButton;
//图片array
@property (nonatomic , copy) NSMutableArray *imagesArray;

@end
