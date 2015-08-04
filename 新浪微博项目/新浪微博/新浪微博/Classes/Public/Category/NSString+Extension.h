//
//  NSString+Extension.h
//  新浪微博
//
//  Created by lichao on 15/8/4.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

-(CGSize )sizeWithFont:(UIFont *)font ;

-(CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end
