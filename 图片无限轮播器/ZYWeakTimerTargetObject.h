//
//  ZYWeakTimerTargetObject.h
//  图片无限轮播器
//
//  Created by 周亚-Sun on 2016/11/28.
//  Copyright © 2016年 zhouya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYWeakTimerTargetObject : NSObject
//重写定时器
+ (NSTimer * _Nonnull )scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(_Nonnull id)aTarget selector:(_Nonnull SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
@end
