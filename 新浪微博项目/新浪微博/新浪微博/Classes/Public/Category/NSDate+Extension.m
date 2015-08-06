//
//  NSDate+Extension.m
//  新浪微博
//
//  Created by lichao on 15/8/6.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/*  判读是否与当前时间是同一年
*
*  @param date 传入对比的时间
*
*  @return
*/
+(BOOL)isThisYearWithDate:(NSDate *)date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    
    //时间格式
    formatter.dateFormat =@"yyyy";
    
    //创建时间
    NSDate *createDate =date;
    
    //获取当前时间
    NSDate *currentDate =[NSDate date];
    
    formatter.dateFormat =@"yyyy";
    NSString *create =  [formatter stringFromDate:createDate];
    NSString *current =[formatter stringFromDate:currentDate];
    return [create isEqualToString:current];
    


}

/**
 *  判读是否与当前时间是同一天 是否为今天?
 *
 *  @param date
 *
 *  @return
 */
+ (BOOL) isTodayWithDate:(NSDate *)date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    formatter.dateFormat =@"yyyy-MM-dd";
    
    NSDate *creatDate = date;
    NSDate *currentDate =[NSDate date];
    
    NSString *creat = [formatter stringFromDate:creatDate];
    //当前时间
    NSString *current = [formatter stringFromDate:currentDate];
    
    return [creat isEqualToString:current];


}


/**
 *  与当前时间对比,判断是否是昨天
 *
 *  @param date
 *
 *  @return
 */
+ (BOOL) isYesterdayWithDate:(NSDate *)date{
    //当前时间
    NSDate *currentDate =[NSDate date];
    
    //取出当前日历
    NSCalendar *canlender =[NSCalendar currentCalendar];
    
    //设置对比 对象 年 月 日 时 分 秒
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    
    NSDateComponents *components = [canlender components:unit fromDate:date toDate:currentDate options:NSCalendarWrapComponents];
    
    return components.day ==1;


}




@end
