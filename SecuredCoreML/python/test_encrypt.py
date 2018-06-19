


import struct
import numpy as np
import base64



def crypt_floats_from_key_array(float_array, key_array):
    key_len = len(key_array)
    
    assert key_len > 4, 'Key size in bits (%s) < %s bits' % (key_len*32, 4*32)
    assert key_array.dtype == np.uint32, 'key_array (dtype = %s) isn`t numpy uint32 array' % key_array.dtype
    
    for i in range(len(float_array)):
        f = float_array[i]
        bytes = struct.pack('<f', f) # 1 float32 -> 4 bytes
        ints  = struct.unpack('<I', bytes)[0] # 4 bytes -> 1 uint32
        key_idx = i % key_len
        ints ^= ~key_array[key_idx]
        bytes = struct.pack('<I', ints) #  1 uint32 -> 4 bytes
        float_array[i] = struct.unpack('<f', bytes)[0] # 4 bytes -> 1 float32

def crypt_floats(float_array, key_str):
    key_b64 = base64.b64encode(KEY)
    key_arr = np.fromstring(key_b64, dtype=np.uint32)
    print('key_arr: %s' % key_arr)
    crypt_floats_from_key_array(float_array, key_arr)


arr = np.array([0.0, 0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.25, 2.5, 2.75, 3.0, 3.25, 3.5, 3.75], dtype=np.float)
print('Source array: %s' % arr)
print('-----------------------')


KEY = "some key lll bla-bla-bla"


print('key: "%s"' % KEY)

crypt_floats(arr, KEY)

print('Encrypted: %s' % arr)
