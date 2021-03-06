//
//  TagList.h
//  ios_tag_list
//
//  Created by Maxim on 9/23/13.
//  Copyright (c) 2013 Maxim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagList : UIScrollView

- (instancetype)initWithX:(CGFloat)x withY:(CGFloat)y;
- (void)setPosX:(CGFloat)x andY:(CGFloat)y;
- (void)createTags:(NSArray *)texts;
- (void)setTouchTagSelector:(SEL)selector;
- (void)setTouchBackgroundSelector:(SEL)selector;

@property (nonatomic, weak) id tagDelegate;

@property (nonatomic) NSInteger maxTagsInRow;

@property (nonatomic) CGFloat elementWidth;
@property (nonatomic) CGFloat elementHeight;
@property (nonatomic) CGFloat elementSpacingX;
@property (nonatomic) CGFloat elementSpacingY;

@property (nonatomic, strong) NSString *fontName;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat fontSizeMin;

@end
