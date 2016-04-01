//
//  WSLineLayout.m
//  自定义布局
//
//  Created by 王帅 on 16/4/1.
//  Copyright © 2016年 Mr.wang. All rights reserved.
//

#import "WSLineLayout.h"

@implementation WSLineLayout

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
    
}

// 当collectionView的显示范围发生改变的时候是否需要重新刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

// 做布局的初始化操作
- (void)prepareLayout {
    [super prepareLayout];

    //水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) *0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);

}

// 返回值是个数组，里面保存了rect范围内所有元素的布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
  
    // collectionView最中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        CGFloat detal = ABS(attrs.center.x - centerX);
        CGFloat scale = 1 - detal / self.collectionView.frame.size.width;
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
        
    }
    
    return array;
}

// 这个方法的返回值，决定了collectionView停止滚动时的偏移量(猛拖)
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    
    // 获得super已经布局好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 存放最小的间距值
    CGFloat mindetal = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(mindetal) > ABS(attrs.center.x - centerX)) {
            mindetal = attrs.center.x - centerX;
        }
    }
    // 修改原有的偏移量
    proposedContentOffset.x += mindetal;
    return proposedContentOffset;
    
}







@end
