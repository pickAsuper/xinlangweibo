//
//  LCBaseTool.h
//  新浪微博
//
//  Created by lichao on 15/8/6.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCBaseTool : NSObject

/**
 *  抽取AFN方法  >> 多传入一个模型类进来
 *
 *  @param url     <#url description#>
 *  @param params  <#params description#>
 *  @param clazz   <#clazz description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)getWithUrl:(NSString *)url params:(NSDictionary *)params class:(Class)clazz success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+(void)postWithUrl:(NSString *)url params:(NSDictionary *)params class:(Class)clazz success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
