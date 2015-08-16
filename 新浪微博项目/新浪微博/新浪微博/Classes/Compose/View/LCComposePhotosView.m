//
//  LCComposePhotosView.m
//  新浪微博
//
//  Created by lichao on 15/8/9.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCComposePhotosView.h"
#import "LCComposePhotoView.h"

#define MARGIN 10

@implementation LCComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =randomColor;
    }
    return self;
}

-(void)addImage:(UIImage *)image{
    LCComposePhotoView *imageView = [[LCComposePhotoView alloc]init];
    imageView.image=image;
    [self addSubview:imageView];

}
-(NSArray *)images{

    return [self.subviews valueForKeyPath:@"image"];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    NSInteger maxC =3;
    
    CGFloat childViewWH  =(SCREENW - 2 * MARGIN) /maxC;
    for (int i = 0 ; i < count; i++) {
       
        UIView *view =self.subviews[i];
        
        view.size = CGSizeMake(childViewWH, childViewWH);
        NSLog(@"%zd",childViewWH);
        int col =i % maxC;
        int row =i /maxC;
        if (view.x == 0 && view.y == 0) {
            
            view.x = col * (childViewWH + MARGIN);
            view.y =row * (childViewWH + MARGIN);
        }else{
            [UIView animateWithDuration:0.25 animations:^{
           view.x=col *(childViewWH + MARGIN);
         view.y =row *(childViewWH + MARGIN);
            }];
        }
    }

 

}

@end
