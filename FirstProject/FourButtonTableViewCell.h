//
//  FourButtonTableViewCell.h
//  FirstProject
//
//  Created by Peyton on 2018/7/30.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourButtonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *collectedNum;
@property (weak, nonatomic) IBOutlet UIButton *comments;
@property (weak, nonatomic) IBOutlet UIButton *likedNum;
@property (weak, nonatomic) IBOutlet UIButton *sharedNum;

@end
