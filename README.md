# SecuredCoreML

[![CI Status](https://img.shields.io/travis/alex.ovechko@yahoo.com/SecuredCoreML.svg?style=flat)](https://travis-ci.org/alex.ovechko@yahoo.com/SecuredCoreML)
[![Version](https://img.shields.io/cocoapods/v/SecuredCoreML.svg?style=flat)](https://cocoapods.org/pods/SecuredCoreML)
[![License](https://img.shields.io/cocoapods/l/SecuredCoreML.svg?style=flat)](https://cocoapods.org/pods/SecuredCoreML)
[![Platform](https://img.shields.io/cocoapods/p/SecuredCoreML.svg?style=flat)](https://cocoapods.org/pods/SecuredCoreML)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SecuredCoreML is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SecuredCoreML'
```

## Test

iOS app (see shader - [Crypt.metal](https://github.com/dneprDroid/SecuredCoreML/blob/master/SecuredCoreML/Classes/shaders/Crypt.metal)):

```swift

let encrypted:[Float32] = [-6.06177128e-23,  -3.68551082e-05,  -4.19440828e-12,  -1.43397043e-18,
                           -5.00144107e-19,  -6.08564325e-19,  -4.46225449e+31,  -1.36937288e+34,
                           -2.06271388e+16,  -1.77384355e+04,  -1.54256002e+12,  -5.89491230e+18,
                           -7.62428741e+18,  -7.04782665e+18,  -6.65616506e-32,  -2.78038439e-34]

let key = "some key lll bla-bla-bla12345678"
let expected:[Float32] = [0.0, 0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75,
                          2.0, 2.25, 2.5, 2.75, 3.0, 3.25, 3.5, 3.75]
MetalCryptoTest.testDecryption(encrypted: encrypted,
                               key: key,
                               expectedDecrypted:  expected,
                               failCallback: /* Your Callback */)

```

Python script (see [test_encrypt.py](https://github.com/dneprDroid/SecuredCoreML/blob/master/SecuredCoreML/python/test_encrypt.py)):

```python 

  arr = np.array([0.0, 0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.25, 2.5, 2.75, 3.0, 3.25, 3.5, 3.75], dtype=np.float)
  print('Source array: %s' % arr)
  print('-----------------------')


  KEY = "some key lll bla-bla-bla12345678"


  print('key: "%s"' % KEY)

  crypt_floats(arr, KEY)

  print('Encrypted: %s' % str(arr).replace(' ', ',  '))
```

## Author

Alex Ovechko

## License

SecuredCoreML is available under the MIT license. See the LICENSE file for more info.
