//
//  LCAccountTool.h
//  新浪微博
//
//  Created by lichao on 15/7/31.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCOauth;

@interface LCAccountTool : NSObject

//归档
+(void)accountTool:(LCOauth *)oauth;

//解档
+(LCOauth *)AccountOpen;



@end
