//
//  CompanyModel.m
//  LearnMsgTransation
//
//  Created by Mac on 2019/6/29.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "CompanyModel.h"
/**
 * 这个类的作用就是实现某各类没有实现的方法 用于消息转发
 */
@implementation CompanyModel

- (NSString *)companyName{
    return @"宇宙最强公司";
}

- (NSString *)deptName:(BOOL)isWithCompanyName{
    if (isWithCompanyName) {
        return @"外包公司研发部";
    }else{
        return @"BAT巨头独角兽研发部";
    }
}

@end
