//
//  LCTabBarController.m
//  新浪微博
//
//  Created by lichao on 15/7/27.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCTabBarController.h"

@interface LCTabBarController ()

@end

@implementation LCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建首页
    UITableViewController *home =[[UITableViewController alloc]init];
    [self tableViewWithTableViewCtrl:home image:@"tabbar_home" titel:@"首页"];
    
    UITableViewController *message =[[UITableViewController alloc]init];
    [self tableViewWithTableViewCtrl:message image:@"tabbar_message_center" titel:@"消息"];
    UITableViewController *discover =[[UITableViewController alloc]init];
    [self tableViewWithTableViewCtrl:discover image:@"tabbar_discover" titel:@"发现"];
    UITableViewController *profile =[[UITableViewController alloc]init];
    [self tableViewWithTableViewCtrl:profile image:@"tabbar_profile" titel:@"我"];
    
}
-(void)tableViewWithTableViewCtrl:(UITableViewController *)ctrl image:(NSString *)image titel:(NSString *)titel{
    
    ctrl.tabBarItem.title =titel;
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] =[UIColor orangeColor];
    [ctrl.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
   
    ctrl.tabBarItem.image =[[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ctrl.tabBarItem.selectedImage =[[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",image]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  
    [self addChildViewController:ctrl];

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
