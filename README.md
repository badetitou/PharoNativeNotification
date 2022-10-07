# PharoNativeNotification

I connect Pharo with the native notification system of the OS

> Only windows supported for now

## Installation 

```st
Metacello new
  githubUser: 'badetitou' project: 'PharoNativeNotification' commitish: 'main' path: 'src';
  baseline: 'NativeNotification';
  load
```

## Example

```st
self nativeInform: 'Hello' withText: 'world'
```
