//
//  ViewController.m
//  ios_tag_list
//
//  Created by Maxim Bilan on 1/25/14.
//  Copyright (c) 2014 Maxim Bilan. All rights reserved.
//

#import "ViewController.h"
#import "TagList.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet TagList *tagList;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UITextField *tagTextField;

- (void)touchView:(id)sender;

- (void)touchTitleTag:(NSString *)text;
- (void)touchTagOnBackground;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchView:)];
	[self.view addGestureRecognizer:gesture];
    
    NSArray *array = [NSArray arrayWithObjects:@"tag 1", @"tag 2", @"tag 3", @"tag 4", @"tag 5", @"tag 6", @"tag 7", @"tag 8", @"tag 9", @"tag 10", @"tag 11", nil];
    
    [self.tagList createTags:array];
    [self.tagList setTagDelegate:self];
    [self.tagList setTouchTagSelector:@selector(touchTitleTag:)];
    [self.tagList setTouchBackgroundSelector:@selector(touchTagOnBackground)];
}

- (void)touchTitleTag:(NSString *)text
{
    self.tagLabel.text = text;
    self.tagTextField.text = text;
}

- (void)touchTagOnBackground
{
    [self.tagTextField resignFirstResponder];
}

- (void)touchView:(id)sender
{
    [self.tagTextField resignFirstResponder];
}

@end
