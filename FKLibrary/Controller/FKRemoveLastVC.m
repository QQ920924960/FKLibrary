//
//  FKRemoveLastVC.m
//  BaiYeMallShop
//
//  Created by frank on 2018/12/3.
//  Copyright © 2018 凯叔叔. All rights reserved.
//

#import "FKRemoveLastVC.h"

@interface FKRemoveLastVC ()

@end

@implementation FKRemoveLastVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isNeedRemoveBeforeVc) {
        [self fk_removeBeforeVC];
    }
}

@end
