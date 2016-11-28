//
//  ZYWeakTimerTargetObject.m
//  图片无限轮播器
//
//  Created by 周亚-Sun on 2016/11/28.
//  Copyright © 2016年 zhouya. All rights reserved.
//

#import "ZYWeakTimerTargetObject.h"
@interface ZYWeakTimerTargetObject()

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@end

@implementation ZYWeakTimerTargetObject

//重写
+ (NSTimer * _Nonnull )scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(_Nonnull id)aTarget selector:(_Nonnull SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
{
    ZYWeakTimerTargetObject *object=[[ZYWeakTimerTargetObject alloc]init];
    object.target=aTarget;
    object.selector=aSelector;
    return [NSTimer scheduledTimerWithTimeInterval:ti target:object selector:@selector(fire:) userInfo:userInfo repeats:yesOrNo];
    
}
-(void)fire:(id)sender
{
    [self.target performSelector:self.selector withObject:sender afterDelay:0.0];
}
@end
