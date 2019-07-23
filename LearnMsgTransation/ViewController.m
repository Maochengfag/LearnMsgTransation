//
//  ViewController.m
//  LearnMsgTransation
//
//  Created by Mac on 2019/6/29.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "PersonModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    PersonModel *personModel = [[PersonModel alloc] init];
    
    //    //消息转发  resolveInstanceMethod
    personModel.name = @"Jim Green";
    NSString *name = personModel.name;
    NSLog(@" %@", name);
    //消息转发 forwardingTargetForSelector
    NSString *name1 = [personModel companyName];
    NSLog(@" %@", name1);
    //    //消息转发 forwardInvocation
    NSString *name2 = [personModel deptName];
    NSLog(@" %@", name2);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
