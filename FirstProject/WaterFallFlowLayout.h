//
//  WaterFallFlowLayout.h
//  FirstProject
//
//  Created by MacBook Air on 2018/2/20.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterFallFlowLayout;

@protocol WaterFallDelegate <NSObject>

@required
- (float)getHeightWithLayout:(WaterFallFlowLayout *)waterFallLayout AtIndexPath:(NSIndexPath *)indexpath;

@end

@interface WaterFallFlowLayout : UICollectionViewLayout
//代理
@property(nonatomic,strong)id<WaterFallDelegate> delegate;

@end
