//
//  Place.h
//  TripPlanner
//
//  Created by Marco on 13/06/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Place : NSObject

- (instancetype) initWithName: (NSString*) name;
- (void) setupCoordinates;

@property (strong, nonatomic) NSString* name;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (strong, nonatomic) NSNumber* sequenceValue;

@end

NS_ASSUME_NONNULL_END
