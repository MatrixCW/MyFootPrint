#import "dataUtil.h"
#import "CacheManager.h"

#define TOKEN_CACHE_KEY @"token"
#define UID_CACHE_KEY @"uid"
#define NAME_CACHE_KEY @"name"
#define RRID_CACHE_KEY @"rrid"
#define THUMB_CACHE_KEY @"thumbnail"

static dataUtil* sharedInstance = nil;
@implementation dataUtil
+ (dataUtil*) sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[dataUtil alloc] init];
    }
    return sharedInstance;
}

- (BOOL) isLoggedIn {
    return self.token && self.rrid && self.uid;
}


- (void) logout {
    [[CacheManager sharedManager] clearCacheForKey:TOKEN_CACHE_KEY];
    [[CacheManager sharedManager] clearCacheForKey:NAME_CACHE_KEY];
    [[CacheManager sharedManager] clearCacheForKey:RRID_CACHE_KEY];
    [[CacheManager sharedManager] clearCacheForKey:THUMB_CACHE_KEY];
    [[CacheManager sharedManager] clearCacheForKey:UID_CACHE_KEY];
}

- (NSString*)token {
    return (NSString*)[[CacheManager sharedManager] objectForKey:TOKEN_CACHE_KEY];
}

- (NSString*)uid {
    return (NSString*)[[CacheManager sharedManager] objectForKey:UID_CACHE_KEY];
}

- (NSString*)rrid {
    return (NSString*)[[CacheManager sharedManager] objectForKey:RRID_CACHE_KEY];
}

- (NSString*)thumbnail {
    return (NSString*)[[CacheManager sharedManager] objectForKey:THUMB_CACHE_KEY];
}

- (NSString*)name {
    return (NSString*)[[CacheManager sharedManager] objectForKey:NAME_CACHE_KEY];
}


- (void)setToken:(NSString *)token {
    [[CacheManager sharedManager] cacheObjectForKey:TOKEN_CACHE_KEY object:token];
}

- (void)setUid:(NSString *)uid {
    [[CacheManager sharedManager] cacheObjectForKey:UID_CACHE_KEY object:uid];
}

- (void)setThumbnail:(NSString *)thumb {
    [[CacheManager sharedManager] cacheObjectForKey:THUMB_CACHE_KEY object:thumb];
}

- (void)setRrid:(NSString *)rrid {
    [[CacheManager sharedManager] cacheObjectForKey:RRID_CACHE_KEY object:rrid];
}

- (void)setName:(NSString *)name {
    name = [name urlEncode];
    [[CacheManager sharedManager] cacheObjectForKey:NAME_CACHE_KEY object:name];
}
@end
