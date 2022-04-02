//
//  StageList.h
//  TripPlanner
//
//  Created by Marco on 23/05/21.
//

#import <Foundation/Foundation.h>
#import "Stage.h"

NS_ASSUME_NONNULL_BEGIN

@interface StageList : NSObject

- (long) size;
- (NSArray*) getAll;
- (void) add:(Stage*) stage;
- (void) remove:(Stage*) stage;
- (Stage*) getAtIndex:(NSInteger) index;
- (NSArray*) getPlacesInOrder;

@end

NS_ASSUME_NONNULL_END
