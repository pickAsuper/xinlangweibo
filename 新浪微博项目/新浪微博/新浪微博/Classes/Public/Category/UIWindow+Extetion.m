//
//  UIWindow+Extetion.m
//  新浪微博
//
//  Created by lichao on 15/7/31.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "UIWindow+Extetion.h"
#import "LCOauth.h"
#import "LCTabBarController.h"
#import "LCOAuthViewCtrl.h"

@implementation UIWindow (Extetion)

-(void)switchRootViewCtrl{

   // 下面这段代码个新特性的选择window控制器重复 抽取出来一个工具类来解档和选择根控制器
            //把模型解档
            NSString *pathField =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            //拼接一个路径 account.archiver
            pathField = [pathField stringByAppendingPathComponent:@"account.archiver"];
    
            //解档
            LCOauth *ot = [NSKeyedUnarchiver unarchiveObjectWithFile:pathField];
            NSLog(@"pathFiel =%@",pathField);
            if (!ot) {
    
                self.rootViewController =[LCOAuthViewCtrl new];
    
            }else{
    
                self.rootViewController =[LCTabBarController new];
    
            }


}


@end
