//
//  MainUIView.m
//  TravelokaApp
//
//  Created by Axel Soedarsono on 9/18/17.
//  Copyright © 2017 Axel Soedarsono. All rights reserved.
//

#import "MainUIView.h"

@implementation MainUIView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        
        self.backgroundColor = [Util getColor:@"FFFFFF"];
        
        //topborder
        _topBorderUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                   0.0f,
                                                                   64.0f,
                                                                   CGRectGetWidth([UIScreen mainScreen].bounds),
                                                                    1.0f)];
        self.topBorderUIView.backgroundColor = [Util getColor:@"B2B2B2"];
        [self addSubview:self.topBorderUIView];
        
        //headerUIview
        _headerUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                0.0f,
                                                                CGRectGetMaxY(self.topBorderUIView.frame),
                                                                CGRectGetWidth([UIScreen mainScreen].bounds),
                                                                38.0f)];
        [self addSubview:self.headerUIView];
        
        //botBorder
        _bottomBorderUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                      0.0f,
                                                                      CGRectGetMaxY(self.headerUIView.frame),
                                                                      CGRectGetWidth([UIScreen mainScreen].bounds),
                                                                      1.0f)];
        self.bottomBorderUIView.backgroundColor = [Util getColor:@"B2B2B2"];
        [self addSubview:self.bottomBorderUIView];
        
        //tinggi untuk 3 view ini 16.0f fontsizenya 12.0f ||
        //untuk cari Y bounds - heigh /2
        //hotelUIView
        _hotelUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                0.0f,
                                                                CGRectGetMinY(self.headerUIView.frame),
                                                                CGRectGetWidth(self.headerUIView.frame)/3.0f,
                                                                CGRectGetHeight(self.headerUIView.frame))];
        
        [self addSubview:self.hotelUIView];
        
        //hotelUIBUtton
        _hotelUIButton = [[UIButton alloc] initWithFrame:CGRectMake(
                                                                 CGRectGetWidth(self.hotelUIView.frame)/4.0f,
                                                                 (CGRectGetHeight(self.hotelUIView.frame) - 30.0f) / 2.0f,
                                                                 CGRectGetWidth(self.hotelUIView.frame)/2.0f,
                                                                  30.0f)];

        [self.hotelUIButton setTitle:@"Hotel" forState:UIControlStateNormal];
        self.hotelUIButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.hotelUIButton setTitleColor:[Util getColor:@"4688F1"] forState:UIControlStateNormal];
        //[self.hotelUIButton setTitleColor:[Util getColor:@"8FD0EF"] forState:UIControlStateNormal];
        self.hotelUIButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.hotelUIView addSubview:self.hotelUIButton];

    
        //flightUIView
        _flightUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                CGRectGetMaxX(self.hotelUIView.frame),
                                                                CGRectGetMinY(self.headerUIView.frame),
                                                                CGRectGetWidth(self.headerUIView.frame)/3.0f,
                                                                CGRectGetHeight(self.headerUIView.frame))];
        
        [self addSubview:self.flightUIView];
        
        //flightUIButton
        _flightUIButton = [[UIButton alloc] initWithFrame:CGRectMake(
                                                                  CGRectGetWidth(self.flightUIView.frame)/4.0f,
                                                                  (CGRectGetHeight(self.flightUIView.frame) - 30.0f) / 2.0f,
                                                                  CGRectGetWidth(self.flightUIView.frame)/2.0f,
                                                                  30.0f)];

        [self.flightUIButton setTitle:@"Flight" forState:UIControlStateNormal];
        self.flightUIButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.flightUIButton setTitleColor:[Util getColor:@"8FD0EF"] forState:UIControlStateNormal];
        self.flightUIButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.flightUIView addSubview:self.flightUIButton];
        
        //myBookingUIlabel
        _myBookingUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                CGRectGetMaxX(self.flightUIView.frame),
                                                                CGRectGetMinY(self.headerUIView.frame),
                                                                CGRectGetWidth(self.headerUIView.frame)/3.0f,
                                                                CGRectGetHeight(self.headerUIView.frame))];
    
        [self addSubview:self.myBookingUIView];
        
        //myBookingUIButton
        _myBookingUIButton = [[UIButton alloc] initWithFrame:CGRectMake(
                                                                   CGRectGetWidth(self.myBookingUIView.frame)/4.0f,
                                                                   (CGRectGetHeight(self.flightUIView.frame) - 30.0f) / 2.0f,
                                                                   CGRectGetWidth(self.myBookingUIView.frame)/2.0f,
                                                                   30.0f)];

        [self.myBookingUIButton setTitle:@"My Booking" forState:UIControlStateNormal];
        self.myBookingUIButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.myBookingUIButton setTitleColor:[Util getColor:@"8FD0EF"] forState:UIControlStateNormal];
        self.myBookingUIButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        CGSize myBookingUIButtonSize = [self.myBookingUIButton sizeThatFits:CGSizeMake(CGFLOAT_MAX, 30.0f)];
        self.myBookingUIButton.frame = CGRectMake(
                                                 CGRectGetWidth(self.myBookingUIView.frame)/4.0f,
                                                 (CGRectGetHeight(self.flightUIView.frame) - 30.0f) / 2.0f,
                                                 myBookingUIButtonSize.width,
                                                 30.0f);
        
        [self.myBookingUIView addSubview:self.myBookingUIButton];
        
        //selectedMenuIndicator
        _selectedMenuIndicatorUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                               0.0f,
                                                                               0.0f,
                                                                               CGRectGetWidth([UIScreen mainScreen].bounds)/3.0f,
                                                                               1.0f)];
        self.selectedMenuIndicatorUIView.backgroundColor = [Util getColor:@"4688F1"];
        [self.bottomBorderUIView addSubview:self.selectedMenuIndicatorUIView];
       
        //==========================Origin
        //originIcon
        _originIcon = [[UIImageView alloc] initWithFrame:CGRectMake(
                                                                   11.0f,
                                                                   CGRectGetMaxY(self.bottomBorderUIView.frame) + 38.0f,
                                                                   30.0f,
                                                                    30.0f)];
        self.originIcon.image = [UIImage imageNamed:@"landing-from"];
        [self addSubview:self.originIcon];
        
        //originUIView
        _originUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                CGRectGetMaxX(self.originIcon.frame) + 11.0f,
                                                                CGRectGetMaxY(self.bottomBorderUIView.frame) + 38.0f,
                                                                CGRectGetWidth([UIScreen mainScreen].bounds) - (CGRectGetMaxX(self.originIcon.frame) + 11.0f) - 15.0f,
                                                                 53.0f)];
        [self addSubview:self.originUIView];
        
        //origilUIlabel
        _originUILabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                  0.0f,
                                                                  0.0f,
                                                                  100.0f,
                                                                   15.f)];
        self.originUILabel.text = @"Origin";
        [self.originUILabel setFont:[UIFont systemFontOfSize:10.0f]];
        self.originUILabel.textAlignment = NSTextAlignmentLeft;
        self.originUILabel.textColor = [Util getColor:@"8D8D8D"];
        [self.originUIView addSubview:self.originUILabel];
        
        //origionValueUIlabel
        _originValueUILabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                        0.0f,
                                                                        CGRectGetMaxY(self.originUILabel.frame),
                                                                        CGRectGetWidth(self.originUIView.frame),
                                                                        30.0f)];
        self.originValueUILabel.text =  @"Jakarta (JKT)";
        [self.originValueUILabel setFont:[UIFont systemFontOfSize:18.0f]];
        self.originValueUILabel.textColor = [UIColor blackColor];
        self.originValueUILabel.textAlignment = NSTextAlignmentLeft;
        [self.originUIView addSubview:self.originValueUILabel];
        //==========================
        
        //==========================Destination
        //destinationIcon
        _destinationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(
                                                                    11.0f,
                                                                    CGRectGetMaxY(self.originUIView.frame) + 10.0f,
                                                                    30.0f,
                                                                    30.0f)];
        self.destinationIcon.image = [UIImage imageNamed:@"landing-to"];
        [self addSubview:self.destinationIcon];
        
        //destinationUIView
        _destinationUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                 CGRectGetMaxX(self.destinationIcon.frame) + 11.0f,
                                                                 CGRectGetMaxY(self.originUIView.frame) + 10.0f,
                                                                 CGRectGetWidth([UIScreen mainScreen].bounds) - (CGRectGetMaxX(self.destinationIcon.frame) + 11.0f) - 15.0f,
                                                                 53.0f)];
        [self addSubview:self.destinationUIView];
        
        //destinatioUILabel
        _destinationUILabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                   0.0f,
                                                                   0.0f,
                                                                   100.0f,
                                                                   15.f)];
        self.destinationUILabel.text = @"Destination";
        [self.destinationUILabel setFont:[UIFont systemFontOfSize:10.0f]];
        self.destinationUILabel.textAlignment = NSTextAlignmentLeft;
        self.destinationUILabel.textColor = [Util getColor:@"8D8D8D"];
        [self.destinationUIView addSubview:self.destinationUILabel];
        
        //iconSwapLocation
        _swapLocationUIImageView = [[UIImageView alloc] initWithFrame:CGRectMake(
                                                                            CGRectGetWidth(self.destinationUIView.frame) - 30.0f,
                                                                            0.0f,
                                                                            30.0f,
                                                                            30.0f)];
        self.swapLocationUIImageView.image = [UIImage imageNamed:@"landing-return"];
        [self.destinationUIView addSubview:self.swapLocationUIImageView];
        
        _swapLocationUIButton = [[UIButton alloc] initWithFrame:CGRectMake(
                                                                          CGRectGetWidth(self.destinationUIView.frame) - 30.0f,
                                                                          0.0f,
                                                                          30.0f,
                                                                           30.0f)];
//        self.swapLocationUIButton.backgroundColor = [UIColor blackColor];
//        [self.swapLocationUIButton setBackgroundImage:[UIImage imageNamed:@"landing-return"] forState:UIControlStateNormal];
        [self.destinationUIView addSubview:self.swapLocationUIButton];
        
        //destinationValueUILabel
        _destinationValueUILabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                         0.0f,
                                                                         CGRectGetMaxY(self.destinationUILabel.frame),
                                                                         CGRectGetWidth(self.destinationUIView.frame),
                                                                         30.0f)];
        self.destinationValueUILabel.text =  @"Palembang (PLG)";
        [self.destinationValueUILabel setFont:[UIFont systemFontOfSize:18.0f]];
        self.destinationValueUILabel.textAlignment = NSTextAlignmentLeft;
        [self.destinationUIView addSubview:self.destinationValueUILabel];
        
        //destinationBottomBorderUIView
        _destinationBottomBorderUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                                0.0f,
                                                                                 CGRectGetHeight(self.destinationUIView.frame),
                                                                                 CGRectGetWidth(self.destinationUIView.frame),
                                                                                  1.0f)];
        self.destinationBottomBorderUIView.backgroundColor = [Util getColor:@"AAAAAA"];
        [self.destinationUIView addSubview:self.destinationBottomBorderUIView];
        //==========================
        
        
        //==========================Departure
        _departureIcon = [[UIImageView alloc] initWithFrame:CGRectMake(
                                                                    11.0f,
                                                                    CGRectGetMaxY(self.destinationUIView.frame) + 16.0f,
                                                                    30.0f,
                                                                    30.0f)];
        self.departureIcon.image = [UIImage imageNamed:@"icon-calendar"];
        [self addSubview:self.departureIcon];
        
        //departureUIView
         _departureUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                 CGRectGetMaxX(self.departureIcon.frame) + 11.0f,
                                                                 CGRectGetMaxY(self.destinationUIView.frame) + 16.0f,
                                                                 CGRectGetWidth([UIScreen mainScreen].bounds) - (CGRectGetMaxX(self.departureIcon.frame) + 11.0f) - 15.0f,
                                                                 53.0f)];
        [self addSubview:self.departureUIView];
        
        //departureUIlabel
        _departureUILabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                   0.0f,
                                                                   0.0f,
                                                                   100.0f,
                                                                   15.f)];
        self.departureUILabel.text = @"Departure Date";
        [self.departureUILabel setFont:[UIFont systemFontOfSize:10.0f]];
        self.departureUILabel.textAlignment = NSTextAlignmentLeft;
        self.departureUILabel.textColor = [Util getColor:@"8D8D8D"];
        [self.departureUIView addSubview:self.departureUILabel];
        
        //departureValueUILabel
        _departureValueUILabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                         0.0f,
                                                                         CGRectGetMaxY(self.departureUILabel.frame),
                                                                         CGRectGetWidth(self.departureUIView.frame),
                                                                         30.0f)];
        self.departureValueUILabel.text =  @"Wednesday, 19 Sep 2017";
        [self.departureValueUILabel setFont:[UIFont systemFontOfSize:18.0f]];
        self.departureValueUILabel.textColor = [UIColor blackColor];
        self.departureValueUILabel.textAlignment = NSTextAlignmentLeft;
        [self.departureUIView addSubview:self.departureValueUILabel];
        //==========================
        
        //==========================Roundtrip
        //RounTripIcon
        _roundTripIcon = [[UIImageView alloc] initWithFrame:CGRectMake(
                                                                         11.0f,
                                                                         CGRectGetMaxY(self.departureUIView.frame) + 40.0f,
                                                                         30.0f,
                                                                         30.0f)];
//        self.roundTripIcon.backgroundColor = [UIColor grayColor];
        self.roundTripIcon.image = [UIImage imageNamed:@"icon-return"];
//        [self addSubview:self.roundTripIcon];
        
        //destinationUIView
        _roundTripUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                      CGRectGetMaxX(self.roundTripIcon.frame) + 11.0f,
                                                                      CGRectGetMaxY(self.departureUIView.frame) + 40.0f,
                                                                      CGRectGetWidth([UIScreen mainScreen].bounds) - (CGRectGetMaxX(self.roundTripIcon.frame) + 11.0f) - 15.0f,
                                                                      53.0f)];
//        self.roundTripUIView.backgroundColor = [UIColor darkGrayColor];
//        [self addSubview:self.roundTripUIView];
        
        //destinatioUILabel
        _roundTripUILabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                        0.0f,
                                                                        0.0f,
                                                                        100.0f,
                                                                        15.f)];
        self.roundTripUILabel.text = @"Round-Trip?";
        [self.roundTripUILabel setFont:[UIFont systemFontOfSize:10.0f]];
        self.roundTripUILabel.textAlignment = NSTextAlignmentLeft;
        self.roundTripUILabel.textColor = [Util getColor:@"8D8D8D"];
        [self.roundTripUIView addSubview:self.roundTripUILabel];
        
        //iconSwitchLocation
        _roundTripUISwitch = [[UISwitch alloc] initWithFrame:CGRectMake(
                                                                        CGRectGetWidth(self.roundTripUIView.frame) - 30.0f - 22.0f,
                                                                        0.0f,
                                                                        30.0f,
                                                                        30.0f)];
        [self.roundTripUISwitch setOnTintColor:[Util getColor:@"29A2E0"]];
        [self.roundTripUIView addSubview:self.roundTripUISwitch];
        
        //roundTripValueUILabel
        _roundTripUIValueUILabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                                0.0f,
                                                                                CGRectGetMaxY(self.roundTripUILabel.frame),
                                                                                CGRectGetWidth(self.roundTripUIView.frame),
                                                                                30.0f)];
        self.roundTripUIValueUILabel.text =@"";
        [self.roundTripUIValueUILabel setFont:[UIFont systemFontOfSize:18.0f]];
        self.roundTripUIValueUILabel.textAlignment = NSTextAlignmentLeft;
        [self.roundTripUIView addSubview:self.roundTripUIValueUILabel];
        
        //roundTripBottomBorderUIView
        _roundTripBorderUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                          0.0f,
                                                                          CGRectGetHeight(self.roundTripUIView.frame),
                                                                          CGRectGetWidth(self.roundTripUIView.frame),
                                                                          1.0f)];
        self.roundTripBorderUIView.backgroundColor = [Util getColor:@"AAAAAA"];
        [self.roundTripUIView addSubview:self.roundTripBorderUIView];
        //==========================Roundtrip
        
        //================== Return Date
        _returnDateIcon = [[UIImageView alloc] initWithFrame:CGRectMake(
                                                                       11.0f,
                                                                       CGRectGetMaxY(self.roundTripUIView.frame) + 16.0f,
                                                                       30.0f,
                                                                       30.0f)];
//        self.returnDateIcon.backgroundColor = [UIColor lightGrayColor];
        self.returnDateIcon.image = [UIImage imageNamed:@"icon-calendar"];
        //test
        [self addSubview:self.returnDateIcon];
        [self addSubview:self.roundTripIcon];
        

        
        //returnDateUIView
        _returnDateUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                    CGRectGetMaxX(self.roundTripIcon.frame) + 11.0f,
                                                                    CGRectGetMaxY(self.roundTripUIView.frame) + 16.0f,
                                                                    CGRectGetWidth([UIScreen mainScreen].bounds) - (CGRectGetMaxX(self.departureIcon.frame) + 11.0f) - 15.0f,
                                                                    53.0f)];
//        self.returnDateUIView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.returnDateUIView];
        [self addSubview:self.roundTripUIView];
        
        //returnDateUIlabel
        _returnDateUILabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                      0.0f,
                                                                      0.0f,
                                                                      100.0f,
                                                                      15.f)];
        self.returnDateUILabel.text = @"Return Date";
        [self.returnDateUILabel setFont:[UIFont systemFontOfSize:10.0f]];
        self.returnDateUILabel.textAlignment = NSTextAlignmentLeft;
        self.returnDateUILabel.textColor = [Util getColor:@"8D8D8D"];
        [self.returnDateUIView addSubview:self.returnDateUILabel];
        
        //returnDateValueUILabel
        _returnDateValueUILabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                           0.0f,
                                                                           CGRectGetMaxY(self.returnDateUILabel.frame),
                                                                           CGRectGetWidth(self.returnDateUIView.frame),
                                                                           30.0f)];
        self.returnDateValueUILabel.text =  @"";
        [self.returnDateValueUILabel setFont:[UIFont systemFontOfSize:18.0f]];
        self.returnDateValueUILabel.textColor = [UIColor blackColor];
        self.returnDateValueUILabel.textAlignment = NSTextAlignmentLeft;
        [self.returnDateUIView addSubview:self.returnDateValueUILabel];
        //==================ReturnDate
        
        //==================Passenger
        _passengerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(
                                                                       11.0f,
                                                                       CGRectGetMaxY(self.returnDateUIView.frame) + 30.0f,
                                                                       30.0f,
                                                                       30.0f)];
        self.passengerIcon.image = [UIImage imageNamed:@"landing-passanger"];
        [self addSubview:self.passengerIcon];
        
        //roundTripUIView
        _passengerUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                    CGRectGetMaxX(self.passengerIcon.frame) + 11.0f,
                                                                    CGRectGetMaxY(self.returnDateUIView.frame) + 30.0f,
                                                                    CGRectGetWidth([UIScreen mainScreen].bounds) - (CGRectGetMaxX(self.roundTripIcon.frame) + 11.0f) - 15.0f,
                                                                    53.0f)];
        [self addSubview:self.passengerUIView];
        
        //passengerUILabel
        _passengerUILabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                      0.0f,
                                                                      0.0f,
                                                                      100.0f,
                                                                      15.f)];
        self.passengerUILabel.text = @"Passenger";
        [self.passengerUILabel setFont:[UIFont systemFontOfSize:10.0f]];
        self.passengerUILabel.textAlignment = NSTextAlignmentLeft;
        self.passengerUILabel.textColor = [Util getColor:@"8D8D8D"];
        [self.passengerUIView addSubview:self.passengerUILabel];
    
        //PassengerValueUILabel
        _passengerValueUILabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                             0.0f,
                                                                             CGRectGetMaxY(self.passengerUILabel.frame),
                                                                             CGRectGetWidth(self.passengerUIView.frame),
                                                                             30.0f)];
        self.passengerValueUILabel.text =@"1 Adult";
        [self.passengerValueUILabel setFont:[UIFont systemFontOfSize:18.0f]];
        self.passengerValueUILabel.textAlignment = NSTextAlignmentLeft;
        [self.passengerUIView addSubview:self.passengerValueUILabel];
        
        //passengerBottomBorderUIView
        _passengerBottomBorderUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                          0.0f,
                                                                          CGRectGetHeight(self.passengerUIView.frame),
                                                                          CGRectGetWidth(self.passengerUIView.frame),
                                                                          1.0f)];
        self.passengerBottomBorderUIView.backgroundColor = [Util getColor:@"AAAAAA"];
        [self.passengerUIView addSubview:self.passengerBottomBorderUIView];
        //==================Passenger
        
        //==================Search
         _searchUIView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                 21.0,
                                                                 CGRectGetHeight([UIScreen mainScreen].bounds) - 36.0f - 10.0f,
                                                                 CGRectGetWidth([UIScreen mainScreen].bounds) - 42.0f,
                                                                 36.0f)];
//        self.searchUIView.layer.cornerRadius = []
        self.searchUIView.backgroundColor = [Util getColor:@"F06B31"];
        self.searchUIView.layer.cornerRadius =  4.0f;
//        [self addSubview:self.searchUIView];
        
        _searchUIButton = [[UIButton alloc] initWithFrame:CGRectMake(
                                                                   21.0,
                                                                   CGRectGetHeight([UIScreen mainScreen].bounds) - 36.0f - 10.0f,
                                                                   CGRectGetWidth([UIScreen mainScreen].bounds) - 42.0f,
                                                                   36.0f)];
        
        [self.searchUIButton setTitle:@"SEARCH" forState:UIControlStateNormal];
        self.searchUIButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.searchUIButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.searchUIButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.searchUIButton.backgroundColor = [Util getColor:@"F06B31"];
        self.searchUIButton.layer.cornerRadius = 4.0f;
//        [self.searchUIView addSubview:self.searchUIButton];
        [self addSubview:self.searchUIButton];
        
        //==================Search
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    return self;
}

@end
