iOS Tag List
============

iOS tag list. There're samples for iPhone and iPad.<br>
![alt tag](https://raw.github.com/maximbilan/ios_tag_list/master/img/img1.png)
## How to use:
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
You can add view in the Interface builder and set class to <i>TagList</i> or create in the code: <br>
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

<i>TouchTagSelector</i> - handle tap on tag event<br>
<i>TouchBackgroundSelector</i> - handle touches out of the tags event

More details you can found in the project sample.
