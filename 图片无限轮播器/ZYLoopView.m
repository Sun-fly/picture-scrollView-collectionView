//
//  ZYLoopView.m
//  图片无限轮播器
//
//  Created by 周亚-Sun on 2016/11/28.
//  Copyright © 2016年 zhouya. All rights reserved.
//

#import "ZYLoopView.h"
#import "ZYLoopViewCell.h"
#import "ZYLoopViewLayout.h"
#import "ZYWeakTimerTargetObject.h"
@interface ZYLoopView()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, weak) NSTimer *timer;

@end
static NSString *ID=@"loopViewCell";

@implementation ZYLoopView

-(instancetype)initWithImageArray:(NSArray *)imageArray
{
    if(self=[super init]){
    //创建集合视图以及frame
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[ZYLoopViewLayout alloc]init]];
    //注册集合视图单元格
    [collectionView registerClass:[ZYLoopViewCell class] forCellWithReuseIdentifier:ID];
    collectionView.delegate=self;
    collectionView.dataSource=self;
    [self addSubview:collectionView];//添加集合视图
    self.collectionView=collectionView;
    self.imageArray=imageArray;
    
    [self addSubview:self.pageControl];//添加分页控制器
        
    //回到主线程刷新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        //设置滚动的初始状态
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.imageArray.count inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
        [self addTimer];//添加定时器
    });
    }
    return self;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 220, 0, 30)];
        _pageControl.numberOfPages=self.imageArray.count;
         _pageControl.pageIndicatorTintColor=[UIColor orangeColor];
        _pageControl.currentPageIndicatorTintColor=[UIColor purpleColor];
       
    }
    return _pageControl;
}
#pragma mark--collectionViewDataSource
//多少个单元
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count * 3;
}
//单元格内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYLoopViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageName=self.imageArray[indexPath.item %self.imageArray.count];
    return cell;
}
#pragma mark--collectionViewDelegate
// 滚动完毕就会调用（如果不是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}
// 当滚动减速时调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat ofsetX=scrollView.contentOffset.x;//滚动视图的起点
    NSInteger page=ofsetX /scrollView.bounds.size.width;//页数
    //手动滚动到左边临界状态
    if (page==0) {
        page=self.imageArray.count;
        self.collectionView.contentOffset = CGPointMake(page * scrollView.frame.size.width, 0);
    }
    //手动滚动到右边临界状态
    else if (page == [self.collectionView numberOfItemsInSection:0] - 1)
    {
        page = self.imageArray.count - 1;
        self.collectionView.contentOffset = CGPointMake(page * scrollView.frame.size.width, 0);
    }
    //设置UIPageControl当前页
    NSInteger currentPage = page % self.imageArray.count;
    self.pageControl.currentPage =currentPage;
    
    [self addTimer];//添加定时器
}
//开始拖动时调用
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];//移除定时器
}
#pragma mark--定时器Timer
-(void)addTimer
{
    if (self.timer) {
        return;
    }
    self.timer=[ZYWeakTimerTargetObject scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)removeTimer{
    [self.timer invalidate];
    self.timer=nil;
}
//切换到下一张图片
-(void)nextImage
{
    CGFloat ofsetX=self.collectionView.contentOffset.x;
    NSInteger page=ofsetX /self.collectionView.bounds.size.width;
    [self.collectionView setContentOffset:CGPointMake((page +1)*self.collectionView.bounds.size.width, 0) animated:YES];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame=self.bounds;
}
-(void)dealloc
{
    [self removeTimer];
}
@end
