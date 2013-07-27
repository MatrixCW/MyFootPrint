
#import <Foundation/Foundation.h>
#import "TRStringExtensions.h"
@interface dataUtil : NSObject
@property (nonatomic,strong) NSString* uid;
@property (nonatomic,strong) NSString* token;
@property (nonatomic,strong) NSString* rrid;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* thumbnail;
@property (nonatomic,strong) NSString* moduleCode;
@property (nonatomic,strong) NSArray* modules;
+ (dataUtil*) sharedInstance;
- (BOOL)isLoggedIn;
- (void) logout;
@end
