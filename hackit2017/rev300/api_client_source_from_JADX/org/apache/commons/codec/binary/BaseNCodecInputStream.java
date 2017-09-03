package org.apache.commons.codec.binary;

import java.io.FilterInputStream;
import java.io.IOException;
import java.io.InputStream;

public class BaseNCodecInputStream extends FilterInputStream {
    private final BaseNCodec baseNCodec;
    private final boolean doEncode;
    private final byte[] singleByte = new byte[1];

    protected BaseNCodecInputStream(InputStream in, BaseNCodec baseNCodec, boolean doEncode) {
        super(in);
        this.doEncode = doEncode;
        this.baseNCodec = baseNCodec;
    }

    public int read() throws IOException {
        int r = read(this.singleByte, 0, 1);
        while (r == 0) {
            r = read(this.singleByte, 0, 1);
        }
        if (r > 0) {
            return this.singleByte[0] < (byte) 0 ? this.singleByte[0] + 256 : this.singleByte[0];
        } else {
            return -1;
        }
    }

    public int read(byte[] b, int offset, int len) throws IOException {
        if (b == null) {
            throw new NullPointerException();
        } else if (offset < 0 || len < 0) {
            throw new IndexOutOfBoundsException();
        } else if (offset > b.length || offset + len > b.length) {
            throw new IndexOutOfBoundsException();
        } else if (len == 0) {
            return 0;
        } else {
            int readLen = 0;
            while (readLen == 0) {
                if (!this.baseNCodec.hasData()) {
                    byte[] buf = new byte[(this.doEncode ? 4096 : 8192)];
                    int c = this.in.read(buf);
                    if (this.doEncode) {
                        this.baseNCodec.encode(buf, 0, c);
                    } else {
                        this.baseNCodec.decode(buf, 0, c);
                    }
                }
                readLen = this.baseNCodec.readResults(b, offset, len);
            }
            return readLen;
        }
    }

    public boolean markSupported() {
        return false;
    }
}
