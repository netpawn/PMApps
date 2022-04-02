//
//  AddStageViewController.h
//  TripPlanner
//
//  Created by Marco on 09/06/21.
//

#import <UIKit/UIKit.h>
#import "Trip.h"
#import "TripDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddStageViewController : UIViewController

@property (strong, nonatomic, nullable) Stage* stage;
@property (strong, nonatomic, nullable) Trip* trip;
@property (strong, nonatomic) TripDataSource* dataSource;

@end

NS_ASSUME_NONNULL_END
