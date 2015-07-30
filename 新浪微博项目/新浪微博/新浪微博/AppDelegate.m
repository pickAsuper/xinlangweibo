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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
//    //获取偏好设置
//    NSLog(@"%@",[NSBundle mainBundle].infoDictionary);
//     //取出当前的版本号version
//  NSDictionary *info = [NSBundle mainBundle].infoDictionary;
//   NSString *version = info[VERSION];
//    
//    
//    //创建主窗口
    self.window =[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
//    //取出保存的版本号
//   NSString *saveVesion =[[NSUserDefaults standardUserDefaults] stringForKey:VERSION];
//    
//    //如果不是当前版本号 .或者 当前的版本号大于了本地保存的版本号都要显示新特性
//    if (!version || [version compare:saveVesion]) {
//         //创建新特性
//        LCNewFeatureCtrl *newFeat =[[LCNewFeatureCtrl alloc]init];
//        self.window.rootViewController =newFeat;
//        
//        //保存偏好设置
//        [[NSUserDefaults standardUserDefaults]setObject:version forKey:VERSION];
//         //同步
//      [[NSUserDefaults standardUserDefaults]synchronize];
//
//    }else{  //否则 直接进入
//        LCTabBarController *tabbarCtrl =[[LCTabBarController alloc]init];
//        self.window.rootViewController = tabbarCtrl;
//
    
//    }
    
    LCOAuthViewCtrl *oatuth =[[LCOAuthViewCtrl alloc]init];
    self.window.rootViewController=oatuth;
    
    
    
    
    
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
