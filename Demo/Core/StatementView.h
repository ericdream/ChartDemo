//
//  StatementView.h
//  RefreshDemo
//
//  Created by apple on 18/05/2017.
//  Copyright © 2017 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatementView : UIView
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,copy) NSString *dayTimes;
@property(nonatomic,copy) NSString *weakTimes;
@property(nonatomic,copy) NSString *monthTimes;

@end
@interface FooterView : UIView
@property(nonatomic,strong) UILabel *monthLb;
@property(nonatomic,strong) UILabel *dayLb;
@property(nonatomic,strong) UILabel *weakLb;
@end
@interface DataContentView : UIView
- (instancetype)initWithFrame:(CGRect)frame contentW:(CGFloat)width;
@property(nonatomic,copy) NSArray *array;
@end
