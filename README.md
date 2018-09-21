iOS Tag List
============

A simple iOS control, the list of tags.<br><br>
![alt tag](https://raw.github.com/maximbilan/ios_tag_list/master/img/img1.png)
## Using:
Add to your project the next source files: <br>
<pre>
TagList.h
TagList.m
TagView.h
TagView.m
UIColor+TagColors.h
UIColor+TagColors.m
</pre>
You can add view in the <i>Interface builder</i> and set class to <i>TagList</i> or create in the code: <br>
<pre>
TagList *tagList = [[TagList alloc] initWithX:50.0 withY:50.0];
[self.view addSubview:tagList];
</pre>
For filling data in the tag list, you should create an array and set it into tag list. For example:
<pre>
NSArray *array = @[@"tag 1", @"tag 2", @"tag 3"];
[self.tagList createTags:array];
</pre>
Besides that, if you need to handle tap on the tag, you should set selectors. For example:
<pre>
[self.tagList setTouchTagSelector:@selector(touchTitleTag:)];
[self.tagList setTouchBackgroundSelector:@selector(touchTagOnBackground)];
</pre>

<i>TouchTagSelector</i> - handle tap on the tag event<br>
<i>TouchBackgroundSelector</i> - handle touches out of the tags event

More details you can find in the project sample.
