//
//  LCOauth.m
//  新浪微博
//
//  Created by lichao on 15/7/30.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCOauth.h"

@implementation LCOauth

//重写expires_in 赋值时间
-(void)setExpires_in:(NSInteger)expires_in{
    _expires_in =expires_in;
    self.create_at =[NSDate date];
}
//获取的数据进行归档操作
-(void)encodeWithCoder:(NSCoder *)encode{
    [encode encodeInteger:self.expires_in forKey:@"expires_in"];
    [encode encodeObject:self.access_token forKey:@"access_token"];
    [encode encodeObject:self.remind_in forKey:@"remind_in"];
    [encode encodeObject:self.uid forKey:@"uid"];
    
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self =[super init]) {
        self.expires_in =  [aDecoder decodeIntegerForKey:@"expires_in"];
        self.access_token =[aDecoder decodeObjectForKey:@"access_token"];
        self.remind_in =[aDecoder decodeObjectForKey:@"remind_in"];
        self.uid =[aDecoder decodeObjectForKey:@"uid"];

    
    }
    return self;
    
}
@end
