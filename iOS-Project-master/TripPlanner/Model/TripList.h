//
//  TripList.h
//  TripPlanner
//
//  Created by Marco on 23/05/21.
//

#import <Foundation/Foundation.h>
#import "Trip.h"

NS_ASSUME_NONNULL_BEGIN

@interface TripList : NSObject

- (long) size;
- (NSArray*) getAll;
- (void) add:(Trip*) trip;
- (void) remove:(Trip*) trip;
- (Trip*) getAtIndex:(NSInteger) index;

@end

NS_ASSUME_NONNULL_END
