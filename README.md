iOS Tag List
============

<br>
iOS tag list. There're samples for iphone and ipad.<br>
<br>
![alt tag](https://raw.github.com/maximbilan/ios_tag_list/master/img/img1.png)
<b>How to use:</b>
<br>
Add to your project source files: <br>
<pre>
TagList.h
TagList.m
TagView.h
TagView.m
UIColor+TagColors.h
UIColor+TagColors.m
</pre>
You can add view in the Interface builder and set class to TagList or create in the code: <br>
<pre>
TagList *tagList = [[TagList alloc] initWithX:50.0 withY:50.0];
[self.view addSubview:tagList];
</pre>
For filling data in the tag list, you should create array and set it into tag list. For example:
<pre>
NSArray *array = [NSArray arrayWithObjects:@"tag 1", @"tag 2", @"tag 3", nil];
[self.tagList createTags:array];
</pre>
Besides that, if you need to handle tap on tag, you should set selectors. For example:
<pre>
[self.tagList setTouchTagSelector:@selector(touchTitleTag:)];
[self.tagList setTouchBackgroundSelector:@selector(touchTagOnBackground)];
</pre>

TouchTagSelector - handle tap on tag event<br>
TouchBackgroundSelector - handle touches out of the tags event

More details you can found in the project sample.

Apps using tag list
============

<a href="https://itunes.apple.com/us/app/wymg/id769463031">Wymg</a> - Where your money goes? Want to know? Easiest way to track your expenses, use wymg. Designed with simplicity and usability. With just a few taps you can track your expense or check purchases.
