//
//  LCNavigationController.m
//  新浪微博
//
//  Created by lichao on 15/7/28.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCNavigationController.h"

@implementation LCNavigationController


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
  NSString *titel = @"返回";
//    如果push进入的 是第一个导航栏 返回按钮就设置为第一个界面的文字
    if (self.childViewControllers.count ==1) {
       titel = [[self.childViewControllers firstObject] title];
    }
    if (self.childViewControllers.count) {
        [UIBarButtonItem itemWithImageName:@"navigationbar_back_withtext" target:self action:@selector(back) titel:titel];
        viewController.hidesBottomBarWhenPushed =YES;
    }
    [super pushViewController:viewController animated:animated];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];

}
@end
