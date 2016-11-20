<a href="https://code.dlang.org/packages/poison" title="Go to poison">
    <img src="https://img.shields.io/dub/v/poison.svg" alt="Dub version">
</a>

# Poison - The high performance cross-platform desktop/mobile UI engine
Poison is a high performance cross-platform desktop/mobile UI engine written in D using dsfml.
It's based on the idea of having a UI library that is compatible with games and multithreaded applications.

Generally it's hard to write UI's for games or handle UI's with highly multithreaded applications, but the core
of Poison manages that very well.

## Why another UI engine?
Poison was born, because right now there isn't any really nice choice to render UI's in D when it comes to game development. There are plenty UI libraries, but most are for native rendering and not through libraries such as sfml, which makes it really hard to implement UI's with those for ex. games written in dsfml.

## Why not extend existing libraries to support dsfml then?
Poison is being used in a game project and by having developed the UI engine ourselves, we have full control of how the rendering goes, meaning we could optimize it how we wanted and have it fit to our games need. It also had us apply a sense of multithreading/concurrency pattern from the very beginning as it would be hard to apply that to an existing library without breaking changes. At the end of the day, writing a new library/engine was just much easier.

## How do I use Poison on mobile platforms such as Android or iOS?
At the moment mobile support hasn't been made, but as soon as desktop makes its first stable-round then it's all about making Poison compile to mobile platforms, create stylesheets and it should be done, since the engine should work on all platforms without major modification.

## Styling
Styling components with Poison has been made easy with a json-like/css-like syntax and properties.

The syntax is simple.

First you put a selector. There are 3 types of selectors.

* Class selectors - Generally there exist a class for every component. (A selector without prefix)
* Identifier selectors (A selector with # as prefix)
* State selectors - Must be combined with one of the two selectors above. Used to style depending on states ex. when a component is enabled or disabled. (A suffix to a selector like "selector:state")

Secondly you create a scope of properties that has values. Values may either be a string or an array of strings.
The strings should consist of either groups of values or a single group with values.

A group separates its values with ";" and groups are separated with "|"

### Examples
Syntax Example:
```
"selector" {
	"property": "value",
	"property2": "value"
},
"selector2" {
	"property": "value"
}
```

Example for styling a window.
```
"window": {
  "background-color": "238;238;238"
},
"window:disabled": {
  "background-color": "255;0;0"
}
```

### Styling Properties (";" is a value separator :: "|" is a group separator)

* background
  * value: "color: value|image: value"
* background-color (Done)
  * value: "R;G;B;A"
  * value: "R;G;B"
  * value: "#hex"
  * value: "colorName"
* background-image
  * value: "path"
  * value: "base64:base64_here"
* foreground-color (Done)
  * value: "R;G;B;A"
  * value: "R;G;B"
  * value: "#hex"
  * value: "colorName"
* font
  * value: "name: value|path: value|size: value"
* font-name
  * value: "name"
* font-path
  * value: "path"
* font-size
  * value: "size"
* paint (Array of values)
  * value: "position: value|size: value|color: value|gradient-hoz: value (Only fromColor & toColor)|gradient-ver: value (Only fromColor & toColor)"
* paint-color (Array of values)
  * value: "position: value|size: value|color: value"
* paint-gradient-hoz / paint-gradient-ver (Array of values)
  * value: "position: value|size: value|fromColor: value|toColor: value"
* border / border-top / border-right / border-bottom / border-left
  * value: "size;color"
  * value: "style:size;color" (Style can be normal or round)
* size
  * value: "width;height" (values can be set to "auto" which means it will be set elsewhere"
* margin
  * value: "top;right;bottom;left"
* padding
  * value: "top;right;bottom;left"
* position
  * value: "x;y"
* layout
  * value: "layout" (Can be fit, horizontal, vertical)
* dock
  * value: "dockedPosition" (Can be fill, top, right, bottom, left, centerX, centerY, center)

## How do I use poison?
There will be posted a few guides in the wiki soon, but for now keep an eye open as it's still in its early alpha-phase. Which means nothing is stable as it is and components are still being made.

A lot of stuff can change until we reach our first revision.

## How do I contribute?
Keep your eyes open for updates, there'll soon be a contribution guide. As for now you can fork the project and simple create pull requests with whatever contributions you have. We're not so strict as it is right now.

Project management, issue tracking and guides:

https://tree.taiga.io/project/poisonengine-poison-ui/

## Widgets/Components

### Misc (poison.ui.controls)

* PictureBox (Done)
* Label
* Button
* SplitButton
* Spacer
* Mask
* Group
* ScrollBar
* ToolBar
* TitleBar
* ProgressBar
* Splitter
* Strip
* Clock
* MessageBox

### Panels (poison.ui.panels)

* Panel
* FormPanel (Alias to poison.ui.forms.formpanel.FormPanel)
* TabPanel
* NavigationPanel
* TreePanel
* WizardPanel

### Sheets (poison.ui.sheets)

* Sheet
* ActionSheet
* PushMenu (Alias to poison.ui.menus.pushmenu.PushMenu)

### Pickers (poison.ui.pickers)

* Picker
* DateTimePicker
* ColorPicker
* SelectPicker

### Forms (poison.ui.forms)

* FormPanel
* Fieldset

### Fields (poison.ui.fields)

* Field
* TextField
* CheckBoxField
* RadioField
* ToggleField
* SelectField
* NumberField
* FileField
* SearchField
* SliderField
* SpinnerField
* EmailField

### DataViews (poison.ui.dataviews)

* DataView
* List
* NestedList
* Grid (Alias to poison.ui.grids.grid.Grid)

### Grids (poison.ui.grids)

* Grid
* ArrayGrid
* GroupedGrid
* LockedGrid

### Menus (poison.ui.menu)

* ContextMenu
* PushMenu
* ToolMenu
