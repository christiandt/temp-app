//
//  TemperatureRequester.m
//  temp
//
//  Created by Christian DT on 01/03/2014.
//  Copyright (c) 2014 Christian DT. All rights reserved.
//

#import "TemperatureRequester.h"

@implementation TemperatureRequester

@synthesize update = _update;
@synthesize temperature = _temperature;
@synthesize delegate;


-(id)init{
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://snusken.motorvei.com/temp/api/now/"]];
    
    // Create url connection and fire request
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    return self;
}


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: _responseData options: NSJSONReadingMutableContainers error: &e];
    self.update = [jsonArray[0] integerValue];
    self.temperature = [jsonArray[1] integerValue];

    [[self delegate] updateTemperatureDisplay:self.update:self.temperature];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    [[self delegate] showAlertMessage:[error localizedDescription]];
}


@end
