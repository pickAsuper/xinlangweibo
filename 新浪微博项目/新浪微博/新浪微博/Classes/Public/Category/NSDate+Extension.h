//
//  NSDate+Extension.h
//  新浪微博
//
//  Created by lichao on 15/8/6.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  判读是否与当前时间是同一年
 *
 *  @param date 传入对比的时间
 *
 *  @return
 */
+(BOOL)isThisYearWithDate:(NSDate *)date;

/**
 *  判读是否与当前时间是同一天 是否为今天?
 *
 *  @param date
 *
 *  @return
 */
+ (BOOL) isTodayWithDate:(NSDate *)date;


/**
 *  与当前时间对比,判断是否是昨天
 *
 *  @param date
 *
 *  @return
 */
+ (BOOL) isYesterdayWithDate:(NSDate *)date;

@end
