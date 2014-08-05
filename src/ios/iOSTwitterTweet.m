#import "iOSTwitterTweet.h"

@implementation iOSTwitterTweet

@synthesize callbackId;

- (void)iOSTwitterTweet:(CDVInvokedUrlCommand *)command {
    self.callbackId = command.callbackId;

    PFUser *currentUser = [PFUser currentUser];
    if (![PFTwitterUtils isLinkedWithUser:currentUser]) {
        [PFTwitterUtils linkUser:currentUser block:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSString *result = @"{ \"error\": \"Invalid Permissions\" }";
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
                [self writeJavascript:javaScript];
            }
        }];
    }

    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/update.json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";

    NSString *status = [NSString stringWithFormat:@"status=%@", [[command.arguments objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    status = [status stringByReplacingOccurrencesOfString:@"!" withString:@"%21"];
    request.HTTPBody = [status dataUsingEncoding:NSUTF8StringEncoding];

    [[PFTwitterUtils twitter] signRequest:request];

    NSError *error;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];

    if (response == nil) {
        if (error) {
            NSLog(@"Error: %@", error);
            NSString *result = @"{ \"error\": \"Invalid Request\" }";
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
            NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
            [self writeJavascript:javaScript];
        } else {
            NSLog(@"Request Failed");
            NSString *result = @"{ \"error\": \"Request Failed\" }";
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
            NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
            [self writeJavascript:javaScript];
        }
        return;
    }

    NSError *errorJson = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&errorJson];
    NSString *tweet = json[@"id"];
    NSString *result = [NSString stringWithFormat: @"{ \"error\": false, \"tweet\": \"%@\" }", tweet];

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
    NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
    [self writeJavascript:javaScript];
}

@end
