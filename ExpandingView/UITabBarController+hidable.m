//
//  UITabBarController+hidable.m
//  zummzumm2
//
//  Created by Tony Million on 02/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITabBarController+hidable.h"

@implementation UITabBarController (hidable)

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated
{
	if ( [self.view.subviews count] < 2 )
		return;
	
	UIView *contentView;
    
    NSLog(@"subviews = %@", self.view.subviews);
	
	if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
		contentView = [self.view.subviews objectAtIndex:1];
	else
		contentView = [self.view.subviews objectAtIndex:0];
	
	
	[UIView animateWithDuration:(animated ? .2 : 0)
					 animations:^{
						 if ( hidden )
						 {
							 contentView.frame = self.view.bounds;
                             
                             CGRect oldFrame = self.tabBar.frame;
                             oldFrame.origin.y += self.tabBar.frame.size.height;
                             self.tabBar.frame = oldFrame;
						 }
						 else
						 {
							 contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                                            self.view.bounds.origin.y,
                                                            self.view.bounds.size.width,
                                                            self.view.bounds.size.height - self.tabBar.frame.size.height);
                             
                             CGRect oldFrame = self.tabBar.frame;
                             oldFrame.origin.y = self.view.bounds.size.height - self.tabBar.frame.size.height;
                             self.tabBar.frame = oldFrame;
                             
						 }
					 }
					 completion:^(BOOL finished) {
					 }];
    
}

@end
