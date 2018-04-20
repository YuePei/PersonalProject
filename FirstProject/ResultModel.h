//
//  ResultModel.h
//  FirstProject
//
//  Created by MacBook Air on 2018/2/23.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ResultModel,GifModel,ImagesModel,PreviewModel;

@interface ResultModel : NSObject
//dataArray
@property(nonatomic,copy)NSArray *dataArray;
@end


@interface GifModel : NSObject
//id
@property(nonatomic,strong)NSString *imagesID;
//images
@property(nonatomic,strong)ImagesModel *images;
@end


@interface ImagesModel : NSObject
//选择preview作为列表视图
@property(nonatomic,strong)PreviewModel *preview_gif;
@end


@interface PreviewModel : NSObject
//width
@property(nonatomic,assign)NSInteger width;
//height
@property(nonatomic,assign)NSInteger height;
//url
@property(nonatomic,strong)NSString *url;
@end












