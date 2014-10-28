//
//  TwoViewsWithConfigurableSpace.m
//  NibLoadedViewDemo
//
//  Created by meknil on 21.10.14.
//

#import "TwoViewsWithConfigurableSpace.h"

@interface TwoViewsWithConfigurableSpace()

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *spaceBetweenViews;

@end


@implementation TwoViewsWithConfigurableSpace


- (void)setSpace:(NSInteger)space
{
    _space = space;
    self.spaceBetweenViews.constant = space;
}

@end
