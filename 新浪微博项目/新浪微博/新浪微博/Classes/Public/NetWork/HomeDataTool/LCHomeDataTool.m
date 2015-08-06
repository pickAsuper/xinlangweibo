//
//  LCHomeDataTool.m
//  新浪微博
//
//  Created by lichao on 15/8/7.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCHomeDataTool.h"
#import "LCStatusRes.h"
#import "LCAccountTool.h"
#import "LCOauth.h"
#import "LCBaseTool.h"
#import "MJExtension.h"
#import "LCUnReacount.h"
@implementation LCHomeDataTool
//首页数据参数的提取
+(void)getStatusWithSinceId:(long long)sinceId maxId:(long long)maxId count:(NSInteger)count success:(void(^)(LCStatusRes *res))success failure:(void(^)(NSError *error))failure{
    //请求地址
    NSString *str =@"https://api.weibo.com/2/statuses/friends_timeline.json";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 解档模型取值
    LCOauth *oau =[LCAccountTool AccountOpen];
    params[@"access_token"] = oau.access_token;
    params[@"count"] =@(count);
    params[@"since_id"]=@(sinceId);
    params[@"maxId"]=@(maxId);
    
      //继承自LCBaseTool
    [self getWithUrl:str params:params class:[LCStatusRes class] success:success failure:failure];
    
    
}
/**
 *  对应未对条数的 AFN参数提取的方法
 */

+(void)getUnReadUid:(NSString *)uid success:(void(^)(LCUnReacount *res))success failure:(void(^)(NSError *))failure{
    NSString *str =@"https://rm.api.weibo.com/2/remind/unread_count.json";
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    
    LCOauth *oua =[LCAccountTool AccountOpen];
    dict[@"access_token"]=oua.access_token;
    dict[@"uid"]=oua.uid;
    [self getWithUrl:str params:dict class:[LCStatusRes class] success:success failure:failure];



}



@end
