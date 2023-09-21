# badgebutton-swift
A subclass of `UIButton` that has a badge view ready.

Usage:

```
// Swift:
let bell1 = BadgeButton(icon: UIImage(systemName: "bell.fill")!)
let bell2 = BadgeButton(icon: UIImage(systemName: "bell.fill")!, shouldLimitValueTo9: true)

// Objective-C:
// Using SF Symbols, and badgeButton as a barButtonItem.
UIImageConfiguration *config = [UIImageSymbolConfiguration configurationWithFont:[UIFont systemFontOfSize:25]];
UIImage *img = [UIImage systemImageNamed:@"message" withConfiguration:config];
self.chatButton = [[BadgeButton alloc] initWithIcon:img shouldLimitValueTo9:YES];
self.chatButton.contentMode = UIViewContentModeScaleAspectFit;
[self.chatButton addTarget:self action:@selector(openChat) forControlEvents:UIControlEventTouchUpInside];

UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
self.chatBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.chatButton];
[self.chatBarButtonItem.customView setTranslatesAutoresizingMaskIntoConstraints:NO];
[[self.chatBarButtonItem.customView.heightAnchor constraintEqualToConstant:30] setActive:YES];
[[self.chatBarButtonItem.customView.widthAnchor constraintEqualToConstant:30] setActive:YES];
self.navigationItem.rightBarButtonItems = @[leftSpace, self.chatBarButtonItem, rightSpace];

// Initial badge count.
[self.chatButton setBadgeValue:11];
```

Demo:

![ezgif-2-0700f9bc44](https://user-images.githubusercontent.com/12502679/158540914-5874cf4c-312b-499f-b94f-617931adcfd2.gif)
