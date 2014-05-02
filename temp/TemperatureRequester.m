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
    NSString *twine_id = @"0000242ee1dea1de";
    NSString *access_key = @"934781e7fbdc2b1f578444d858ac";
    NSString *url = [NSString stringWithFormat:@"https://twine.cc/%@/rt?cached=1&access_key=%@", twine_id, access_key];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
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
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: _responseData options: NSJSONReadingMutableContainers error: &e];
    NSArray *values = jsonDict[@"values"];
    
    double fahrenheit = [values[1][1] doubleValue]/100;
    double celsius = (fahrenheit-32)*5/9;
    
    self.update = [jsonDict[@"age"] integerValue]/60;
    self.temperature = celsius;

    [[self delegate] updateTemperatureDisplay:self.update:self.temperature];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    [[self delegate] showAlertMessage:[error localizedDescription]];
}


@end
