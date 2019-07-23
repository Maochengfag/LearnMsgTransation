//
//  PersonModel.m
//  LearnMsgTransation
//
//  Created by Mac on 2019/6/29.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "PersonModel.h"
#import "CompanyModel.h"
#import <objc/runtime.h>

@interface PersonModel()
@property (nonatomic, strong) CompanyModel *companyMode;
@end

@implementation PersonModel
//这个意味着不会生成name属性的get和set方法的实现
@dynamic name;

- (id)init{
    self = [super init];
    if (self) {
        _companyMode = [[CompanyModel alloc] init];
    }
    return self;
}

/**
 *  在这个实验中，通过这个方法来实现name属性的处理。其他两个转发的处理则放到下一步
 *
 *  @param sel 要处理的属性
 *
 *  @return 返回YES处理方法或者NO转发到下一步
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"resolveInstanceMethod");
    //方法名
    NSString *selStr = NSStringFromSelector(sel);
    if ([selStr isEqualToString:@"name"]) {
        //增加方法
        class_addMethod(self, sel, (IMP)nameGetter, "v@:");
        return YES;
    }
    
    if ([selStr isEqualToString:@"setName:"]) {
        class_addMethod(self, sel, (IMP)nameSetter, "V@:@");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

/**
 *  这个方法用于处理name方法的消息转发
 *
 *  @param self 对象自己
 *  @param cmd  方法名
 *
 *  @return 返回得到的值
 */
id nameGetter(id self, SEL  cmd){
    PersonModel *model = (PersonModel *)self;
    NSMutableString *name = [NSMutableString string];
    if (model.firstName != nil) {
        [name appendString:model.firstName];
        [name appendString:@" "];
    }
    if (model.lastName != nil) {
        [name appendString:model.lastName];
    }
    
    return name;
}
/**
 *  这个方法实现对setName方法的转发处理
 *
 *  @param self  对象
 *  @param cmd   方法
 *  @param value 传入的值
 */
void nameSetter(id self, SEL cmd, id value){
    NSString *fullName = value;
    NSArray *nameArray = [fullName componentsSeparatedByString:@" "];
    PersonModel *model = (PersonModel *)self;
    
    //在转发方法中实现对两个属性的赋值
    model.firstName = nameArray[0];
    model.lastName = nameArray[1];
}
/**
 *  这里companyName这个方法则转到self.companyModel来处理，其他的下一步
 *
 *  @param aSelector 方法
 *
 *  @return 返回转发的处理对象或者nil
 */

- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"forwardingTargetForSelector ");
    NSString *selStr = NSStringFromSelector(aSelector);
    
    if ([selStr isEqualToString:@"companyName"]) {
        return self.companyMode;
    }else{
        return [super forwardingTargetForSelector:aSelector];
    }
}
/**
 *  是自己新建方法签名，再在forwardInvocation中用你要转发的那个对象调用这个对应的签名，这样也实现了消息转发。
 *
 *  @param aSelector 方法名
 *
 *  @return 返回一个签名
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSLog(@"methodSignatureForSelector");
    NSMethodSignature *sig = nil;
    NSString *selStr = NSStringFromSelector(aSelector);
    //判断你要转发的SEL
    if ([selStr isEqualToString:@"deptName"]) {
        //此处返回的sig是方法forwardInvocation的参数anInvocation中的methodSignature
        //为你的转发方法手动生成签名
        sig = [self.companyMode methodSignatureForSelector:@selector(deptName:)];
    }else{
        sig = [super methodSignatureForSelector:aSelector];
    }
    
    return sig;
}

/**
 *  转发方法打包转发出去
 *
 *  @param anInvocation .b..in,mhm mmkmllwr4ghc ct b4y6
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"forwardInvocation");
    NSString *selStr = NSStringFromSelector(anInvocation.selector);
    if ([selStr isEqualToString:@"deptName"]) {
        //设置处理转发的对象
        [anInvocation setTarget:self.companyMode];
        //设置转发对象要用的方法
        [anInvocation setSelector:@selector(deptName:)];
        BOOL hasCompanyName = YES;
        //第一个和第二个参数是target和sel
        [anInvocation setArgument:&hasCompanyName atIndex:2];
        [anInvocation retainArguments];
        [anInvocation invoke];
    }else{
        [super forwardInvocation:anInvocation];
    }
    
}


@end
