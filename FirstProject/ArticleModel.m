//
//  ArticleModel.m
//  FirstProject
//
//  Created by MacBook Air on 17/11/2.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "ArticleModel.h"

@implementation AResultModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data":@"ArticleModel"};
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end


@implementation ArticleModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"desc":@"description",@"aTitle":@"title",@"aType":@"type"};
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end

