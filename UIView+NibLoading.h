//
//  UIView+NibLoading.h
//  
//
//  Created by Nicolas Bouilleaud on 08/03/11.
//

#import <UIKit/UIKit.h>


@interface UIView (NibLoading)

// Loads the views inside a nib and adds it as subviews of the receiver.
// There must be exactly one root UIView in the nib, acting as a container for the subviews of the receiver.
// The subviews are reparented to the receiver, the container view is discarded.
//
// Additionally, the container view's size is used as the default size for the receiver : 
// If the receiver's bounds is not CGRectZero, the container view is resized prior reparenting the subviews, so that the subviews are resized.
// If the receiver's bounds is CGRectZero, it's set to the container view's bounds.
//
- (void) loadContentsFromNibNamed:(NSString*)nibName;

// Convenience method, loads a nib named after the class name.
- (void) loadContentsFromNib;

@end

// Convenience UIView subclass, for relatively simple UIView subclasses that use a nib.
// It calls loadContentsFromNib in its initializer.
@interface NibLoadedView : UIView

@end
