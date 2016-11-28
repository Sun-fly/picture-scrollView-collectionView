//
//  ZYMainViewController.m
//  图片无限轮播器
//
//  Created by 周亚-Sun on 2016/11/28.
//  Copyright © 2016年 zhouya. All rights reserved.
//

#import "ZYMainViewController.h"

#import "ZYLoopView.h"
@interface ZYMainViewController ()

@property(strong,nonatomic)ZYLoopView *loopView;
@end

@implementation ZYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;//关闭自动调整滚动视图
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;//隐藏导航栏
}
-(void)loadView
{
    [super loadView];
    
    NSArray *imageArray=@[@"srcoll_01",@"srcoll_02",@"srcoll_03"];
    
    _loopView=[[ZYLoopView alloc]initWithImageArray:imageArray];
    
    _loopView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250);
    
    [self.view addSubview:self.loopView];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
