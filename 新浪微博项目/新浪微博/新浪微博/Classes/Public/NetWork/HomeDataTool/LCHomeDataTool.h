//
//  LCHomeDataTool.h
//  新浪微博
//
//  Created by lichao on 15/8/7.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCStatusRes.h"
#import "LCBaseTool.h"
#import "LCUnReacount.h"
@interface LCHomeDataTool : LCBaseTool

//提取首页的参数 对应的方法
+(void)getStatusWithSinceId:(long long)sinceId maxId:(long long)maxId count:(NSInteger)count success:(void(^)(LCStatusRes *res))success failure:(void(^)(NSError *error))failure;

/**
 *  对应未对条数的 AFN参数提取的方法
 */

+(void)getUnReadUid:(NSString *)uid success:(void(^)(LCUnReacount *res))success failure:(void(^)(NSError *))failure;


@end
