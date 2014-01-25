//
//  TagList.h
//  ios_tag_list
//
//  Created by Maxim on 9/23/13.
//  Copyright (c) 2013 Maxim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagList : UIScrollView
{
	NSMutableArray *tags;
	CGFloat posX;
	CGFloat	posY;
	
	SEL touchTagSelector;
	SEL touchBackgroundSelector;
}

- (id)initWithX:(CGFloat)x withY:(CGFloat)y;
- (void)setPosX:(CGFloat)x andY:(CGFloat)y;
- (void)createTags:(NSArray *)texts;
- (void)setTouchTagSelector:(SEL)selector;
- (void)setTouchBackgroundSelector:(SEL)selector;

@property (nonatomic, weak) id tagDelegate;

@end
