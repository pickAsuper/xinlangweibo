//
//  NSString+Extension.m
//  新浪微博
//
//  Created by lichao on 15/8/4.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
-(CGSize )sizeWithFont:(UIFont *)font{
   NSDictionary *att = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [self sizeWithAttributes:att];
}

-(CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
   NSDictionary *att = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil].size;
    
}


@end
