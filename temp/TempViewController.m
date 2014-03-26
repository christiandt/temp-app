//
//  TempViewController.m
//  temp
//
//  Created by Christian DT on 01/03/2014.
//  Copyright (c) 2014 Christian DT. All rights reserved.
//

#import "TempViewController.h"
#import "DAReloadActivityButton.h"
#import <QuartzCore/QuartzCore.h>

@interface TempViewController ()

@end

@implementation TempViewController

@synthesize tempLabel = _templabel;
@synthesize timeLabel = _timeLabel;
@synthesize refreshButton = _refreshButton;
@synthesize alert = _alert;


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
    
    self.refreshButton = [[DAReloadActivityButton alloc] init];
    self.refreshButton.center = CGPointMake(20, 540);
    [self.refreshButton addTarget:self action:@selector(updateTemperatue:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.refreshButton];
    [self.refreshButton startAnimating];
    
    self.alert = [[UIAlertView alloc] initWithTitle:@"Network error" message:@"Could not connect to the server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [self requestTemperature];
}

-(void)updateTemperatue:(DAReloadActivityButton *)button{
    [button startAnimating];
    [self requestTemperature];
}


-(void)updateTemperatureDisplay:(NSInteger)update :(NSInteger)temp{
    [self.refreshButton stopAnimating];
    if (update<0) {
        [self.alert show];
    }
    else{
        self.tempLabel.text = [[@(temp) stringValue] stringByAppendingString:@"°"];
        self.timeLabel.text = [[@(update) stringValue] stringByAppendingString: @" minutes ago"];
    }
}

-(void)requestTemperature{
    requester = [[TemperatureRequester alloc] init];
	[requester setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
