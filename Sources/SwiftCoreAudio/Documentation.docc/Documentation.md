# ``SwiftCoreAudio``

macOS Core Audio wrapper written in Swift.

![swift-midi](swift-core-audio-banner.png)

 [Core Audio](https://developer.apple.com/documentation/CoreAudio) wrapper for macOS 10.15+ written in Swift with the goal of having:

- User-friendly, approachable API for both beginners and power-users
- All objects and types are value types, allowing implicit thread-safety and makes retain cycles virtually impossible
- Clean, lightweight Swift-native value types
- Data models to allow capturing Core Audio state for debugging or bug reporting
- Verbose documentation for objects, methods, types and errors

## Topics

### Objects

- ``AnyAudioDevice``
- ``AnyAudioObject``
- ``AudioAggregateDevice``
- ``AudioBooleanControl``
- ``AudioBox``
- ``AudioClock``
- ``AudioControl``
- ``AudioDevice``
- ``AudioEndPointDevice``
- ``AudioLevelControl``
- ``AudioPlugIn``
- ``AudioProcess``
- ``AudioSelectorControl``
- ``AudioStereoPanControl``
- ``AudioStream``
- ``AudioSubDevice``
- ``AudioSubTap``
- ``AudioSystem``
- ``AudioTap``
- ``AudioTransportManager``

### Protocols

- ``AudioAggregateDeviceProperties``
- ``AudioBoxProperties``
- ``AudioClockProperties``
- ``AudioDeviceProperties``
- ``AudioObject``
- ``AudioObjectProperties``
- ``AudioPlugInProperties``
- ``AudioProcessProperties``
- ``AudioStreamProperties``
- ``AudioSubDeviceProperties``
- ``AudioSubTapProperties``
- ``AudioSystemProperties``
- ``AudioTapProperties``
- ``AudioTransportManagerProperties``

### Types

- ``AudioFormat``
- ``AudioID``
- ``AudioObjectClassID``
- ``AudioObjectConcreteType``
- ``AudioObjectType``
- ``AudioUID``
- ``AudioChannelIndex``
- ``StereoAudioChannelIndexes``

### Errors

- ``AudioOSStatus``
- ``AudioOSStatusError``
- ``SwiftCoreAudioError``
- ``withRecovery(_:_:)``
- ``withRecovery(_:unknownPropertyDefault:)``

### Properties

- ``AudioProperty``
- ``AudioPropertyConstant``
- ``AudioPropertyQualifier``
- ``AudioPropertySelector``
- ``AudioPropertyValueTranslation``

### Properties - Selector

- ``AudioPropertySelectorConstant``
- ``AudioAggregateDevicePropertySelectorConstant``
- ``AudioBooleanControlPropertySelectorConstant``
- ``AudioBoxPropertySelectorConstant``
- ``AudioClockPropertySelectorConstant``
- ``AudioControlPropertySelectorConstant``
- ``AudioDevicePropertySelectorConstant``
- ``AudioEndPointDevicePropertySelectorConstant``
- ``AudioLevelControlPropertySelectorConstant``
- ``AudioObjectPropertySelectorConstant``
- ``AudioPlugInPropertySelectorConstant``
- ``AudioProcessPropertySelectorConstant``
- ``AudioSelectorControlPropertySelectorConstant``
- ``AudioStereoPanControlPropertySelectorConstant``
- ``AudioStreamPropertySelectorConstant``
- ``AudioSubDevicePropertySelectorConstant``
- ``AudioSubTapPropertySelectorConstant``
- ``AudioSystemPropertySelectorConstant``
- ``AudioTapPropertySelectorConstant``
- ``AudioTransportManagerPropertySelectorConstant``
- ``AudioWildcardPropertySelectorConstant``

### Properties - Scope

- ``AudioPropertyScopeConstant``
- ``AudioObjectPropertyScopeConstant``
- ``AudioWildcardPropertyScopeConstant``

### Properties - Element

- ``AudioPropertyElementConstant``
- ``AudioObjectPropertyElementConstant``
- ``AudioStreamPropertyElementConstant``
- ``AudioWildcardPropertyElementConstant``

### Properties - Listeners

- ``AudioObjectPropertyListenerRef``

### Snapshots

- ``AudioObjectSnapshot``

### Logging

- ``CoreAudioLogging``
