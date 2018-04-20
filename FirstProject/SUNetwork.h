//
//  SUNetwork.h
//  FirstProject
//
//  Created by MacBook Air on 2018/3/1.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUNetwork : NSObject
+ (void)getGoodslistWithPageNumber:(NSInteger)page CallBack:(void(^)(id obj,NSError *error))callBack;

@end
