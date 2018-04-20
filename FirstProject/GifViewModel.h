//
//  GifViewModel.h
//  FirstProject
//
//  Created by MacBook Air on 2018/2/23.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GifViewModel : NSObject
//刷新
- (void)getGifListWithApiKey:(NSString *)api_Key limit:(int)limit offSet:(int)offset CallBackBlock:(void (^)(id dic, NSError *error))callBack;
//加载更多
- (void)getMoreGifWithApiKey:(NSString *)api_Key limit:(int)limit offSet:(int)offset CallBackBlock:(void (^)(id dic, NSError *error))callBack;
//获取某一项的url
- (NSString *)getUrlAtIndexPathRow:(NSInteger)row;
- (NSInteger)getGifNumber;

@end
