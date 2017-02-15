#import <Foundation/Foundation.h>

@interface _CDBatterySaver : NSObject
+ (id)batterySaver;
- (int)getPowerMode;
- (int)setMode:(int)arg1;
@end

@interface SBUIController : NSObject
+(SBUIController *)sharedInstance;
-(BOOL)isOnAC;
@end

%hook SBUIController

- (void)updateBatteryState:(id)arg1 {
  %orig;

  NSString *settingsPath = @"/var/mobile/Library/Preferences/es.iflam.lpmprefs.plist";
  NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
  BOOL enabled = [prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : YES;

  if (enabled == YES){
    _CDBatterySaver *saver = [_CDBatterySaver batterySaver];
    UIDevice *device = [UIDevice currentDevice];
    float batteryLvl = [device batteryLevel];

    float userValue = [[prefs objectForKey:@"percent"] floatValue];
    float disableValue = [[prefs objectForKey:@"disablePercent"] floatValue];
    BOOL disableCharge = [prefs objectForKey:@"disableCharge"] ? [[prefs objectForKey:@"disableCharge"] boolValue] : YES;

    if ([[%c(SBUIController) sharedInstance] isOnAC]) {
      if (disableCharge == YES) {
        if (batteryLvl >= disableValue/100.0f) {
          [saver setMode:0];
        } else {
          [saver setMode:1];
        }
      }
    } else {
      if (batteryLvl <= userValue/100.0f) {
        [saver setMode:1];
      }
    }
  }
}

%end
