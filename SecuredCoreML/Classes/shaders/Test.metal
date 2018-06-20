#include <metal_stdlib>
using namespace metal;


// Note: sizeof(FloatType) = sizeof(FloatType)
template <typename FloatType, typename IntType>
union FBytes
{
    FloatType value;
    IntType bytes;
};

// typedef bytes<float, uint> float_bytes;
// typedef bytes<half, ushort> half_bytes;


/*
 
 * Note: sizeof(FloatType) = sizeof(IntType)
 * keyBytes shape is (KEY_LEN, 1) : keyBytes.get_width() == KEY_LEN, keyBytes.get_height() == 1
 
 */
template <typename FloatType, typename IntType>
inline FloatType CMLSecure_crypt_value(const FloatType in,
                                       const texture2d<IntType, access::read> keyBytes [[texture(2)]],
                                       const ushort textureWidth,
                                       const ushort3 gid [[thread_position_in_grid]])
{
    const ushort keyW = keyBytes.get_width();

    const ushort keySize = keyW;
    const ushort keyPos = gid.x % keySize;
    
    const ushort2 keyPosVec(keyPos % keyW);
    
    const int keyPart = keyBytes.read(keyPosVec)[0];
    
    FBytes<FloatType, IntType> fb;
    fb.value = in;

    fb.bytes ^= ~keyPart;
    const float out = fb.value;
    return out;
}



kernel void test(
  texture2d<float, access::read>    inTexture [[texture(0)]],
  texture2d<float, access::write>   outTexture [[texture(1)]],
  texture2d<uint, access::read>     keyBytes [[texture(2)]],
  ushort3 gid [[thread_position_in_grid]])
{
    if (gid.x >= outTexture.get_width() || gid.y >= outTexture.get_height()) {
        return;
    }

    const float x(inTexture.read(gid.xy, gid.z)[0]);
    
    const float y = CMLSecure_crypt_value(x, keyBytes, outTexture.get_width(), gid);
    outTexture.write(y, gid.xy, gid.z);
}
