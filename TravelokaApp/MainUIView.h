//
//  MainUIView.h
//  TravelokaApp
//
//  Created by Axel Soedarsono on 9/18/17.
//  Copyright © 2017 Axel Soedarsono. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainUIView : UIView

@property (strong, nonatomic) UIView *headerUIView;
@property (strong, nonatomic) UIView *hotelUIView;
@property (strong, nonatomic) UIButton *hotelUIButton;
@property (strong, nonatomic) UIView *flightUIView;
@property (strong, nonatomic) UIButton *flightUIButton;
@property (strong, nonatomic) UIView *myBookingUIView;
@property (strong, nonatomic) UIButton *myBookingUIButton;
@property (strong, nonatomic) UIView *topBorderUIView;
@property (strong, nonatomic) UIView *bottomBorderUIView;

//selectedMenuIndicator
@property (strong, nonatomic) UIView *selectedMenuIndicatorUIView;

//origin
@property (strong, nonatomic) UIImageView *originIcon;
@property (strong, nonatomic) UILabel *originUILabel;
@property (strong, nonatomic) UIView *originUIView;
@property (strong, nonatomic) UILabel *originValueUILabel;

//destination
@property (strong, nonatomic) UIImageView *destinationIcon;
@property (strong, nonatomic) UILabel *destinationUILabel;
@property (strong, nonatomic) UIImageView *swapLocationUIImageView;
@property (strong, nonatomic) UIButton *swapLocationUIButton;
@property (strong, nonatomic) UIView *destinationUIView;
@property (strong, nonatomic) UILabel *destinationValueUILabel;
@property (strong, nonatomic) UIView *destinationBottomBorderUIView;

//departure
@property (strong, nonatomic) UIImageView *departureIcon;
@property (strong, nonatomic) UILabel *departureUILabel;
@property (strong, nonatomic) UIView *departureUIView;
@property (strong, nonatomic) UIDatePicker *departureDatePicker;
@property (strong, nonatomic) UIView *departureBottomBorderUIView;
@property (strong, nonatomic) UILabel *departureValueUILabel;

//Roundtrip
@property (strong, nonatomic) UIImageView *roundTripIcon;
@property (strong, nonatomic) UIView *roundTripUIView;
@property (strong, nonatomic) UILabel *roundTripUILabel;
@property (strong, nonatomic) UILabel *roundTripUIValueUILabel;
@property (strong, nonatomic) UISwitch *roundTripUISwitch;
@property (strong, nonatomic) UIView *roundTripBorderUIView;

//ReturnDate
@property (strong, nonatomic) UIImageView *returnDateIcon;
@property (strong, nonatomic) UIView *returnDateUIView;
@property (strong, nonatomic) UILabel *returnDateUILabel;
@property (strong, nonatomic) UILabel *returnDateValueUILabel;

//Passenger
@property (strong, nonatomic) UIView *passengerUIView;
@property (strong, nonatomic) UIImageView *passengerIcon;
@property (strong, nonatomic) UILabel *passengerUILabel;
@property (strong, nonatomic) UILabel *passengerValueUILabel;
@property (strong, nonatomic) UIView *passengerBottomBorderUIView;

//buttonSearch
@property (strong, nonatomic) UIView *searchUIView;
@property (strong, nonatomic) UIButton *searchUIButton;

//tempUIView
@property (strong, nonnull) UIView *blockUIView;

@end
