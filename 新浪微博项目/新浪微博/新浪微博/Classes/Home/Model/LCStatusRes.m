//
//  LCStatusRes.m
//  新浪微博
//
//  Created by lichao on 15/8/6.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCStatusRes.h"
#import "MJExtension.h"
#import "LCStatus.h"
@implementation LCStatusRes

//把这个模型类的值放在数组里面 >>返回的是字典
+ (NSDictionary *)objectClassInArray{
    return @{@"statuses" : [LCStatus class]};
}
@end
