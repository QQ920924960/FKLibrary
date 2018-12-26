//
//  FKPlaceholderTextView.m
//  HHShopping
//
//  Created by frank on 2018/9/13.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import "FKPlaceholderTextView.h"

@interface FKPlaceholderTextView()

@property(nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation FKPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.font = [UIFont systemFontOfSize:14];
    
    UILabel *placeholderLabel = [[UILabel alloc] init];
    [self addSubview:placeholderLabel];
    self.placeholderLabel = placeholderLabel;
    placeholderLabel.textColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:204/255.0 alpha:1.0];
    placeholderLabel.font = [UIFont systemFontOfSize:14];
    placeholderLabel.numberOfLines = 0;
    [placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(6);
        make.right.equalTo(self).offset(-5);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)textValueChanged:(NSNotification *)noti
{
    self.placeholderLabel.hidden = self.text.length > 0;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.placeholderLabel.text = placeholder;
    self.placeholderLabel.hidden = self.text.length > 0;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    self.placeholderLabel.hidden = self.text.length > 0;
}

@end
