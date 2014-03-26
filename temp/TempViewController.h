//
//  TempViewController.h
//  temp
//
//  Created by Christian DT on 01/03/2014.
//  Copyright (c) 2014 Christian DT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemperatureRequester.h"
#import "DAReloadActivityButton.h"

@interface TempViewController : UIViewController<SubClassDelegate>{
    UILabel *tempLabel;
    UILabel *timeLabel;
    TemperatureRequester *requester;
}

@property (nonatomic, retain) IBOutlet UILabel *tempLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) DAReloadActivityButton *refreshButton;
@property (nonatomic, retain) UIAlertView *alert;

@end
