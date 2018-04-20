//
//  WaterFallFlowLayout.m
//  FirstProject
//
//  Created by MacBook Air on 2018/2/20.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "WaterFallFlowLayout.h"
//行间距
static const float rowMargin = 10;
//列间距
static const float columnMargin = 15;
//上下左右的距离
static const UIEdgeInsets defaultEdgeInsets = {0, 10, 0, 10};
static const int columnNumber = 2;

@interface WaterFallFlowLayout()
//每一列的最大Y值，我只想要两个列，所以只有两个元素
@property(nonatomic,copy)NSMutableArray *columnsY;
//attributesarray
@property(nonatomic,copy)NSMutableArray *attributesArray;

@end
@implementation WaterFallFlowLayout

#pragma mark 重写内部方法
- (CGSize)collectionViewContentSize {
    
    static int maxColumnNmuber = 0;
    float maxColumnValue = [self.columnsY[0] floatValue];
    for (int i = 1; i < self.columnsY.count; i ++) {
        if (maxColumnValue < [self.columnsY[i] floatValue]) {
            maxColumnValue = [self.columnsY[i] floatValue];
            maxColumnNmuber = i;
        }
    }
    //最后的高度应该是，Y值最大的那一列的高度 + defaultEdgeInsets.bottom，其实Y是包含defaultEdgeInsets.top的，所以整个的contentsize应该是两者之和
    return CGSizeMake(0, maxColumnValue + defaultEdgeInsets.bottom);
}
//为什么要将初始化放在prepareLayout中？
//因为这个方法，每次页面刷新都会调用一次，如果放在init方法中，刷新操作不会调用init
- (void)prepareLayout {
    [super prepareLayout];
    //初始化columnsY
    [self.columnsY removeAllObjects];
    //把EdgeInsides.top加进去
    for (int i = 0; i < columnNumber; i ++) {
        [self.columnsY addObject:@(defaultEdgeInsets.top)];
    }
    
    //初始化attributesArray
    [self.attributesArray removeAllObjects];
    float cellCount = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < cellCount; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesArray addObject:attri];
    }
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //计算UICollectionViewLayoutAttributes的一些属性，比如frame:x,y,width,height
    float xInsets = defaultEdgeInsets.left + defaultEdgeInsets.right + (columnNumber - 1) * columnMargin;
    //宽度
    float w = (self.collectionView.frame.size.width - xInsets) / columnNumber;
    //高度
//    float h = 50 + arc4random() % 100;
    float h = 0;
    if ([self.delegate respondsToSelector:@selector(getHeightWithLayout:AtIndexPath:)]) {
        h = [self.delegate getHeightWithLayout:self AtIndexPath:indexPath];
    }
    //x
    int minColumnNumber = 0;
    float minColumnValue = [self.columnsY[0] floatValue];
    for (int i = 1; i < self.columnsY.count; i ++) {
        if (minColumnValue > [self.columnsY[i] floatValue]) {
            minColumnValue = [self.columnsY[i] floatValue];
            minColumnNumber = i;
        }
    }
    float x = defaultEdgeInsets.left + (w + columnMargin) * minColumnNumber;
    //y
    float y = minColumnValue + rowMargin;
    attri.frame = CGRectMake(x, y, w, h);
    self.columnsY[minColumnNumber] = @(CGRectGetMaxY(attri.frame));
    return attri;
}


#pragma mark lazy
- (NSMutableArray *)columnsY {
    if (!_columnsY) {
        _columnsY = [NSMutableArray new];
    }
    return _columnsY;
}
- (NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray new];
    }
    return _attributesArray;
}
@end
