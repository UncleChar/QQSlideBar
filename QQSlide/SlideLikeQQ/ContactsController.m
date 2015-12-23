//
//  ContactsController.m
//  SlideLikeQQ
//
//  Created by LingLi on 15/12/23.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import "ContactsController.h"

@implementation ContactsController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel  *label = [[UILabel alloc]init];
    label.text = @"联系人";
    label.font = [UIFont boldSystemFontOfSize:30];
    label.textColor = [UIColor colorWithRed:252/255.0 green:166.0/255.0 blue:41.0/255.0 alpha:1];
    label.textAlignment = 1;
    label.frame = CGRectMake(self.view.frame.size.width / 2 - 100, self.view.frame.size.height / 2 - 40, 200, 80);
    [self.view addSubview:label];
}

@end
