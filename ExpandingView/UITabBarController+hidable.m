/*
 Copyright (c) 2012, Tony Million.
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 */


#import "UITabBarController+hidable.h"

#define TABBAR_HEIGHT (49)

@implementation UITabBarController (hidable)

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    NSLog(@"setTabBarHidden:%d animated:%d", hidden, animated);
    
	if ( [self.view.subviews count] < 2 )
		return;
	
	UIView *contentView;
    
	if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
		contentView = [self.view.subviews objectAtIndex:1];
	else
		contentView = [self.view.subviews objectAtIndex:0];
	
    
    if(hidden)
    {
        if(animated)
        {
            NSLog(@"HIDDEN - ANIMATED");
            
            [UIView animateWithDuration:0.2
                             animations:^{
                                 contentView.frame = self.view.bounds;
                                 
                                 self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                                                self.view.bounds.size.height,
                                                                self.view.bounds.size.width,
                                                                TABBAR_HEIGHT);
                             }
                             completion:^(BOOL finished) {
                                 contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                                                self.view.bounds.size.height,
                                                                self.view.bounds.size.width,
                                                                TABBAR_HEIGHT);
                             }];
        }
        else
        {
            NSLog(@"HIDDEN");
            
            contentView.frame = self.view.bounds;
            
            self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.size.height,
                                           self.view.bounds.size.width,
                                           TABBAR_HEIGHT);
        }
    }
    else
    {
        self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                       self.view.bounds.size.height,
                                       self.view.bounds.size.width,
                                       0);
        if(animated)
        {
            NSLog(@"NOT HIDDEN - ANIMATED");
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                                                self.view.bounds.size.height - TABBAR_HEIGHT,
                                                                self.view.bounds.size.width,
                                                                TABBAR_HEIGHT);
                             }   completion:^(BOOL finished) {
                                 contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                                                self.view.bounds.origin.y,
                                                                self.view.bounds.size.width,
                                                                self.view.bounds.size.height - TABBAR_HEIGHT);
                             }];
        }
        else
        {
            NSLog(@"NOT HIDDEN");
            contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.origin.y,
                                           self.view.bounds.size.width,
                                           self.view.bounds.size.height - TABBAR_HEIGHT);
            
            self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.size.height - TABBAR_HEIGHT,
                                           self.view.bounds.size.width,
                                           TABBAR_HEIGHT);
        }
    }
}

@end
