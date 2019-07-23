//
//  PersonModel.h
//  LearnMsgTransation
//
//  Created by Mac on 2019/6/29.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CompanyModel;

@interface PersonModel : NSObject

@property (nonatomic, copy) NSString* firstName;
@property (nonatomic, copy) NSString* lastName;

//这个属性在实现文件里面设置为动态属性、所以并不会生成get和set方法
@property (nonatomic, copy) NSString* name;

//两个没有实现的方法
- (NSString *)companyName;
- (NSString *)deptName;
@end
