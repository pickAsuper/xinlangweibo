//
//  AppDelegate.m
//  新浪微博
//
//  Created by lichao on 15/7/27.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "AppDelegate.h"
#import "LCTabBarController.h"
#import "LCNewFeatureCtrl.h"
#import "LCOAuthViewCtrl.h"
#import "LCOauth.h"
#import "UIWindow+Extetion.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([[UIDevice currentDevice].systemVersion doubleValue]>=8.0 ) {
       UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
     ////注册这个设置--只要我们一注册这个设置,就会在启动的时候应用里面会提示用户是否允许弹这个BadgeNumber
        [application registerUserNotificationSettings:setting];
    }
    
    
    //创建主窗口
    self.window =[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //加载根控制器
    [self switchRootViewCtrl];
    

    [self.window makeKeyAndVisible];
  
    return YES;
}
-(void)switchRootViewCtrl{
    //获取偏好设置
   // NSLog(@"%@",[NSBundle mainBundle].infoDictionary);
    //取出当前的版本号version
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    NSString *version = info[VERSION];
  
    
    //取出保存的版本号
    NSString *saveVesion =[[NSUserDefaults standardUserDefaults] stringForKey:VERSION];
    NSComparisonResult result = [version compare:saveVesion];
    //如果不是当前版本号 .或者 当前的版本号大于了本地保存的版本号都要显示新特性
    if (!saveVesion || result ==NSOrderedAscending) {
       
        //保存偏好设置
        [[NSUserDefaults standardUserDefaults]setObject:version forKey:VERSION];
        //同步
        [[NSUserDefaults standardUserDefaults]synchronize];
        self.window.rootViewController =[LCNewFeatureCtrl new];
    }else{  //否则 直接进入
        
        [self.window switchRootViewCtrl];
          
        
        //下面这段代码个新特性的选择window控制器重复 抽取出来一个工具类来解档和选择根控制器
//        //把模型解档
//        NSString *pathField =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        //拼接一个路径 account.archiver
//        pathField = [pathField stringByAppendingPathComponent:@"account.archiver"];
//        
//        //解档
//        LCOauth *ot = [NSKeyedUnarchiver unarchiveObjectWithFile:pathField];
//        NSLog(@"pathFiel =%@",pathField);
//        if (!ot) {
//
//            self.window.rootViewController =[LCOAuthViewCtrl new];
//            
//        }else{
//        
//            self.window.rootViewController =[LCTabBarController new];
//
//        }
        
    }


}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//后台挂起状态
- (void)applicationDidEnterBackground:(UIApplication *)application {
  
    
    //1.定义一个identifier
    //2.开启一个后台的任务-->配置block-->identifier这个时候identifier是没有值
    //3.开启一个后台的任务的返回值赋值给identifier
    
    __block UIBackgroundTaskIdentifier identifier =[application beginBackgroundTaskWithExpirationHandler:^{
         [application endBackgroundTask:identifier];
     }];
    
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
