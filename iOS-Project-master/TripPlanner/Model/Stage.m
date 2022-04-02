//
//  Stage.m
//  TripPlanner
//
//  Created by Marco on 23/05/21.
//

#import "Stage.h"

@implementation Stage

- (instancetype) initWithMovement:(Movement *)movement
                             stay:(Stay *)stay {
    if(self = [super init]) {
        _movement = [movement copy];
        _stay = [stay copy];
    }
    return self;
}

@end
