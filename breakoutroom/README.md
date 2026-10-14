# Flutter Text Widgets: Text, DefaultTextStyle & RichText
# Presented By Uwineza Bonesha Kevine on 14th October 2026
A small, beginner-friendly Flutter app that shows **how Flutter displays and styles text**. Everything runs on one scrollable screen, and every concept in the code is explained in this README in simple words, with analogies where they help.

The app covers three widgets:

1. **Text** – the basic widget for showing a string.
2. **DefaultTextStyle** – a way to give many `Text` widgets the same style at once.
3. **RichText** (and **Text.rich**) – a way to mix several styles inside one paragraph.

Along the way it also explains the everyday Flutter building blocks the code uses: `ThemeData`, `MaterialApp`, `Scaffold`, `ListView`, `StatefulWidget`, `BuildContext`, `TapGestureRecognizer` and more.

---

## Who this is for

- **Beginners** learning Flutter who want to understand text styling properly, not just copy code.
- **Developers** who have used `Text` but are unsure why `RichText` sometimes looks invisible, or how style inheritance works.
- **Teachers and students** looking for a small, well-commented example to study or share.

No prior knowledge beyond basic programming is assumed. If you have never written Dart, the [Small Dart features used](#small-dart-features-used) section explains the language features that appear in the code.

---

## What you will learn

By reading the code and this guide, you will understand:

- How Flutter passes styles **down the widget tree** (theme → default text style → your text).
- When to use `Text`, `DefaultTextStyle`, `RichText` or `Text.rich`.
- Why `RichText` ignores inherited styles, and how to fix it.
- How to make **one word** inside a paragraph tappable.
- How `ThemeData` lets you change the look of the whole app from one place.

---

## Table of contents

**Getting started**
1. [Requirements](#requirements)
2. [Getting started](#getting-started)
3. [Project structure](#project-structure)
4. [What you will see on the screen](#what-you-will-see-on-the-screen)
5. [How to use this guide](#how-to-use-this-guide)

**Flutter basics used in the app**
6. [The basics: widgets and the widget tree](#the-basics-widgets-and-the-widget-tree)
7. [How the app starts: main and runApp](#how-the-app-starts-main-and-runapp)
8. [MaterialApp](#materialapp)
9. [ThemeData](#themedata)
10. [StatelessWidget vs StatefulWidget](#statelesswidget-vs-statefulwidget)
11. [BuildContext](#buildcontext)
12. [Scaffold and AppBar](#scaffold-and-appbar)
13. [ListView](#listview)
14. [Layout helpers: Padding, EdgeInsets, SizedBox, Container, Column](#layout-helpers)

**The text widgets**
15. [Text](#text)
16. [TextStyle](#textstyle)
17. [DefaultTextStyle](#defaulttextstyle)
18. [RichText and TextSpan](#richtext-and-textspan)
19. [Text.rich](#textrich)
20. [TapGestureRecognizer](#tapgesturerecognizer)
21. [SnackBar and ScaffoldMessenger](#snackbar-and-scaffoldmessenger)
22. [The SectionTitle helper widget](#the-sectiontitle-helper-widget)

**Reference**
23. [Small Dart features used](#small-dart-features-used)
24. [Comparison table](#comparison-table)
25. [Common mistakes](#common-mistakes)
26. [Exercises: try it yourself](#exercises-try-it-yourself)
27. [Summary](#summary)
28. [Further reading](#further-reading)
29. [Contributing](#contributing)

---

## Requirements

- **Flutter SDK** (any recent stable version with Material 3 support). Install guide: <https://docs.flutter.dev/get-started/install>
- An editor: **VS Code** (with the Flutter extension) or **Android Studio**.
- A device to run on: an Android emulator, iOS simulator (macOS only), a real phone, Chrome, or a desktop target.

Check your setup with:

```bash
flutter doctor
```

Fix anything it marks with ✗ before continuing.

---

## Getting started

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```
2. **Download the dependencies:**
   ```bash
   flutter pub get
   ```
3. **Start a device** (for example an Android emulator from Android Studio → Device Manager → ▶), or plug in a phone. List available devices with:
   ```bash
   flutter devices
   ```
4. **Run the app:**
   ```bash
   flutter run
   ```

### Hot reload

While the app is running, change something in `lib/main.dart`, save, and press **r** in the terminal (or just save in VS Code / Android Studio). The screen updates in about a second without restarting the app. This makes it very easy to experiment with styles and see the result immediately.

### Prefer to start from scratch?

You can also copy only the code into a fresh project:

```bash
flutter create text_widgets_demo
cd text_widgets_demo
```

Then replace everything in `lib/main.dart` with this repository's `lib/main.dart` and run `flutter run`.

---

## Project structure

The whole example lives in **one file**, so it is easy to read from top to bottom.

```
.
├── lib/
│   └── main.dart      ← all the app code (the only file you need to read)
├── pubspec.yaml       ← project name and dependencies (no extra packages needed)
└── README.md          ← this guide
```

Inside `lib/main.dart`, the code is organized like this:

| Part of the file | What it is |
|---|---|
| `main()` | Starts the app. |
| `TextWidgetsDemo` | The root widget: sets up `MaterialApp` and the theme. |
| `DemoPage` / `_DemoPageState` | The single screen, split into three commented sections (PART 1, 2, 3). |
| `SectionTitle` | A small helper widget for the section headings. |

---

## What you will see on the screen

The screen scrolls from top to bottom through three sections:

| Section | What it shows |
|---|---|
| **1. Text** | Plain text, styled text, centered text, text cut with "…", and text that fades out. |
| **2. DefaultTextStyle** | Lines that are teal and bold without having their own style, one line that changes only its color, and a merged style. |
| **3. RichText** | One sentence with green, pink and tappable words, then a comparison showing that `RichText` ignores the inherited style but `Text.rich` does not. |

Each example in the code is labeled (1a, 1b, 2a, 3c, …) so you can match what you see on screen with the code that produced it.

> **Note about section 3c:** the middle line ("RichText: I am NOT orange") will probably look like an **empty gap**. It is there, but it is white on a light background. This is on purpose and is explained in [RichText and TextSpan](#richtext-and-textspan).

---

## How to use this guide

- **New to Flutter?** Read the sections in order. The "Flutter basics" part explains the building blocks before the text widgets.
- **Already know the basics?** Jump straight to [Text](#text), [DefaultTextStyle](#defaulttextstyle) and [RichText and TextSpan](#richtext-and-textspan).
- **Learn by doing:** keep the app running, open `lib/main.dart` next to it, and try the [exercises](#exercises-try-it-yourself) with hot reload.
- **Need a quick answer?** See the [Comparison table](#comparison-table) and [Common mistakes](#common-mistakes).

---

## The basics: widgets and the widget tree

In Flutter, **everything you see is a widget**: text, buttons, spacing, even the whole app. Widgets are like **LEGO bricks**: small pieces you put inside each other to build something bigger.

When you put widgets inside other widgets, you get a **widget tree**:

```
MaterialApp
 └── Scaffold
      ├── AppBar
      │    └── Text ('Text, DefaultTextStyle & RichText')
      └── ListView
           ├── SectionTitle ('1. Text')
           ├── Text ('Hello Flutter! ...')
           ├── SizedBox
           ├── ...
           └── DefaultTextStyle
                └── Column
                     ├── Text
                     ├── RichText
                     └── Text.rich
```

- A widget **above** another is its **parent** (or ancestor).
- A widget **below** another is its **child** (or descendant).

This matters a lot for text styling, because `ThemeData` and `DefaultTextStyle` work by **passing information down the tree** from parents to children.

---

## How the app starts: main and runApp

```dart
void main() {
  runApp(const TextWidgetsDemo());
}
```

- `main()` is the **entry point**: the first function Dart runs when the app starts, like the front door of a house.
- `runApp()` takes a widget and makes it the **root** (the very top) of the widget tree. Here, the root is `TextWidgetsDemo`.

---

## MaterialApp

```dart
return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Text Widgets Demo',
  theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
  home: const DemoPage(),
);
```

`MaterialApp` is the **foundation of the app**. It sets up things every app needs, following Google's **Material Design** style.

| Property | Meaning |
|---|---|
| `debugShowCheckedModeBanner: false` | Hides the red "DEBUG" ribbon in the top-right corner. |
| `title` | The app's name, used by the operating system (for example in the recent apps list). |
| `theme` | The app's style guide (see [ThemeData](#themedata)). |
| `home` | The first screen shown when the app opens. |

**Analogy:** `MaterialApp` is the building and its electricity, water and rules. The screens are the rooms inside.

---

## ThemeData

```dart
theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
```

### In simple words

`ThemeData` is the **style guide for the whole app**, written in one place. It decides the default colors, text sizes, fonts and the look of buttons, app bars and other widgets.

### Analogy: the school uniform

A school chooses one uniform: shirt color, shoes, tie. Every student wears it without deciding individually. If the school changes the shirt from white to blue, every student changes at once.

`ThemeData` is that uniform. You define the look once, and every widget "wears" it automatically.

### What is inside it

| Part | What it controls | In our code |
|---|---|---|
| `colorScheme` | The app's colors (main color, background, text on buttons, etc.) | Generated from `colorSchemeSeed: Colors.indigo` |
| `textTheme` | Named text styles like `headlineSmall` (headings) and `bodyMedium` (normal text) | Not written by us, so Flutter creates a default one |
| `useMaterial3` | Uses the newest version of Material Design (rounder shapes, softer colors) | `true` |

- **`colorSchemeSeed`**: you give Flutter **one** color, and it generates a whole matching palette from it. That is why the app bar and SnackBar look indigo-ish even though we never colored them.
- **`textTheme`**: since we didn't provide one, Flutter uses its defaults. In Material 3, `bodyMedium` is size 14 and `headlineSmall` is size 24.

### Where plain Text gets its style

The plain `Text` in section 1a has no style, yet it still has a font, size and color. Here is the path:

1. `ThemeData` creates a default `textTheme`, including `bodyMedium`.
2. `Scaffold` uses a `Material` widget inside it.
3. That `Material` widget wraps everything below it in a **`DefaultTextStyle`** set to `textTheme.bodyMedium`.
4. The plain `Text` inherits that style.

So even before section 2, you are already using `DefaultTextStyle`. Flutter just adds it for you.

### How widgets read the theme

```dart
Theme.of(context).textTheme.headlineSmall
```

`Theme.of(context)` means: "look up the widget tree and give me the nearest theme." It's how a widget asks: "what's the uniform?"

### Try it yourself

Change the theme and hot reload:

```dart
theme: ThemeData(
  colorSchemeSeed: Colors.green,
  useMaterial3: true,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 20, color: Colors.brown),
  ),
),
```

The whole app turns green, and every unstyled `Text` becomes brown and size 20, without touching any `Text` widget.

---

## StatelessWidget vs StatefulWidget

Flutter has two main kinds of custom widgets.

| | StatelessWidget | StatefulWidget |
|---|---|---|
| Can it change by itself? | No | Yes |
| Has `initState` / `dispose`? | No | Yes |
| Example in our app | `TextWidgetsDemo`, `SectionTitle` | `DemoPage` |

**Analogy:**
- A **StatelessWidget** is like a **printed poster**. Once printed, it stays the same.
- A **StatefulWidget** is like a **whiteboard**. It can be updated, and it has a beginning (setting it up) and an end (cleaning it).

### Why DemoPage is a StatefulWidget

`DemoPage` doesn't change what it shows. The **only** reason it's stateful is the `TapGestureRecognizer`, which must be:
- **created** once in `initState()`, and
- **cleaned up** in `dispose()`.

A `StatelessWidget` has neither of those methods.

### The two classes of a StatefulWidget

```dart
class DemoPage extends StatefulWidget {
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> { ... }
```

- `DemoPage` is the widget itself (the "label").
- `_DemoPageState` holds the data and the `build` method (the "content").
- The `_` at the start of `_DemoPageState` makes it **private**: only usable inside this file.

### Lifecycle methods used

| Method | When it runs | What we do there |
|---|---|---|
| `initState()` | Once, when the widget is first created | Create the `TapGestureRecognizer` |
| `build()` | Every time the widget needs to be drawn | Describe the UI |
| `dispose()` | Once, when the widget is removed forever | Dispose the `TapGestureRecognizer` |

Always call `super.initState()` first and `super.dispose()` last.

---

## BuildContext

```dart
Widget build(BuildContext context) { ... }
```

`context` tells a widget **where it is in the widget tree**.

**Analogy:** it's like a **home address**. With an address, you can find the nearest school, hospital or post office. With a `context`, a widget can find the nearest theme, `DefaultTextStyle` or `ScaffoldMessenger` above it.

That's why you see `context` in:
- `Theme.of(context)`
- `DefaultTextStyle.of(context)`
- `ScaffoldMessenger.of(context)`

All `.of(context)` methods mean the same thing: **"look up the tree from where I am and find the nearest one of these."**

---

## Scaffold and AppBar

```dart
return Scaffold(
  appBar: AppBar(title: const Text('Text, DefaultTextStyle & RichText')),
  body: ListView( ... ),
);
```

- **`Scaffold`** is the **basic layout of one screen**. It provides standard places for an app bar, the main content (`body`), floating buttons, drawers, and SnackBars.
- **`AppBar`** is the colored bar at the top showing the screen's title.
- **`body`** is the main content of the screen.

**Analogy:** `Scaffold` is the **frame of a page in a notebook**: a header line at the top and the writing space below. You decide what goes in each place.

---

## ListView

```dart
body: ListView(
  padding: const EdgeInsets.all(16),
  children: [ ... ],
),
```

`ListView` shows its children **one after another in a scrollable list**.

### Why we need it

Our page is taller than the phone screen. A `Column` also stacks widgets vertically, but it **does not scroll**. The extra content would go off-screen and Flutter would show a yellow-and-black "overflow" warning.

**Analogy:**
- A `Column` is a **sheet of paper**: what doesn't fit falls off the edge.
- A `ListView` is a **scroll of paper** (like your chat history): as long as you want, and you move it up and down.

### Properties used

| Property | Meaning |
|---|---|
| `padding: EdgeInsets.all(16)` | 16 pixels of space on all four sides, so content doesn't touch the screen edges. |
| `children` | The widgets to show, from top to bottom, in the order written. |

### ListView vs ListView.builder

- `ListView(children: [...])` builds **all** children at once. Fine for short pages like ours.
- `ListView.builder` builds **only the visible items** and creates others while you scroll. Use it for long lists (hundreds or thousands of items).

```dart
ListView.builder(
  itemCount: 1000,
  itemBuilder: (context, index) => Text('Item $index'),
)
```

---

## Layout helpers

### Padding and EdgeInsets

```dart
Padding(
  padding: const EdgeInsets.only(top: 28, bottom: 12),
  child: ...,
)
```

`Padding` adds **empty space around its child**. `EdgeInsets` describes how much space and on which sides:

| Constructor | Meaning |
|---|---|
| `EdgeInsets.all(16)` | 16 on all four sides |
| `EdgeInsets.only(top: 28, bottom: 12)` | Only on the sides you name; the others are 0 |
| `EdgeInsets.symmetric(horizontal: 8, vertical: 4)` | Same value left and right, same value top and bottom |

**Analogy:** padding is the **margin of a picture frame**, the empty space between the frame and the picture.

### SizedBox

```dart
const SizedBox(height: 12),
```

An empty box with a fixed size. Here it's used as a **spacer**: 12 pixels of empty space between two widgets.

### Container

```dart
Container(
  width: double.infinity,
  color: Colors.indigo.shade50,
  child: const Text('Centered text', textAlign: TextAlign.center),
),
```

A general-purpose box that can have a size, color, padding, border and more.
- `width: double.infinity` means "be as wide as possible" (full screen width).
- `Colors.indigo.shade50` is a very light indigo. We colored it so you can **see** the box the text is centered inside.

### Column

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [ ... ],
)
```

Places children **vertically**, one below another (not scrollable). `CrossAxisAlignment.start` aligns them to the **left** edge instead of centering them.

---

## Text

`Text` is the basic widget for showing a string with **one style**.

```dart
const Text('Hello Flutter! This is a plain Text widget.'),
```

### Properties used in the app

| Property | What it does | Section |
|---|---|---|
| `style` | How the text looks (size, color, weight, etc.). See [TextStyle](#textstyle). | 1b |
| `textAlign` | Horizontal alignment: `left`, `right`, `center`, `justify`. | 1c |
| `maxLines` | Maximum number of lines to show. | 1d, 1e |
| `overflow` | What to do with text that doesn't fit. | 1d, 1e |

### textAlign needs space

In section 1c, the text is centered **only because** the `Container` is full width. A `Text` widget is normally only as wide as its words, so it has no extra room to center inside.

**Analogy:** you can't center a book on a shelf that's exactly the size of the book.

### TextOverflow options

| Value | Result |
|---|---|
| `TextOverflow.ellipsis` | Cuts the text and adds "…" (section 1d) |
| `TextOverflow.fade` | Fades the end of the text out (section 1e) |
| `TextOverflow.clip` | Cuts the text sharply with no sign |
| `TextOverflow.visible` | Lets text draw outside its box |

---

## TextStyle

`TextStyle` describes **how text looks**.

```dart
style: TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.indigo,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
  decoration: TextDecoration.underline,
),
```

| Property | Meaning | Example values |
|---|---|---|
| `fontSize` | Size of the letters | `14`, `24` |
| `fontWeight` | Thickness of the letters | `FontWeight.normal`, `FontWeight.w600`, `FontWeight.bold` |
| `color` | Letter color | `Colors.red`, `Colors.indigo` |
| `letterSpacing` | Extra space between letters | `2` |
| `fontStyle` | Normal or slanted | `FontStyle.italic` |
| `decoration` | Lines on the text | `TextDecoration.underline`, `lineThrough` |

**Important rule:** properties you **don't** set are `null`, which means "use whatever I inherit." This is what makes [DefaultTextStyle](#defaulttextstyle) work.

---

## DefaultTextStyle

### In simple words

`DefaultTextStyle` **gives a style to every `Text` widget below it** in the widget tree, so you don't need to repeat the same style again and again.

### Analogy: the family rule

Parents say: "In this house, everyone speaks quietly." Every child follows that rule automatically. One child can still say: "I'll speak quietly, but in French," changing only one thing while following the rest of the rule.

### 2a – Inheriting

```dart
const DefaultTextStyle(
  style: TextStyle(fontSize: 18, color: Colors.teal, fontWeight: FontWeight.w600),
  child: Column(
    children: [
      Text('I inherit teal, size 18, bold.'),
      Text('Me too, without writing any style!'),
      ...
```

Neither `Text` has a `style`, but both are teal, size 18 and bold, because they inherit from the parent.

### 2b – Overriding only part of it

```dart
Text(
  'I override only the color to red.',
  style: TextStyle(color: Colors.red),
),
```

This line is red **but still size 18 and bold**. A `Text`'s own style is **merged** with the inherited one: whatever it sets wins, whatever it leaves empty is inherited.

### 2c – DefaultTextStyle.merge

```dart
DefaultTextStyle(
  style: const TextStyle(fontSize: 18, color: Colors.deepPurple),
  child: DefaultTextStyle.merge(
    style: const TextStyle(fontStyle: FontStyle.italic),
    child: const Text('Purple + size 18 (from parent) + italic (merged)'),
  ),
),
```

- A normal `DefaultTextStyle` **replaces** the style from above it.
- `DefaultTextStyle.merge` **adds** to the style from above it.

Result: purple + size 18 (from the parent) + italic (added).

**Analogy:** a normal `DefaultTextStyle` is like painting a wall a completely new color. `merge` is like adding a sticker on the existing wall.

### Reading it manually

```dart
DefaultTextStyle.of(context).style
```

Gives you the nearest `DefaultTextStyle` above. Useful for `RichText`, which doesn't read it by itself.

### Who uses DefaultTextStyle automatically?

| Widget | Uses DefaultTextStyle? |
|---|---|
| `Text` | ✅ Yes |
| `Text.rich` | ✅ Yes |
| `RichText` | ❌ No |

---

## RichText and TextSpan

### In simple words

`RichText` shows **one paragraph with different styles inside it**. A normal `Text` has only one style for the whole string. If you want one word bold and another word green in the same sentence, you need `RichText` (or `Text.rich`).

### Analogy: Microsoft Word

You type one sentence, then select one word and make it bold, select another and make it pink, and underline a third. Still one sentence, but different parts look different.

### TextSpan: the pieces of the sentence

`RichText` doesn't take a string. It takes a **`TextSpan`**: a piece of text with an optional style. A `TextSpan` can contain other `TextSpan`s as `children`, forming a small tree.

```dart
RichText(
  text: TextSpan(
    style: const TextStyle(fontSize: 18, color: Colors.black87), // base style
    children: [
      const TextSpan(text: 'Flutter is '),
      const TextSpan(
        text: 'fast',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
      ),
      const TextSpan(text: ', '),
      const TextSpan(
        text: 'beautiful',
        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.pink),
      ),
      const TextSpan(text: ' and '),
      TextSpan(
        text: 'clickable',
        style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
        recognizer: _linkTap,
      ),
      const TextSpan(text: '!'),
    ],
  ),
)
```

How it works:

1. The **parent `TextSpan`** sets the **base style**: size 18, dark color.
2. Children **without** a style (like `'Flutter is '`) use the parent's style.
3. Children **with** a style keep the parent's style and change only what they set. "fast" is still size 18, but green and bold.
4. All pieces are joined in order: "Flutter is **fast**, *beautiful* and <u>clickable</u>!"

Inheritance works **between spans** inside the same `RichText`, but not from outside widgets.

### The important catch: RichText ignores DefaultTextStyle

`RichText` **never looks up the tree** for a `DefaultTextStyle` or the theme's text style. That's why we had to give the parent `TextSpan` a base style ourselves.

Section 3c proves it:

```dart
DefaultTextStyle(
  style: const TextStyle(fontSize: 22, color: Colors.orange),
  child: Column(
    children: [
      const Text('Text: I am orange (inherited)'),
      RichText(
        text: const TextSpan(text: 'RichText: I am NOT orange (no inheritance)'),
      ),
      const Text.rich(...),
    ],
  ),
),
```

The `RichText` sits **inside** the orange `DefaultTextStyle`, but it is **not** orange. Since its `TextSpan` has no style and nothing is inherited, Flutter falls back to the raw defaults of its text engine:

| Property | Raw default |
|---|---|
| Font size | 14 |
| Font | Platform default (Roboto on Android) |
| Color | **White** |

On our light background, white text is almost invisible, so this line looks like an **empty gap** on screen.

### Three ways to fix it

1. **Give it its own style:**
   ```dart
   RichText(
     text: const TextSpan(
       text: 'RichText: now I have a style',
       style: TextStyle(fontSize: 22, color: Colors.orange),
     ),
   )
   ```
2. **Borrow the inherited style manually:**
   ```dart
   RichText(
     text: TextSpan(
       text: 'RichText: I borrowed the default style',
       style: DefaultTextStyle.of(context).style,
     ),
   )
   ```
   (`const` is removed because the style is only known while the app runs.)
3. **Use `Text.rich` instead** (next section).

---

## Text.rich

```dart
const Text.rich(
  TextSpan(
    text: 'Text.rich: I am orange ',
    children: [
      TextSpan(
        text: 'and I can mix styles',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  ),
),
```

`Text.rich` takes the **same `TextSpan` tree** as `RichText`, but it **does** inherit `DefaultTextStyle` and the theme. In section 3d, the whole line is orange (inherited) and the second part is also bold.

**Best of both worlds:** mixed styles like `RichText`, and inheritance like `Text`.

Flutter recommends **`Text.rich` in most cases**. Use `RichText` only when you deliberately want **no** inherited style and full manual control.

---

## TapGestureRecognizer

### In simple words

`TapGestureRecognizer` is an object that **listens for a tap and runs your code when it happens**. In our app, it makes the word "clickable" show a SnackBar.

### Why we need it

Normally you make something tappable with a button or a `GestureDetector`. But a `TextSpan` is **not a widget**, just a piece of text inside a paragraph, so you can't wrap it in anything. Wrapping the whole `RichText` would make the **entire sentence** tappable. We want **only one word**, so we attach a recognizer to that `TextSpan`.

### Analogy: the doorbell

The whole house (the paragraph) is there, but only the doorbell (one word) reacts when pressed. The `TapGestureRecognizer` is the wiring behind the doorbell.

### Step by step

**1. Declare it**

```dart
late final TapGestureRecognizer _linkTap;
```

- `late`: "I'll give this a value later, before it's used."
- `final`: it's set only once.

**2. Create it in `initState`**

```dart
@override
void initState() {
  super.initState();
  _linkTap = TapGestureRecognizer()
    ..onTap = () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You tapped the link inside RichText!')),
      );
    };
}
```

- Created in `initState` so it's made **once**, not on every rebuild.
- `..onTap` uses the **cascade operator** (see [Small Dart features](#small-dart-features-used)).
- `onTap` is the function that runs when the word is tapped.

**3. Attach it to the TextSpan**

```dart
TextSpan(text: 'clickable', ..., recognizer: _linkTap),
```

**4. Clean it up in `dispose`**

```dart
@override
void dispose() {
  _linkTap.dispose();
  super.dispose();
}
```

The recognizer holds resources. If you don't dispose it, you get a **memory leak** (memory that's never freed). Doorbell analogy: when you move out, disconnect the wiring.

### Other recognizers

| Recognizer | Reacts to |
|---|---|
| `TapGestureRecognizer` | A tap |
| `DoubleTapGestureRecognizer` | A double tap |
| `LongPressGestureRecognizer` | Holding a finger on the text |

They're all imported from `package:flutter/gestures.dart`, which is why that import is at the top of the file.

---

## SnackBar and ScaffoldMessenger

```dart
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('You tapped the link inside RichText!')),
);
```

- A **SnackBar** is a short message that slides up from the bottom of the screen and disappears after a few seconds.
- **ScaffoldMessenger** is the widget that manages SnackBars. `MaterialApp` creates one for you.
- `ScaffoldMessenger.of(context)` finds it by looking up the tree.

**Analogy:** the SnackBar is a **notification note**, and `ScaffoldMessenger` is the **mail carrier** that delivers it to the screen.

---

## The SectionTitle helper widget

```dart
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 12),
      child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
    );
  }
}
```

A small custom widget so every section heading looks the same without repeating code.

| Line | Meaning |
|---|---|
| `extends StatelessWidget` | A heading never changes after it's drawn, so it's stateless. |
| `final String title;` | The heading text. `final` because widgets are **immutable** (can't change once created). |
| `const SectionTitle(this.title, {super.key});` | The constructor. `this.title` is **positional**, so we write `SectionTitle('1. Text')` without a name. `{super.key}` is an optional key passed to the parent class. |
| `@override Widget build(...)` | Describes what this widget looks like. |
| `Padding(...)` | 28 pixels above (separates sections), 12 below (space before content). |
| `Theme.of(context).textTheme.headlineSmall` | Uses the theme's heading style (size 24 in Material 3) instead of a hand-written style. Change the theme and all headings update. |

**Why make our own widget?** Write once, use many times. If you want all headings to change, you edit **one place**.

---

## Small Dart features used

### `const`

```dart
const Text('Hello Flutter!')
```

Means "this value is fixed and known before the app runs." Flutter creates it **once** and reuses it instead of rebuilding it. A small, free performance boost. You can't use `const` when something depends on runtime values (like `context` or `_linkTap`).

### `final`

A variable that can be set **only once**.

### `late`

"I promise to give this a value later, before using it." Used for `_linkTap` because it's created in `initState`, not at declaration.

### The cascade operator `..`

```dart
_linkTap = TapGestureRecognizer()..onTap = () { ... };
```

Means: "create the object, then set `onTap` **on the same object**, then give me the object." It's a shortcut for:

```dart
_linkTap = TapGestureRecognizer();
_linkTap.onTap = () { ... };
```

### `@override`

Says "I'm replacing a method from the parent class" (like `build`, `initState`, `dispose`). It helps catch typos: if the method name is wrong, Dart warns you.

### `super`

Refers to the **parent class**. `super.initState()` and `super.dispose()` let Flutter run its own setup and cleanup. `super.key` passes the key to the parent constructor.

### `Key`

An ID Flutter can use to tell widgets apart when the tree is rebuilt, especially in lists where items move. Not needed in this example, but good practice to accept it in custom widgets.

### `_` (underscore)

A name starting with `_` is **private**: only usable inside the same file (like `_DemoPageState` and `_linkTap`).

### `import`

```dart
import 'package:flutter/gestures.dart';  // TapGestureRecognizer
import 'package:flutter/material.dart';  // Material widgets: Text, Scaffold, etc.
```

Brings in code from other libraries so we can use their widgets and classes.

---

## Comparison table

| | `Text` | `DefaultTextStyle` | `RichText` | `Text.rich` |
|---|---|---|---|---|
| **Purpose** | Show text with one style | Give a style to all `Text` below it | Mix styles in one paragraph | Mix styles in one paragraph |
| **Shows text itself?** | ✅ | ❌ (only passes a style down) | ✅ | ✅ |
| **Multiple styles in one paragraph?** | ❌ | — | ✅ | ✅ |
| **Inherits DefaultTextStyle / theme?** | ✅ | Can replace or merge (`.merge`) | ❌ | ✅ |
| **Tappable parts?** | ❌ | — | ✅ (via `recognizer`) | ✅ (via `recognizer`) |
| **When to use** | Most text | Sharing a style across many widgets | Full manual control, no inheritance | Mixed styles in normal apps |

---

## Common mistakes

1. **Using `RichText` and wondering why the text is invisible or tiny.**
   It ignores inherited styles and falls back to size 14, white. Give the root `TextSpan` a style, or use `Text.rich`.

2. **Expecting `textAlign` to center text that has no extra space.**
   The `Text` must be inside something wider than the words (like a full-width `Container`).

3. **Using `DefaultTextStyle` when you meant `DefaultTextStyle.merge`.**
   A plain `DefaultTextStyle` **replaces** the style from above; `merge` **adds** to it.

4. **Forgetting to dispose a `TapGestureRecognizer`.**
   Causes a memory leak. Always create it in `initState` and dispose it in `dispose`.

5. **Creating the recognizer inside `build`.**
   `build` can run many times, creating a new recognizer each time that never gets disposed.

6. **Using `Column` for content taller than the screen.**
   It doesn't scroll and shows an overflow warning. Use `ListView` (or wrap the `Column` in a `SingleChildScrollView`).

7. **Styling every `Text` by hand.**
   Use `ThemeData` and `DefaultTextStyle` so the style lives in one place.

---

## Exercises: try it yourself

Keep the app running and try these changes with hot reload. Each one shows a key idea in action.

1. **Change the whole app's color.** In `TextWidgetsDemo`, replace `Colors.indigo` with `Colors.green`. Notice the app bar and headings change without touching them.
2. **Change the default text style for the whole app.** Add a `textTheme` to `ThemeData` (see [Try it yourself](#try-it-yourself)) and watch every unstyled `Text` change.
3. **Break the inheritance on purpose.** In section 2a, give the second `Text` a `style: TextStyle(fontSize: 30)`. Is it still teal? (It should be: only the size changed.)
4. **Replace instead of merge.** In section 2c, change `DefaultTextStyle.merge` to a plain `DefaultTextStyle` with the same italic style. What happens to the purple color and size 18?
5. **Make the invisible line visible.** In section 3c, fix the `RichText` using one of the three methods in [RichText and TextSpan](#richtext-and-textspan).
6. **Add a second tappable word.** Create another `TapGestureRecognizer` that shows a different SnackBar. Don't forget to dispose it.
7. **Convert RichText to Text.rich.** In section 3a, replace `RichText(text: ...)` with `Text.rich(...)` and remove the base style. What changes?
8. **Test overflow.** In section 1d, change `maxLines` to `3` and `overflow` to `TextOverflow.clip`, then try `TextOverflow.visible`.

---

## Summary

- **Widgets** are LEGO bricks; putting them inside each other forms the **widget tree**.
- **`ThemeData`** is the app's uniform: define colors and text styles once at the top, and every widget follows them.
- **`Text`** shows a string with **one** style.
- **`DefaultTextStyle`** passes a style **down the tree** to every `Text` below it; `.merge` adds to the style instead of replacing it.
- **`RichText`** mixes **many styles** in one paragraph using `TextSpan` pieces, but **ignores inherited styles**.
- **`Text.rich`** does the same as `RichText` **and** inherits styles. It's the recommended choice in most apps.
- **`TapGestureRecognizer`** makes part of a `TextSpan` tappable; create it in `initState`, dispose it in `dispose`.
- **`ListView`** is a scrollable list; use `ListView.builder` for long lists.

> **One sentence to remember:** Use `Text` for one style, `DefaultTextStyle` to share a style, and `Text.rich` (or `RichText` for full control) when one paragraph needs mixed styles or tappable words.

---

## Further reading

Official Flutter documentation for everything used in this project:

- [Text](https://api.flutter.dev/flutter/widgets/Text-class.html)
- [TextStyle](https://api.flutter.dev/flutter/painting/TextStyle-class.html)
- [DefaultTextStyle](https://api.flutter.dev/flutter/widgets/DefaultTextStyle-class.html)
- [RichText](https://api.flutter.dev/flutter/widgets/RichText-class.html)
- [TextSpan](https://api.flutter.dev/flutter/painting/TextSpan-class.html)
- [ThemeData](https://api.flutter.dev/flutter/material/ThemeData-class.html)
- [TapGestureRecognizer](https://api.flutter.dev/flutter/gestures/TapGestureRecognizer-class.html)
- [ListView](https://api.flutter.dev/flutter/widgets/ListView-class.html)
- [Flutter documentation home](https://docs.flutter.dev/)

---

## Contributing

Suggestions and improvements are welcome, especially clearer explanations or new beginner-friendly examples.

1. Fork the repository.
2. Create a branch: `git checkout -b improve-explanations`
3. Make your changes and run the app to check everything still works.
4. Open a pull request describing what you changed and why.

If you find something confusing in this guide, opening an issue is just as helpful. If it confused you, it probably confuses others too.