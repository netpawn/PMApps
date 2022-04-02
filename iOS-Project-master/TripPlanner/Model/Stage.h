//
//  Stage.h
//  TripPlanner
//
//  Created by Marco on 23/05/21.
//

#import <Foundation/Foundation.h>
#import "Movement.h"
#import "Stay.h"

NS_ASSUME_NONNULL_BEGIN

@interface Stage : NSObject

- (instancetype) initWithMovement:(Movement*) movement
                             stay:(Stay*) stay;

@property (nonatomic, strong) Movement* movement;
@property (nonatomic, strong) Stay* stay;

@end

NS_ASSUME_NONNULL_END
