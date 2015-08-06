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
#import "NSDate+Extension.h"

@implementation LCStatus

+(NSDictionary *)objectClassInArray{
   //告诉pic_ids 集合里面存的是神马对象 >>框架转
    return @{@"pic_urls":[LCPhoto class]};
 
}
-(void)setSource:(NSString *)source{
    _source=source;
 // <a href="http://app.weibo.com/t/feed/4fuyNj" rel="nofollow">即刻笔记</a>
  
  //用NSRange 的时候要判断
   NSRange range = [source rangeOfString:@"\">"];

    if (range.location != NSNotFound) {
        //如果有 开始的位置
        NSRange subRange;
        subRange.location =range.length+range.location;
        
        //截取 >> 结束的位置
        NSInteger location = [source rangeOfString:@"</"].location;
        
         //截取的位置不为空
        if (location != NSNotFound) {
            
            subRange.length =[source rangeOfString:@"</"].location-subRange.location;
            
           
          _source = [NSString stringWithFormat:@"来源 %@",[source substringWithRange:subRange]];
        }
    }
}
-(NSString *)created_at{
   
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
     //指定格式
    formatter.dateFormat = @"EEE MM dd HH:mm:ss z yyyy";
     //指定地区 //如果是真机,一定要指定个这locale,标明这个时间是什么样标识 /(美国)
   // formatter.locale =[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    //转成 2014-05-01 09:17:31
    NSDate *createDate =[formatter dateFromString:_created_at];
//    NSLog(@"date%@",date);
    formatter.dateFormat =@"yyyy-MM-dd HH:mm:ss";
   // _created_at = [formatter stringFromDate:date];
    NSDate *currentDate =[NSDate date];
   
    if ([NSDate isThisYearWithDate:createDate]) {
        //是今年 >>在继续判断是在 今天 或 昨天
          NSLog(@"是今年");
        if ([NSDate isTodayWithDate:createDate]) {
             //是今天 >> 还得去判断在今天的什么时间之前
          NSDate *retulDate = [createDate dateByAddingTimeInterval:60];
            if ([retulDate compare:currentDate]==NSOrderedDescending) {
                //显示多少分钟前
                return @"刚刚";
            }else{
                 retulDate = [createDate dateByAddingTimeInterval:3600];
            if ([retulDate compare:currentDate] == NSOrderedDescending) {
                
                NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:createDate];
                 //得到分钟
                NSInteger min = timeInterval/60;
               return [NSString stringWithFormat:@"%zd分钟前",min];
            }else{
              NSTimeInterval timeinterval = [currentDate timeIntervalSinceDate:createDate];
               NSInteger integer = timeinterval/3600;
               return [NSString stringWithFormat:@"%zd小时前",integer];
              }
            }
            
            
            
        }else{
            if ([NSDate isYesterdayWithDate:createDate]) {
                //不是今天>>昨天
                
                formatter.dateFormat =@"昨天 HH:mm";
                return [formatter stringFromDate:createDate];
            }else{
                 //不是今天先这么去显示:08-01 15-03
                formatter.dateFormat =@"MM-dd HH:mm";
                return [formatter stringFromDate:createDate];
    
            }
        
        }
   
      }else{
      
          //不是今年
      formatter.dateFormat =@"yyyy-MM-dd HH:mm:ss";
          return [formatter stringFromDate:createDate];
       }
     }

//判断是否是今年
//-(BOOL)isThisYearWithDate:(NSDate *)date{
//    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
//    
//     //时间格式
//    formatter.dateFormat =@"yyyy";
//    
//    //创建时间
//    NSDate *createDate =date;
//
//    //获取当前时间
//    NSDate *currentDate =[NSDate date];
//
//      formatter.dateFormat =@"yyyy";
//    NSString *create =  [formatter stringFromDate:createDate];
//    NSString *current =[formatter stringFromDate:currentDate];
//    return [create isEqualToString:current];
//    
//
//
//}
////判断是否是今天
//-(BOOL)isTodayWithDate:(NSDate *)date
//{
//    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
//    formatter.dateFormat =@"yyyy-MM-dd";
//    
//    NSDate *creatDate = date;
//    NSDate *currentDate =[NSDate date];
//    
//   NSString *creat = [formatter stringFromDate:creatDate];
//    //当前时间
//   NSString *current = [formatter stringFromDate:currentDate];
//    
//    return [creat isEqualToString:current];
//
//}
////判断是否为昨天
//-(BOOL)isYesterdayWithDate:(NSDate *)date{
//    
//    //当前时间
//    NSDate *currentDate =[NSDate date];
//    
//    //取出当前日历
//    NSCalendar *canlender =[NSCalendar currentCalendar];
//    
//    //设置对比 对象 年 月 日 时 分 秒
//    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
//    
//   NSDateComponents *components = [canlender components:unit fromDate:date toDate:currentDate options:NSCalendarWrapComponents];
//    
//    return components.day ==1;
//    
//    
//    
//    
//
//
//
//
//}


@end

