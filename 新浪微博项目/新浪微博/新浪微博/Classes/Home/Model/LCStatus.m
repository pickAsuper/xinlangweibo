//
//  LCStatus.m
//  新浪微博
//
//  Created by lichao on 15/8/1.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCStatus.h"
#import "MJExtension.h"
#import "LCPhoto.h"

@implementation LCStatus

+(NSDictionary *)objectClassInArray{
   //告诉pic_ids 集合里面存的是神马对象 >>框架转
    return @{@"pic_urls":[LCPhoto class]};
 
}

@end

