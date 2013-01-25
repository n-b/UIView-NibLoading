//
//  UIView+NibLoading.h
//
//  Created by Nicolas Bouilleaud.
//
// 	https://github.com/n-b/UIView-NibLoading

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

// Convenience UIView subclass.
//
// Custom UIViews can simply subclass NibLoadedView.
// It calls loadContentsFromNib in its initializer.
//
// If you need to subclass another UIView subclass (e.g. a custom UIControl),
// you'll need to call loadContentsFromNib yourself.
//
@interface NibLoadedView : UIView

@end
