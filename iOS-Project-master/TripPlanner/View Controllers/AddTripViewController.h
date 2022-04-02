//
//  AddTripViewController.h
//  TripPlanner
//
//  Created by Marco on 30/05/21.
//

#import <UIKit/UIKit.h>
#import "TripDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddTripViewController : UIViewController

@property (strong, nonatomic, nullable) Trip* trip;
@property (strong, nonatomic) TripDataSource* dataSource;

@end

NS_ASSUME_NONNULL_END
