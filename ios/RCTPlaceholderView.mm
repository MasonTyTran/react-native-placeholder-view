//
//  PlaceholderView.m
//  reclubmobile
//
//  Created by Ty Tran on 6/18/25.
//  Copyright © 2025 Reclub. All rights reserved.
//
#ifdef RCT_NEW_ARCH_ENABLED
#import "ShimmerLayer.h"
#import <UIKit/UIKit.h>
#import <RCTPlaceholderView.h>
#import <react/renderer/components/placeholderViewSpecs/ComponentDescriptors.h>
#import <react/renderer/components/placeholderViewSpecs/Props.h>
#import <react/renderer/components/placeholderViewSpecs/RCTComponentViewHelpers.h>

using namespace facebook::react;

@interface RCTPlaceholderView () <RCTRNPlaceholderViewProtocol>
{
    CFTimeInterval _shimmeringDuration;
}
@end

@implementation RCTPlaceholderView {
    ShimmerLayer *_shimmerLayer;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
    return concreteComponentDescriptorProvider<RNPlaceholderComponentDescriptor>();
}

- (instancetype)init
{
    if (self = [super init]) {
        _shimmerLayer = [ShimmerLayer layer];
    }
    return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
    [super updateProps:props oldProps:oldProps];
    [self extractProps];
}

- (void)layoutSubviews
{
    [super layoutSubviews]; // Ensure the subview fills the placeholder view
   // Add shimmerLayer to the first subview if it exists, otherwise to self
    [_shimmerLayer removeFromSuperlayer];
    UIView *targetView = self.subviews.firstObject ?: self;
    [targetView.layer addSublayer:_shimmerLayer];

    // Match the shimmer layer to the target view's layer
    _shimmerLayer.frame = targetView.bounds;
    _shimmerLayer.bounds = targetView.bounds;
    _shimmerLayer.position = CGPointMake(CGRectGetMidX(targetView.bounds), CGRectGetMidY(targetView.bounds));
    _shimmerLayer.cornerRadius = targetView.layer.cornerRadius; // Synchronize corner radius
    targetView.layer.masksToBounds = YES; // Clip to bounds for proper shape
    
    [_shimmerLayer startShimmering];
   
}

- (void)removeFromSuperview
{
    [_shimmerLayer removeFromSuperlayer];
    [super removeFromSuperview];
}

- (UIColor *)colorWithHexString:(std::string)raw {
    NSString *hexString = [NSString stringWithUTF8String:raw.c_str()];
    NSString *cleanString = [[hexString stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // Remove prefix if present
    if ([cleanString hasPrefix:@"#"]) {
        cleanString = [cleanString substringFromIndex:1];
    } else if ([cleanString hasPrefix:@"0X"]) {
        cleanString = [cleanString substringFromIndex:2];
    }

    if (cleanString.length != 6 && cleanString.length != 8) {
        // Invalid format
        return nil;
    }

    unsigned int rgbValue = 0;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&rgbValue];

    CGFloat alpha = 1.0;
    if (cleanString.length == 8) {
        alpha = ((rgbValue & 0xFF000000) >> 24) / 255.0;
    }

    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0
                           green:((rgbValue & 0x00FF00) >> 8) / 255.0
                            blue:(rgbValue & 0x0000FF) / 255.0
                           alpha:alpha];
}

- (void)extractProps
{
    const auto &props = *std::static_pointer_cast<RNPlaceholderProps const>(_props); //_props equ
    //  date
    UIColor *shimmerColor = [self colorWithHexString:props.shimmerColor];
    _shimmerLayer.shimmerColor = shimmerColor;
    
    UIColor *highlightColor = [self colorWithHexString:props.highlightColor];
    _shimmerLayer.highlightColor = highlightColor;
    
    _shimmerLayer.animationDuration = props.animationDuration;
    
    ShimmerDirection direction = ConvertToShimmerDirection(props.shimmerDirection);
    [_shimmerLayer updateDirection:direction];
    
}

ShimmerDirection ConvertToShimmerDirection(RNPlaceholderShimmerDirection direction) {
    switch (direction) {
        case RNPlaceholderShimmerDirection::LeftToRight:
            return ShimmerDirectionLeftToRight;
        case RNPlaceholderShimmerDirection::RightToLeft:
            return ShimmerDirectionRightToLeft;
        case RNPlaceholderShimmerDirection::TopToBottom:
            return ShimmerDirectionTopToBottom;
        case RNPlaceholderShimmerDirection::BottomToTop:
            return ShimmerDirectionBottomToTop;
        default:
            return ShimmerDirectionLeftToRight; // fallback
    }
}

@end

#endif
