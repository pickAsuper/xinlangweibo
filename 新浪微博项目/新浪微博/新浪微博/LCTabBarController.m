//
//  LCTabBarController.m
//  新浪微博
//
//  Created by lichao on 15/7/27.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCTabBarController.h"
#import "LCTabBar.h"
#import "LCHomeVirewController.h"
#import "LCDiscoverViewCtrl.h"


@interface LCTabBarController ()<LCTabBarDelegate>

@end

@implementation LCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    LCTabBar *tabbar =[[LCTabBar alloc]init];
    tabbar.delegate =self;
    //不能直接赋值给系统tabBar 需要通过KVC的方式
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    

    //创建首页
    LCHomeVirewController *home =[[LCHomeVirewController alloc]init];
    [self tableViewWithTableViewCtrl:home image:@"tabbar_home" titel:@"首页"];
    
    UITableViewController *message =[[UITableViewController alloc]init];
    [self tableViewWithTableViewCtrl:message image:@"tabbar_message_center" titel:@"消息"];
    LCDiscoverViewCtrl *discover =[[LCDiscoverViewCtrl alloc]init];
    [self tableViewWithTableViewCtrl:discover image:@"tabbar_discover" titel:@"发现"];
    UITableViewController *profile =[[UITableViewController alloc]init];
    [self tableViewWithTableViewCtrl:profile image:@"tabbar_profile" titel:@"我"];
    
}
-(void)tableViewWithTableViewCtrl:(UITableViewController *)ctrl image:(NSString *)image titel:(NSString *)titel{
    
    //设置底部tabbar文字颜色
    ctrl.tabBarItem.title =titel;
   // NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    //dict[NSForegroundColorAttributeName] =[UIColor orangeColor];
    //[ctrl.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
   
    self.tabBar.tintColor =[UIColor orangeColor];
    ctrl.tabBarItem.image =[[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ctrl.tabBarItem.selectedImage =[[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",image]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //给所以的UITableViewController 包装一个导航栏
    UINavigationController *navctrl =[[UINavigationController alloc]initWithRootViewController:ctrl];
    
    
    
    [self addChildViewController:navctrl];

}
-(void)tabbar:(LCTabBar *)tabbar btnClick:(UIButton *)btn{
    
    NSLog(@"xzfa");
    NSLog(@"%s",__func__);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
