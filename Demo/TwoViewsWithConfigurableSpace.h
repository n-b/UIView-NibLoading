//
//  TwoViewsWithConfigurableSpace.h
//  NibLoadedViewDemo
//
//  Created by meknil on 21.10.14.
//

#import "UIView+NibLoading.h"

//
// A view that presents two black squares (as an example for anything else).
// The space between thes squares is configurable at design- and runtime.
//

IB_DESIGNABLE
@interface TwoViewsWithConfigurableSpace : NibLoadedView

// use this property to set the space between the two squares in IB or at runtime
@property (assign, nonatomic) IBInspectable NSInteger space;

@end
