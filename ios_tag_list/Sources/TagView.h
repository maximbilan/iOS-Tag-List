//
//  TagView.h
//  wymg
//
//  Created by Maxim on 9/22/13.
//  Copyright (c) 2013 Maxim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM( NSInteger, TagViewState )
{
    TagViewStateNormal,
    TagViewStateHighlighted
};

@interface TagView : UIView
{
	NSInteger state;
}

@property (nonatomic, strong) UIColor	*color;
@property (nonatomic, strong) UIColor	*colorHightlighted;
@property (nonatomic, strong) UIColor	*fontColor;
@property (nonatomic, strong) NSString	*text;

@end
