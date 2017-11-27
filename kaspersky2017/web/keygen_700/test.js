var tdecode = require('text-encoding');

let bytes = new Uint8Array([72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33]);
var textDecoder = new tdecode.TextDecoder('utf-8');