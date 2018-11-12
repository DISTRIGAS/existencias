It's a free dll to create QR codes.
I have created the prototypes to go with it.

This is what you have to do to make it work.


create a lib with libmaker of the dll, call it barcodelibrary.lib

then add this to your include section of you app


module('barcodelibrary.lib')
LibraryVersion(),*CSTRING,PASCAL,RAW
GenerateFile(*CSTRING, *CSTRING), PASCAL, RAW
end

create to global or local cstring to give the values back..
loc:data and loc:name cstrings 256 or something

loc:data = '?re=XAXX010101000&rr=XAXX010101000tt=1234567890.123456&id=ad662d33-6934-459c-a128-BDf0393f0f44'
loc:name = '.\qr.bmp'
GenerateFile(loc:data, loc:name)

you can be more especific on the location and name or combine variables etc, but it should work for you.

test the QR with a phone or something...

