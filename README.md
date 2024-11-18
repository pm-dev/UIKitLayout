# UIKitLayout

UIKitLayout provides syntactic sugar on top of the NSLayoutAnchor system to facilitate easy
to setup, easy to debug, and easy to adjust auto-layout constraints.

It allows two views to "pin" themselves to one another in a syntax that reads like english:

```swift
let first = UIView()
let second = UIView()

first.trailing.pin(to: second.leading) // H:[first]-[second]
```

Add spacing between two pinned axes:

```swift
first.trailing.pin(to: second.leading, spacing: 5) // H:[first]-(5)-[second]
```

Add a relation other than `equals` for the constraint:

```swift
first.trailing.pin(to: second.leading, .greaterThanOrEqual, spacing: 5)  // H:[first]-(>=5)-[second]
```

This works with view dimensions as well as axis:

```swift
first.width.pin(to: second.height)
```

And instead of spacing, you can set a ratio:

```swift
first.width.pin(to: second.height, ratio: Ratio(1, to: 2))  // width of first will be half the height of second
```

And/or add a constant:

```swift
first.width.pin(to: second.height, plus: 5) // first's width will be 5 points greater than second's height
```

You'll be stopped from doing things that don't make sense:

```swift
first.width.pin(to second.leading) // compiler error
first.trailing.pin(to: second.bottom) // compiler error
```

Add a subview to a contrainer and pin all edges in once call:

```swift
let parent = UIView()
let child = UIView()
parent.embed(child)
```

Or specific anchors:

```swift
parent.embed(child, pin: [.top, .bottom, .centerX])
```

Adding insets (inward padding) and offsets (distance from an anchor point):

```swift
parent.embed(child, pin: [.top(inset: 5), .bottom(inset: 10), .centerX(offset: -4)])
```

With relations besides equals:

```swift
parent.embed(child, pin: [.top(inset: 5), .bottom(.greaterThanOrEqual, inset: 10), .centerX(offset: -4)])
```

- All `embed` functions will turn off the child view's `translatesAutoresizingMaskIntoConstraints` property.

Of course setting an explicit height or width is easy:

```swift
first.height.pin(to: 5)
first.width.pin(to: 6)
```

As is setting the aspect ratio:

```swift
first.constrain(aspectRatio: .equal)
```

All calls return the constraints they create:

```swift
let constraint = first.width.pin(to: second.height)
```

All calls accept `activate` as the last parameter:

```swift
let uninstalledConstraint = first.constrain(aspectRatio: .equal, activate: false)
```

And `priority` as the second to last parameter:

```swift
let unrequiredConstraint = first.constrain(aspectRatio: .equal, priority: .defaultLow)
```

Pinnable anchors include the system provided layout guides:

```swift
first.safeAreaLayoutGuide.trailing.pin(to: second.layoutMarginsGuide.Leading)
```

But your own layout guide may be used as well:

```swift
let guide: UILayoutGuide
guide.leadingAnchor.pin(to: .trailing, of: first)
guide.widthAnchor.pin(to: guide.heightAnchor)
```

Happy Coding!
And check out the `Grid` class which uses UIKitLayout to create an n x m grid with variable row heights and column widths.
