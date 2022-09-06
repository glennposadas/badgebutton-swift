# badgebutton-swift
A subclass of `UIButton` that has a badge view ready.

Usage:

```
// Swift:
let b = BadgeButton(icon: UIImage(named: "bell", shouldLimitValueTo9: true)!)

// Objective-C:
UIImage *img = [UIImage imageNamed:@"ic_chat"];
self.chatButton = [[BadgeButton alloc] initWithIcon:img shouldLimitValueTo9:YES];
```

Demo:

![ezgif-2-0700f9bc44](https://user-images.githubusercontent.com/12502679/158540914-5874cf4c-312b-499f-b94f-617931adcfd2.gif)
