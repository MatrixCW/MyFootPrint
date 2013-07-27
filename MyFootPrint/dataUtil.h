
#import <Foundation/Foundation.h>

@interface dataUtil : NSObject
@property (nonatomic,strong) NSString* uid;
@property (nonatomic,strong) NSString* token;
@property (nonatomic,strong) NSString* moduleCode;
@property (nonatomic,strong) NSArray* modules;
+ (dataUtil*) sharedInstance;
- (BOOL)isLoggedIn;
- (void) logout;
@end
