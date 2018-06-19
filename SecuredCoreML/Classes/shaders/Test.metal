#include <metal_stdlib>
using namespace metal;


typedef union {
    float value; // 4 bytes
    uint  bytes; // 4 bytes
} float_bytes;


inline float crypt_float(const float in,
                         const texture2d<uint, access::read> keyBytes [[texture(2)]],
                         const ushort textureWidth,
                         const ushort3 gid [[thread_position_in_grid]])
{
    const uint inPosition = gid.x + gid.y * textureWidth;
    
    const ushort keySize = keyBytes.get_height() * keyBytes.get_width();
    const ushort keyPos = inPosition % keySize;
    
    const ushort2 keyPosVec(keyPos % keyBytes.get_width(), keyPos / keyBytes.get_width());
    
    const int keyPart(keyBytes.read(keyPosVec)[0]);
    
    float_bytes fb_in;
    float_bytes fb_out;
    fb_in.value = in;

    fb_out.bytes = fb_in.bytes ^ keyPart;
    const float out = fb_out.value;
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
    
    const float y = crypt_float(x, keyBytes, outTexture.get_width(), gid);
    outTexture.write(y, gid.xy, gid.z);
}
