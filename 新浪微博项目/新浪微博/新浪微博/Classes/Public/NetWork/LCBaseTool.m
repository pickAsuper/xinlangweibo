//
//  LCBaseTool.m
//  新浪微博
//
//  Created by lichao on 15/8/6.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCBaseTool.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "LCHttpTool.h"


@implementation LCBaseTool
+(void)getWithUrl:(NSString *)url params:(NSDictionary *)params class:(Class)clazz success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure{
//    
//    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
//    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *op, id responseObject) {
//        
//        if (success) {
//          // 字典转模型
//            id status =[[clazz alloc]init];
//            [status setKeyValues:responseObject];
//     
//            success(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
    [LCHttpTool getWithUrl:url parames:params scessuce:^(id responseObject) {
        if (success) {
            id result =[[clazz alloc]init];
            [result setKeyValues:responseObject];
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

}

+(void)postWithUrl:(NSString *)url params:(NSDictionary *)params class:(Class)clazz success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure{
     [LCHttpTool postWithUrl:url parames:params scessuce:^(id responseObject) {
         if (success) {
             id result =[[clazz alloc]init];
             [result setKeyValues:responseObject];
             success(result);
         }
     } failure:^(NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
  


}
@end
