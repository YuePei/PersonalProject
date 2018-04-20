
//
//  ResultModel.m
//  FirstProject
//
//  Created by MacBook Air on 2018/2/23.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "ResultModel.h"
@implementation PreviewModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end



@implementation ImagesModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//    return @{@"gifPreview":@"preview"};
//}

@end



@implementation GifModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"imagesID":@"id"};
}
@end



@implementation ResultModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"dataArray":@"GifModel"};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"dataArray":@"data"};
}
@end
