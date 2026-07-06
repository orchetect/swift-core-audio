# ``SwiftCoreAudio/AudioObjectSnapshot``

A snapshot of Core Audio audio object's state which can be serialized and opened in the bundled CoreAudio Explorer app.

## UT Type

Note that if your application imports or exports `.coreaudiosnapshot` files and/or uses `AudioObjectSnapshot`'s `Transferable` implementation, you are required to add the UT type to your application's `Info.plist` file otherwise file dialog interactions and other operations may fail.

![Imported UT Type](coreaudiosnapshot-type-identifier.png)
