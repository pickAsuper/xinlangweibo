//
//  LCAccountTool.m
//  新浪微博
//
//  Created by lichao on 15/7/31.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCAccountTool.h"
#import "LCTabBarController.h"
#import "LCOauth.h"

#define KeyAechver [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"account.archiver"]

@implementation LCAccountTool
+(void)accountTool:(LCOauth *)oauth{
//    //把模型归档保存
//    NSString *pathField =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    //拼接一个路径 account.archiver
//    pathField = [pathField stringByAppendingPathComponent:@"account.archiver"];
//    
  
    //归档
   [NSKeyedArchiver archiveRootObject:oauth toFile:KeyAechver];
    
    
   }

//解档
+(LCOauth *)AccountOpen{
   
//   LCOauth *account = [NSKeyedUnarchiver unarchiveObjectWithFile:KeyAechver];
//    
//    //计算超时时间
//   NSDate *expiresDate = [account.create_at dateByAddingTimeInterval:account.expires_in];
////     计算出当前时间
//    NSDate *currentData =[NSDate date];
////    比较两个时间
//  NSComparisonResult result =  [currentData compare:expiresDate];
////    如果是升序就解档 说明时间没过期
//    if (result == NSOrderedAscending) {
//      
//        return account;
//        
//    }
//       return nil;
//    
//    
//    
//   }

    LCOauth *accout =[NSKeyedUnarchiver unarchiveObjectWithFile:KeyAechver];
    NSLog(@"accout.access_token%@",accout.access_token);
    NSLog(@"uid%@",accout.uid);
    NSLog(@"expires_in%ld",(long)accout.expires_in);
    //判断是否过期

    //计算出过期的时间
    NSDate *expiresDate = [accout.create_at dateByAddingTimeInterval:accout.expires_in];
    
    NSLog(@"过期时间是%@",expiresDate);
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSLog(@"当前时间是%@",currentDate);

    //  account.create_at + account.过期时间     与   当前时间进行对比
    
    NSComparisonResult result = [currentDate compare:expiresDate];
   
    if (result == NSOrderedAscending) {
        //不过期
        return accout;
    }
    return nil;
    //return accout;
}
@end
