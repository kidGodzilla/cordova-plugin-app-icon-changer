/********* EmesaAppIconcChanger.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface EmesaAppIconcChanger : CDVPlugin {
  // Member variables go here.
}

- (void) isSupported:(CDVInvokedUrlCommand*)command;
- (void) changeIcon:(CDVInvokedUrlCommand*)command;
- (void) restIconToDefault:(CDVInvokedUrlCommand*)command;
- (void) getCurrentAlternateIconName:(CDVInvokedUrlCommand*)command;
@end

@implementation EmesaAppIconcChanger

- (void) isSupported:(CDVInvokedUrlCommand*)command
{
  CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:[self supportsAlternateIcons]];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) changeIcon:(CDVInvokedUrlCommand*)command
{
  if (![self supportsAlternateIcons]) {
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"This version of iOS doesn't support alternate icons"] callbackId:command.callbackId];
    return;
  }

  NSDictionary* options = command.arguments[0];
  NSString *iconName = options[@"iconName"];
  BOOL suppressUserNotification = (options[@"suppressUserNotification"] == nil || [options[@"suppressUserNotification"] boolValue]);

  if (iconName == nil) {
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"The 'iconName' parameter is mandatory"] callbackId:command.callbackId];
    return;
  }

  [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError *error) {
      if (error != nil) {
        NSString *errMsg = error.localizedDescription;
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:errMsg] callbackId:command.callbackId];
      } else {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
      }
  }];


  if (suppressUserNotification) {
    [self suppressUserNotification];
  }
}

- (void) restIconToDefault:(CDVInvokedUrlCommand*)command
{
  if (![self supportsAlternateIcons]) {
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"This version of iOS doesn't support alternate icons"] callbackId:command.callbackId];
    return;
  }

  [[UIApplication sharedApplication] setAlternateIconName:nil completionHandler:^(NSError *error) {
      if (error != nil) {
        NSString *errMsg = error.localizedDescription;
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:errMsg] callbackId:command.callbackId];
      } else {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
      }
  }];
}

- (void) getCurrentAlternateIconName:(CDVInvokedUrlCommand*)command
{
  if (![self supportsAlternateIcons]) {
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"This version of iOS doesn't support alternate icons"] callbackId:command.callbackId];
    return;
  }

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[[UIApplication sharedApplication] alternateIconName]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

#pragma mark - Helper functions

- (BOOL) supportsAlternateIcons
{
    return [[UIApplication sharedApplication] supportsAlternateIcons];
}

- (void) suppressUserNotification
{
  UIViewController* suppressAlertVC = [UIViewController new];
  [self.viewController presentViewController:suppressAlertVC animated:NO completion:^{
      [suppressAlertVC dismissViewControllerAnimated:NO completion: nil];
  }];
}


@end

