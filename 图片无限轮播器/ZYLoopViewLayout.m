//
//  ZYLoopViewLayout.m
//  图片无限轮播器
//
//  Created by 周亚-Sun on 2016/11/28.
//  Copyright © 2016年 zhouya. All rights reserved.
//

#import "ZYLoopViewLayout.h"

@implementation ZYLoopViewLayout

-(void)prepareLayout//准备布局
{
    [super prepareLayout];
    //设置item尺寸
    self.itemSize = self.collectionView.frame.size;
    //设置滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置分页
    self.collectionView.pagingEnabled = YES;
    
    //设置最小间距
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    //隐藏水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    
}
@end
