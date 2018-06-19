


import struct
import numpy as np



def crypt_floats(float_array, key_array):
    key_len = len(key_array)
    
    assert key_len > 4, 'Key len (%s) < 4' % key_len
    assert key_array.dtype == np.uint32, 'key_array isn`t numpy uint32 array'
    
    for i in range(len(float_array)):
        f = float_array[i]
        bytes = struct.pack('<f', f) # 1 float32 -> 4 bytes
        ints  = struct.unpack('<I', bytes)[0] # 4 bytes -> 1 uint32
        key_idx = i % key_len
        ints ^= key_array[key_idx]
        bytes = struct.pack('<I', ints) #  1 uint32 -> 4 bytes
        float_array[i] = struct.unpack('<f', bytes)[0] # 4 bytes -> 1 float32


arr = np.array([0.0, 0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.25, 2.5, 2.75, 3.0, 3.25, 3.5, 3.75], dtype=np.float)
print('Source array: %s' % arr)
print('----------------------')

key = np.array([22, 111111, 0, 4444, 44, 443, 23232, 11, 44444], dtype=np.uint32)

crypt_floats(arr, key)
print('Encrypted: %s' % arr)
# Prints:  [3.08285662e-44 2.53311366e-01 5.00000000e-01 7.50264883e-01
#           1.00000525e+00 1.25005281e+00 1.50276947e+00 1.75000131e+00
#           2.01059628e+00 2.25000525e+00 2.52649093e+00 2.75000000e+00
#           3.00105953e+00 3.25001049e+00 3.50010562e+00 3.75553894e+00]
