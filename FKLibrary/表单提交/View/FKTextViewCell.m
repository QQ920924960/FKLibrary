//
//  FKTextViewCell.m
//  BaiYeMallShop
//
//  Created by frank on 2018/11/29.
//  Copyright © 2018 凯叔叔. All rights reserved.
//

#import "FKTextViewCell.h"
#import "FKPlaceholderTextView.h"

@interface FKTextViewCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) FKPlaceholderTextView *textView;
@property (nonatomic, weak) UILabel *numLabel;

@end

@implementation FKTextViewCell

- (void)setupSubviews
{
    [super setupSubviews];
    
    UILabel *titleLabel = [UILabel fk_labelWithFont:fkFont14 textColor:fkColor333333];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    FKPlaceholderTextView *textView = [[FKPlaceholderTextView alloc] init];
    [self.contentView addSubview:textView];
    self.textView = textView;
    textView.font = fkFont13;
    textView.textColor = fkColor333333;
//    textView.backgroundColor = [UIColor redColor];
    
    UILabel *numLabel = [UILabel fk_labelWithFont:fkFont12 textColor:fkColorAEAEAE textAlignment:NSTextAlignmentRight text:@"0/500字以内"];
    [self.contentView addSubview:numLabel];
    self.numLabel = numLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self).offset(12);
    }];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12);
        make.bottom.equalTo(self).offset(-15);
    }];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(titleLabel.mas_bottom).offset(15);
        make.bottom.equalTo(self).offset(-28);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueFieldEndEditing:) name:UITextViewTextDidEndEditingNotification object:textView];
}

- (void)valueFieldEndEditing:(NSNotification *)noti
{
    FKPlaceholderTextView *textView = (FKPlaceholderTextView *)noti.object;
    self.item[@"value"] = textView.text;
}

- (void)setItem:(NSMutableDictionary *)item
{
    [super setItem:item];
    
    self.titleLabel.text = item[@"title"];
    self.textView.text = item[@"value"];
    self.textView.placeholder = item[@"placeholder"];
    self.numLabel.hidden = ![item[@"showNumLabel"] boolValue];
    
    if (!item[@"title"]) {
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel);
        }];
    }
    if (self.numLabel.isHidden) {
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-12);
        }];
    }
}

@end
