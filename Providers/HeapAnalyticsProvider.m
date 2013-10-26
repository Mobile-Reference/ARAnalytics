//
//  HeapAnalyticsProvider.m
//  Pods
//
//  Created by Daniel Haight on 20/10/2013.
//
//

#import "HeapAnalyticsProvider.h"
#import "Heap.h"

@implementation HeapAnalyticsProvider

#ifdef AR_HEAPANALYTICS_EXISTS
-(id)initWithIdentifier:(id)identifier {
    NSAssert([Heap class], @"Heap is not included");
    [[Heap sharedInstance] setAppId:identifier];
    
    return [super init];
}

- (void)identifyUserWithID:(NSString *)userID andEmailAddress:(NSString *)email {
    NSDictionary *userDict=@{
                             @"email" : email,
                             @"handle" : userID
                             };
    
    [[Heap sharedInstance] identify:userDict];
    
}

- (void)setUserProperty:(NSString *)property toValue:(NSString *)value{
    NSDictionary *userDict=@{
                             property : value
                             };
    
    [[Heap sharedInstance] identify:userDict];
    
}

-(void)event:(id)event withProperties:(id)properties {
    NSMutableDictionary *props = [NSMutableDictionary new];
    if (properties) {
        //values must be strings
        //https://heapanalytics.com/docs#track
        //quick and dirty hack to ensure this
        [properties enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            props[key]=((NSObject *)obj).description;
        }];
    }
    [[Heap sharedInstance] track:event withProperties:props];
    
}

#endif
@end
