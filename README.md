## FPTitleSwipe
============

A title swipe similar to the Sparrow Mail app. Fully working. Report any bugs :)  
Used inside a UINavigationController's titleview.

![SceenShot](http://i.imgur.com/wkmIX.png "SceenShot")

## How to use
============

``` objective-c
NSArray* titles = @[@"Page 1",@"Page 2",@"Page 3"];
FPNavTitleSwipeView* view = [[FPNavTitleSwipeView alloc] initWithFrame:CGRectMake(0, 0, 120, 40) titleItems:titles];
view.delegate = self;
[view setCurrentPageColor:[UIColor redColor]]; //optional
[view setPageColor:[UIColor lightGrayColor]]; //optional
self.navigationItem.titleView = view;
```


## Requires
============
ARC  
QuartzCore






## License

FPTitleSwipe is available under the MIT license. See the LICENSE file for more info.




