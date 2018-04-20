//
//  ArticleDetailModel.m
//  FirstProject
//
//  Created by 乐培培 on 2018/3/15.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "ArticleDetailModel.h"

@implementation ArticleDetailModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end



@implementation ArticleDataModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"originalLink":@"link",@"htmlContent":@"content"};
}
@end
