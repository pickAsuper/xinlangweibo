//
//  LCHttpTool.h
//  新浪微博
//
//  Created by lichao on 15/8/6.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCHttpTool : NSObject

/**
 *  抽取获取网络请求的 GET方法
 *  @param url    请求的网址
 *  @param params  请求参数
 *  @param scessuce  成功的回调block
 *  @param failure  失败回调的block
 */
+(void)getWithUrl:(NSString *)url parames:(NSDictionary *)params scessuce:(void(^)(id responseObject))scessuce failure:(void(^)(NSError *error))failure;

/**
 *  抽取获取网络请求的 POST方法
 *
 *  @param url    请求的网址
 *  @param params  请求参数
 *  @param scessuce  成功的回调block
 *  @param failure  失败回调的block
 */
+(void)postWithUrl:(NSString *)url parames:(NSDictionary *)params scessuce:(void(^)(id responseObject))scessuce failure:(void(^)(NSError *error))failure;


@end
