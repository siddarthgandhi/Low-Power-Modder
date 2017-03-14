#import <Foundation/Foundation.h>

@interface _CDBatterySaver : NSObject
+ (id)batterySaver;
- (int)getPowerMode;
- (int)setMode:(int)arg1;
@end

@interface SBUIController : NSObject
+(SBUIController *)sharedInstance;
-(BOOL)isOnAC;
-(int)batteryCapacityAsPercentage;
@end
