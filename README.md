# OSC-SoundClound-API
Objectice-C Wrapper of the official SoundCloud HTTP API

**OSCSoundCloud** is a replacement for the cancelled official SoundCloud SDK. It contains a number of classes which can be used to interact with the SoundCloud API.

## Getting Started ##
Before OSCSoundCloud, you must intitialize it in your AppDelegate.m application:didFInishLaunchingwithOptions: method:

```smalltalk
// Initialize OSCManager for SoundCloud API
[[OSCManager sharedManager] setAPI_KEY:@"<YOUR SOUNDCLOUD API CLIENT-KEY HERE>"];
```

Thats it! You can now start making calls to the SoundCloud API with OSCSoundCloud.
