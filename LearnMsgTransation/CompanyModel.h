//
//  CompanyModel.h
//  LearnMsgTransation
//
//  Created by Mac on 2019/6/29.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyModel : NSObject

- (NSString *)companyName;

- (NSString *)deptName:(BOOL)isWithCompanyName;
@end
