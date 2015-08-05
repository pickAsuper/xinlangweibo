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

@end

