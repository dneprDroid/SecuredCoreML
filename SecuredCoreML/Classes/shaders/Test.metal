#include <metal_stdlib>
#include "Crypt.metal"
using namespace metal;




kernel void CMLSecure_test(
  texture2d<float, access::read>    inTexture [[texture(0)]],
  texture2d<float, access::write>   outTexture [[texture(1)]],
  texture2d<uint, access::read>     keyBytes [[texture(2)]],
  ushort3 gid [[thread_position_in_grid]])
{
    if (gid.x >= outTexture.get_width() || gid.y >= outTexture.get_height()) {
        return;
    }

    const float x(inTexture.read(gid.xy, gid.z)[0]);
    
    const float y = CMLSecure_crypt_value(x, keyBytes, gid);
    outTexture.write(y, gid.xy, gid.z);
}
