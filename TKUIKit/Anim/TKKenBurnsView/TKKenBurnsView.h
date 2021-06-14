//
//  KenBurnsView.h
//  KenBurns
//
//  Created by Javier Berlana on 9/23/11.
//  Copyright (c) 2011, Javier Berlana
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this 
//  software and associated documentation files (the "Software"), to deal in the Software 
//  without restriction, including without limitation the rights to use, copy, modify, merge, 
//  publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons 
//  to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies 
//  or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
//  PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
//  FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
//  IN THE SOFTWARE.
//

/**
PS: https://github.com/ChenYilong/CYLSearchViewController

 */


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@class TKKenBurnsView;

#pragma - KenBurnsViewDelegate
@protocol TKKenBurnsViewDelegate <NSObject>
@optional
- (void)didShowImageAtIndex:(NSUInteger)index;
- (void)didFinishAllAnimations;

@end

@interface TKKenBurnsView : UIView {
    NSMutableArray *imagesArray;
    float timeTransition;
    BOOL isLoop;
    BOOL isLandscape;
    __weak id <TKKenBurnsViewDelegate> delegate;
}

@property (nonatomic, assign) float timeTransition;
@property (nonatomic, retain) NSMutableArray *imagesArray;
@property (nonatomic) BOOL isLoop;
@property (nonatomic) BOOL isLandscape;
@property (weak) id<TKKenBurnsViewDelegate> delegate;

- (void) animateWithImages:(NSArray *)images transitionDuration:(float)time loop:(BOOL)isLoop isLandscape:(BOOL)isLandscape;
- (void) animateWithURLs:(NSArray *)urls transitionDuration:(float)duration loop:(BOOL)shouldLoop isLandscape:(BOOL)inLandscape;

@end


