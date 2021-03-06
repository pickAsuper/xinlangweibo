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
#import "LCIWTabBarItem.h"
#import "LCComposeView.h"
@interface LCTabBarController ()<LCTabBarDelegate>

@end

@implementation LCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    LCTabBar *tabbar =[[LCTabBar alloc]init];
     [tabbar setBtnClik:^(UIButton *btn) {
         NSLog(@"通过block传的点击事件");
         [self addModalCtrl];
     }];
  //  tabbar.delegate =self;
   
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
   
    //更改为tabBarItem
    ctrl.tabBarItem =[LCIWTabBarItem new];
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



//如果是代理就用 >> 代理的点击事件
//-(void)tabbar:(LCTabBar *)tabbar btnClick:(UIButton *)btn{
//    
//   // NSLog(@"xzfa");
//    NSLog(@"%s",__func__);
//    
//    
//
//}




//block的点击事件
-(void)addModalCtrl{
    LCComposeView *composeView =[[LCComposeView alloc]initWithTagert:self];
    [composeView show];
    
//    不应该从主窗口弹出来
//  [self.view addSubview:composeView];
//    UIWindow *window =[UIApplication sharedApplication].keyWindow;
//    [window addSubview:composeView];
//    [composeView startAnim];
    
    
}






@end
