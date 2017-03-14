#import "Modder.h"

%hook SBUIController

- (void)updateBatteryState:(id)arg1 {
  %orig;

  NSString *settingsPath = @"/var/mobile/Library/Preferences/es.iflam.lpmprefs.plist";
  NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
  BOOL enabled = [prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : YES;

  if (enabled == YES){
    _CDBatterySaver *saver = [_CDBatterySaver batterySaver];
    SBUIController *getBat = [%c(SBUIController) sharedInstance];
    int batteryLvl = [getBat batteryCapacityAsPercentage];

    int userValue = [[prefs objectForKey:@"percent"] integerValue];
    int disableValue = [[prefs objectForKey:@"disablePercent"] integerValue];
    BOOL disableCharge = [prefs objectForKey:@"disableCharge"] ? [[prefs objectForKey:@"disableCharge"] boolValue] : YES;

    if ([[%c(SBUIController) sharedInstance] isOnAC]) {
      if (disableCharge == YES) {
        if (batteryLvl >= disableValue) {
          [saver setMode:0];
        } else {
          [saver setMode:1];
        }
      }
    } else {
      if (batteryLvl <= userValue) {
        [saver setMode:1];
      }
    }
  }
}

%end
