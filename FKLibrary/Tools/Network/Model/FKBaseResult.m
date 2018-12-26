//
//  FKBaseResult.m
//  HHShopping
//
//  Created by frank on 2018/8/13.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import "FKBaseResult.h"

@implementation FKBaseResult

- (void)setCode:(NSString *)code
{
    _code = code;
    
    if ([code isEqualToString:@"200"]) {
        _success = true;
    }
}

@end
