//
//  ZYLoopViewCell.m
//  图片无限轮播器
//
//  Created by 周亚-Sun on 2016/11/28.
//  Copyright © 2016年 zhouya. All rights reserved.
//

#import "ZYLoopViewCell.h"

@interface ZYLoopViewCell ()

@property(weak,nonatomic)UIImageView *iconView;

@end
@implementation ZYLoopViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        UIImageView *iconView=[[UIImageView alloc]init];
        [self addSubview:iconView];
        self.iconView=iconView;
    }
    return self;
}
-(void)setImageName:(NSString *)imageName//重写set方法
{
    _imageName=imageName;
    self.iconView.image=[UIImage imageNamed:imageName];
}
-(void)layoutSubviews//重写图片布局
{
    [super layoutSubviews];
    self.iconView.frame=self.bounds;
}
@end
