//
//  TempViewController.m
//  temp
//
//  Created by Christian DT on 01/03/2014.
//  Copyright (c) 2014 Christian DT. All rights reserved.
//

#import "TempViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TempViewController ()

@end

@implementation TempViewController

@synthesize tempLabel = _templabel;
@synthesize timeLabel = _timeLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // self.view.backgroundColor;
    UIColor *top = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1];
    UIColor *bottom = [UIColor colorWithRed:0.20 green:0.66 blue:0.86 alpha:1];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = [NSArray arrayWithObjects:(id)top.CGColor, (id)bottom.CGColor, nil];
    gradient.frame = self.view.bounds;
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    requester = [[TemperatureRequester alloc] init];
	[requester setDelegate:self];
    
	// Do any additional setup after loading the view.
}


-(void)updateTemperatureDisplay:(NSInteger)update :(NSInteger)temp{
    self.tempLabel.text = [@(temp) stringValue];
    self.timeLabel.text = [[@(update) stringValue] stringByAppendingString: @" minutes ago"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
