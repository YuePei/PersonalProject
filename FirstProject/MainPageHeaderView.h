//
//  MainPageHeaderView.h
//  FirstProject
//
//  Created by Peyton on 2018/5/3.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPageHeaderView : UIView

////topRightLabel
//@property (nonatomic, strong)UILabel *topRightLabel;
//collectionView
@property (nonatomic, strong)UICollectionView *contentCollectionView;

//图片array
@property (nonatomic , copy) NSMutableArray *imagesArray;
@end
