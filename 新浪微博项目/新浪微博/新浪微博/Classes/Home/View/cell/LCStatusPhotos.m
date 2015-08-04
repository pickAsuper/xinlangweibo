//
//  LCStatusPhotos.m
//  新浪微博
//
//  Created by lichao on 15/8/3.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCStatusPhotos.h"
#import "LCStatusFrame.h"
#import "LCStatusPhoto.h"
#import "LCStatus.h"
#import "LCPhoto.h"

//文字大小
#define CHILD_WH 70

@implementation LCStatusPhotos

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        for (int i = 0 ; i < 9; i++) {
            
        

         //在这个view上面添加一个imageView >> LCStatusPhoto 来展示图片
        LCStatusPhoto *statusPhoto =[[LCStatusPhoto alloc]init];
            
        [self addSubview:statusPhoto];
        
        }
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
//重写set方法给pic_url 数组 赋值 为了计算 >> LCStatusPhoto 位置
-(void)setPic_url:(NSArray *)pic_url{
    _pic_url =pic_url;

    //   cell的重用  >> 先把里面的图片隐藏
//    for (int i = 0 ; i < self.subviews.count; i++) {
//        UIView *view = self.subviews[i];
//        view.hidden =YES;
//        
//    }
    //   cell的重用  >> 先把里面的图片隐藏 >>和上面方法同样效果
    [self.subviews makeObjectsPerformSelector:@selector(setHidden:) withObject:@(YES)];
    
//    根据图片张数去设置view的个数
    for (int i = 0 ; i < pic_url.count; i++) {
         //创建View上面的iamgeView LCStatusPhoto
        NSLog(@"数组%zd",self.subviews[i]);
        LCStatusPhoto *imageView = self.subviews[i];

        //要用到这个图片 我就把它显示一下
        imageView.hidden =NO;
        
        //再取出照片模型赋值
        LCPhoto *photo = pic_url[i];
        imageView.photo =photo;
        
        
        
    }
    
    
    
    

}


//布局view上面的子控件 >>LCStatusPhoto
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //根据图片张数才能布局位置
    //怎么才能拿到图片张数呢?? >>就定义一个数组来从模型里面获取图片张数
   NSInteger count = self.pic_url.count;
    NSInteger maxCR = count == 4?2:3;
    
    CGFloat childWidth = CHILD_WH ; // 子控件的宽度是 70
    
    //需要像布局九宫格那样布局子控件
    for (int i = 0 ; i < count; i++) {
         //计算列数
        NSInteger col = i % maxCR;
        
        //计算行数
        NSInteger row =i / maxCR;
        
        //获取到子控件 >> imageView LCStatusPhoto
        LCStatusPhoto *childView =self.subviews[i];
        
     
         //imageView 的位置
        childView.size = CGSizeMake(childWidth, childWidth);
        childView.x =col *(childWidth +MARGIN);
        childView.y =row *(childWidth +MARGIN);
        
        
    }

    

}
@end
