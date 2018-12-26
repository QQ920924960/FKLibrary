//
//  FKPayMethodCell.h
//  FKLibraryExample
//
//  Created by frank on 2018/10/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FKTableCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FKPayMethodCell : FKTableCell

@property (nonatomic)UILabel *nameLabel;
@property (nonatomic)UIImageView * payImageView;
@property (nonatomic)NSString *defaultSelect;
@property (nonatomic)UILabel *paymentLab;
@property (nonatomic)UIImageView *selectedImageView;

@property (nonatomic)NSString *moneyStr;//金额数

@end

NS_ASSUME_NONNULL_END
