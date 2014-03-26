//
//  TemperatureRequester.h
//  temp
//
//  Created by Christian DT on 01/03/2014.
//  Copyright (c) 2014 Christian DT. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SubClassDelegate
- (void)updateTemperatureDisplay:(NSInteger)update :(NSInteger)temp;
- (void)showAlertMessage:(NSString *)message;
@end

@interface TemperatureRequester : NSObject{
    NSMutableData *_responseData;
}

@property (nonatomic, assign) NSInteger update;
@property (nonatomic, assign) NSInteger temperature;
@property (nonatomic, assign) id<SubClassDelegate> delegate;



@end
