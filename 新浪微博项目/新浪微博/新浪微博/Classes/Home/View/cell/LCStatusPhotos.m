//
//  LCStatusPhotos.m
//  新浪微博
//
//  Created by lichao on 15/8/3.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCStatusPhotos.h"
#import "LCStatusFrame.h"

@implementation LCStatusPhotos

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor redColor];
    }
    return self;
}
/**
 *  根据自己的显示个数,返回自己的大小*/
+(CGSize)sizeWithCount:(NSInteger)count{
   //计算photoView的大小 > 根据图片的张数
    //根据不同的个数返回不同的列数与行数 >> 4个的情况
    NSInteger maxCR = count == 4?2:3;
    
//    根据张数求出有多帅列和多少行
    NSInteger col = count < maxCR ?count :maxCR;
    NSInteger row = (count + (maxCR -1))/maxCR;
    
    CGFloat childWidth = 70;
    CGSize photoViewSize =CGSizeMake(col * childWidth+(col-1) * MARGIN, row*childWidth + (row - 1)* MARGIN);
    NSLog(@"photoViewSize =%zd",photoViewSize);
    return photoViewSize;
    
 


}
@end
