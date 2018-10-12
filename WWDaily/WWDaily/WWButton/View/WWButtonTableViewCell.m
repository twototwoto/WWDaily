//
//  WWButtonTableViewCell.m
//  WWDaily
//
//  Created by wangyongwang on 2018/7/31.
//  Copyright © 2018年 WYW. All rights reserved.
//

#import "WWButtonTableViewCell.h"

NSString* const WWButtonTableViewCellReuseIDString = @"WWButtonTableViewCellReuseIDString";
@interface WWButtonTableViewCell()
/** titleLabel */
@property (nonatomic,strong) UILabel *titleLabel;
/** button */
@property (nonatomic,strong) UIButton *button;

/** 按钮类型数组 */
@property (nonatomic,copy) NSArray *buttonTypeArray;

@end

@implementation WWButtonTableViewCell

- (WWButtonTableViewCell *)initWithReuseIdentifier:(NSString *)reuseId buttonType:(UIButtonType)buttonType{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId]) {
        [self setupSubviewsWithButtonType:buttonType];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviewsWithButtonType:self.buttonType];
    }
    return self;
}

- (void)setupSubviewsWithButtonType:(UIButtonType)buttonType{
    self.titleLabel = [UILabel new];
    self.titleLabel.backgroundColor = [UIColor grayColor];
//    _titleLabel.text = [NSString stringWithFormat:@"title %zd",buttonType];
    _titleLabel.text = self.buttonTypeArray[buttonType];
    self.titleLabel.
    translatesAutoresizingMaskIntoConstraints = NO;
    
    self.contentView.backgroundColor = [UIColor colorWithRed:((arc4random() % (256))/255.f) green:((arc4random() % (256))/255.f) blue:((arc4random() % (256))/255.f) alpha:1.f];
    [self.contentView addSubview:_titleLabel];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.f constant:0];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:0.5f constant:0];

    [self.contentView addConstraints:@[topConstraint,leftConstraint,rightConstraint,bottomConstraint]];
    
    self.button = [UIButton buttonWithType:buttonType];
    [self.button setTitle:self.buttonTypeArray[buttonType] forState:UIControlStateNormal];
    
    
    self.button.
    translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *buttonHeightConstraint = [NSLayoutConstraint constraintWithItem:_button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    NSLayoutConstraint *buttonLeftConstraint = [NSLayoutConstraint constraintWithItem:_button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.f constant:0];
    
    NSLayoutConstraint *buttonRightConstartint = [NSLayoutConstraint constraintWithItem:_button attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f];
    NSLayoutConstraint *buttonTopConstarint = [NSLayoutConstraint constraintWithItem:_button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    
    [self.contentView addSubview:_button];
    [self.contentView addConstraints:@[buttonLeftConstraint,buttonHeightConstraint,buttonRightConstartint,buttonTopConstarint]];
}

- (NSArray *)buttonTypeArray{
    if (!_buttonTypeArray) {
        _buttonTypeArray = @[@"UIButtonTypeCustom",
                             @"UIButtonTypeSystem NS_ENUM_AVAILABLE_IOS(7_0)",
                        @"UIButtonTypeDetailDisclosure",
                             @"UIButtonTypeInfoLight",
                             @"UIButtonTypeInfoDark",
                             @"UIButtonTypeContactAdd",
                             @"UIButtonTypePlain API_AVAILABLE(tvos(11.0)) API_UNAVAILABLE(ios, watchos)",
                             @"UIButtonTypeRoundedRect = UIButtonTypeSystem"];
        
        /*
         UIButtonTypeCustom = 0,                         // no button type
         UIButtonTypeSystem NS_ENUM_AVAILABLE_IOS(7_0),  // standard system button
         
         UIButtonTypeDetailDisclosure,
         UIButtonTypeInfoLight,
         UIButtonTypeInfoDark,
         UIButtonTypeContactAdd,
         
         UIButtonTypePlain API_AVAILABLE(tvos(11.0)) API_UNAVAILABLE(ios, watchos), // standard system button without the blurred background view
         
         UIButtonTypeRoundedRect = UIButtonTypeSystem   // Deprecated, use UIButtonTypeSystem instead
         */
    }
    return _buttonTypeArray;
}

@end
