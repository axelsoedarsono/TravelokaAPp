//
//  ViewController.m
//  TravelokaApp
//
//  Created by Axel Soedarsono on 9/18/17.
//  Copyright © 2017 Axel Soedarsono. All rights reserved.
//

#import "ViewController.h"
#import "MainUIView.h"

@interface ViewController ()

@property (strong, nonatomic) MainUIView *mainUIView;

@end

@implementation ViewController
#pragma mark - LifeCycle
- (void)loadView{
    [super loadView];
    _mainUIView = [[MainUIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
    
    [self.view addSubview:self.mainUIView];
    
    //navigationController Color
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.196 green:0.643 blue:0.871 alpha:1.00]];
    //navigationController title * title color
    self.title = @"Traxeloka";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    //alloc init promobutton
    _promoUIButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 20.0f)];
    [self.promoUIButton setTitle:@"Promo" forState:UIControlStateNormal];
    self.promoUIButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.promoUIButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.promoUIButton.titleLabel.textAlignment = NSTextAlignmentCenter;

    //alloc init UIBarButtonItem for promoUIBarButtonItem
    UIBarButtonItem *promoUIBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.promoUIButton];
    
    //alloc init moreOptionBUtton
    _moreOptionUIButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    [self.moreOptionUIButton setBackgroundImage:[UIImage imageNamed:@"icon-more"] forState:UIControlStateNormal];
    
    UIBarButtonItem *moreOptionBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.moreOptionUIButton];
    
    //set leftNavigationItemBarButton
    self.navigationItem.leftBarButtonItem = promoUIBarButtonItem;
    //set rightNavigationItemBarBUtton
    self.navigationItem.rightBarButtonItem = moreOptionBarButtonItem;
    
    //UIButton Hotel, Flight, MyBooking, Search, rounTripSwitch
    [self.mainUIView.hotelUIButton addTarget:self action:@selector(hotelButtonDidTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.mainUIView.flightUIButton addTarget:self action:@selector(flightButtonDidTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.mainUIView.myBookingUIButton addTarget:self action:@selector(myBookingButtonDidTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.mainUIView.searchUIButton addTarget:self action:@selector(searchButtonDidTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.mainUIView.roundTripUISwitch addTarget:self action:@selector(roundTripSwitchButtonDidTapped:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Method
- (void)hotelButtonDidTapped{
    
    [UIView animateWithDuration:0.2f animations:^{
        //selectedMenuIndicator
        self.mainUIView.selectedMenuIndicatorUIView.frame = CGRectMake(
                                                                       0.0f,
                                                                       0.0f,
                                                                       CGRectGetWidth([UIScreen mainScreen].bounds)/3.0f,
                                                                       1.0f);
        
        [self.mainUIView.hotelUIButton setTitleColor:[Util getColor:@"4688F1"] forState:UIControlStateNormal];
        [self.mainUIView.flightUIButton setTitleColor:[Util getColor:@"8FD0EF"] forState:UIControlStateNormal];
        [self.mainUIView.myBookingUIButton setTitleColor:[Util getColor:@"8FD0EF"] forState:UIControlStateNormal];
        
    }];
}

- (void)flightButtonDidTapped{
    NSLog(@"");
    [UIView animateWithDuration:0.2f animations:^{
        //selectedMenuIndicator
        self.mainUIView.selectedMenuIndicatorUIView.frame = CGRectMake(
                                                                       CGRectGetWidth([UIScreen mainScreen].bounds)/3.0f,
                                                                       0.0f,
                                                                       CGRectGetWidth([UIScreen mainScreen].bounds)/3.0f,
                                                                       1.0f);
        
        [self.mainUIView.hotelUIButton setTitleColor:[Util getColor:@"8FD0EF"] forState:UIControlStateNormal];
        [self.mainUIView.flightUIButton setTitleColor:[Util getColor:@"4688F1"] forState:UIControlStateNormal];
        [self.mainUIView.myBookingUIButton setTitleColor:[Util getColor:@"8FD0EF"] forState:UIControlStateNormal];
        
    }];
}

- (void)myBookingButtonDidTapped{
    
    [UIView animateWithDuration:0.2f animations:^{
        //selectedMenuIndicator
        self.mainUIView.selectedMenuIndicatorUIView.frame = CGRectMake(
                                                                       CGRectGetWidth([UIScreen mainScreen].bounds)/3.0f * 2.0f,
                                                                       0.0f,
                                                                       CGRectGetWidth([UIScreen mainScreen].bounds)/3.0f,
                                                                       1.0f);
        
        [self.mainUIView.hotelUIButton setTitleColor:[Util getColor:@"8FD0EF"] forState:UIControlStateNormal];
        [self.mainUIView.flightUIButton setTitleColor:[Util getColor:@"8FD0EF"] forState:UIControlStateNormal];
        [self.mainUIView.myBookingUIButton setTitleColor:[Util getColor:@"4688F1"] forState:UIControlStateNormal];
        
    }];
}

- (void)searchButtonDidTapped{
    NSLog(@"Search button pressed");
}

- (void)roundTripSwitchButtonDidTapped: (id)sender{
//    NSLog(@"Swap Location button pressed");
    [UIView animateWithDuration:0.3f animations:^{
        if([sender isOn])
        {
            NSLog(@"ON");
            self.mainUIView.returnDateIcon.frame = CGRectMake(
                                                              11.0f,
                                                              CGRectGetMaxY(self.mainUIView.roundTripUIView.frame) + 16.0f,
                                                              30.0f,
                                                              30.0f);
            
            self.mainUIView.returnDateUIView.frame = CGRectMake(
                                                                CGRectGetMaxX(self.mainUIView.roundTripIcon.frame) + 11.0f,
                                                                CGRectGetMaxY(self.mainUIView.roundTripUIView.frame) + 16.0f,
                                                                CGRectGetWidth([UIScreen mainScreen].bounds)
                                                                - (CGRectGetMaxX(self.mainUIView.departureIcon.frame) + 11.0f) - 15.0f,
                                                                53.0f);
            self.mainUIView.passengerIcon.frame = CGRectMake(
                                                             11.0f,
                                                             CGRectGetMaxY(self.mainUIView.returnDateUIView.frame) + 30.0f,
                                                             30.0f,
                                                             30.0f);
            self.mainUIView.passengerUIView.frame = CGRectMake(
                                                               CGRectGetMaxX(self.mainUIView.passengerIcon.frame) + 11.0f,
                                                               CGRectGetMaxY(self.mainUIView.returnDateUIView.frame) + 30.0f,
                                                               CGRectGetWidth([UIScreen mainScreen].bounds) - (CGRectGetMaxX(self.mainUIView.roundTripIcon.frame) + 11.0f) - 15.0f,
                                                               53.0f);
//            self.mainUIView.returnDateIcon.alpha = 1.0f;
//            self.mainUIView.returnDateUIView.alpha = 1.0f;
        }
        else{
            NSLog(@"OFF");
            self.mainUIView.returnDateIcon.frame = CGRectMake(
                                                              11.0f,
                                                              CGRectGetMaxY(self.mainUIView.departureUIView.frame) + 40.0f,
                                                              30.0f,
                                                              30.0f);
            
            self.mainUIView.returnDateUIView.frame = CGRectMake(
                                                                CGRectGetMaxX(self.mainUIView.roundTripIcon.frame) + 11.0f,
                                                                CGRectGetMaxY(self.mainUIView.departureUIView.frame) + 40.0f,
                                                                CGRectGetWidth([UIScreen mainScreen].bounds)
                                                                - (CGRectGetMaxX(self.mainUIView.departureIcon.frame) + 11.0f) - 15.0f,
                                                                53.0f);
            self.mainUIView.passengerIcon.frame = CGRectMake(
                                                             11.0f,
                                                             CGRectGetMaxY(self.mainUIView.roundTripUIView.frame) + 16.0f,
                                                             30.0f,
                                                             30.0f);
            self.mainUIView.passengerUIView.frame = CGRectMake(
                                                               CGRectGetMaxX(self.mainUIView.roundTripIcon.frame) + 11.0f,
                                                               CGRectGetMaxY(self.mainUIView.roundTripUIView.frame) + 16.0f,
                                                               CGRectGetWidth([UIScreen mainScreen].bounds) - (CGRectGetMaxX(self.mainUIView.departureIcon.frame) + 11.0f) - 15.0f,
                                                               53.0f);
//            self.mainUIView.returnDateIcon.alpha = 0.0f;
//            self.mainUIView.returnDateUIView.alpha = 0.0f;
        }
    }];
}


@end
