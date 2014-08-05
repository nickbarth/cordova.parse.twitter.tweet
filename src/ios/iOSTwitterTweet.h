#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>
#import <Cordova/CDV.h>

@interface iOSTwitterTweet: CDVPlugin{
  NSString* callbackId;
}

@property (nonatomic, retain) NSString* callbackId;
- (void)iOSTwitterTweet:(CDVInvokedUrlCommand *)command;
@end
