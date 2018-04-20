//
//  FQLLoginVC.h
//  FirstProject
//
//  Created by MacBook Air on 17/10/17.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BringBackUserNameDelegate <NSObject>
@required
- (void)bringUserName:(NSString *)userName;

@end
@interface FQLLoginVC : UIViewController
//delegate
@property (nonatomic , assign) id<BringBackUserNameDelegate> delegate;


@end
