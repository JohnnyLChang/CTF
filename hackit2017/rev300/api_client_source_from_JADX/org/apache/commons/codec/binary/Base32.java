package org.apache.commons.codec.binary;

public class Base32 extends BaseNCodec {
    private static final int BITS_PER_ENCODED_BYTE = 5;
    private static final int BYTES_PER_ENCODED_BLOCK = 8;
    private static final int BYTES_PER_UNENCODED_BLOCK = 5;
    private static final byte[] CHUNK_SEPARATOR = new byte[]{(byte) 13, (byte) 10};
    private static final byte[] DECODE_TABLE = new byte[]{(byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) 63, (byte) -1, (byte) -1, (byte) 26, (byte) 27, (byte) 28, (byte) 29, (byte) 30, (byte) 31, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) 0, (byte) 1, (byte) 2, (byte) 3, (byte) 4, (byte) 5, (byte) 6, (byte) 7, (byte) 8, (byte) 9, (byte) 10, (byte) 11, (byte) 12, (byte) 13, (byte) 14, (byte) 15, (byte) 16, (byte) 17, (byte) 18, (byte) 19, (byte) 20, (byte) 21, (byte) 22, (byte) 23, (byte) 24, (byte) 25};
    private static final byte[] ENCODE_TABLE = new byte[]{(byte) 65, (byte) 66, (byte) 67, (byte) 68, (byte) 69, (byte) 70, (byte) 71, (byte) 72, (byte) 73, (byte) 74, (byte) 75, (byte) 76, (byte) 77, (byte) 78, (byte) 79, (byte) 80, (byte) 81, (byte) 82, (byte) 83, (byte) 84, (byte) 85, (byte) 86, (byte) 87, (byte) 88, (byte) 89, (byte) 90, (byte) 50, (byte) 51, (byte) 52, (byte) 53, (byte) 54, (byte) 55};
    private static final byte[] HEX_DECODE_TABLE = new byte[]{(byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) 63, (byte) 0, (byte) 1, (byte) 2, (byte) 3, (byte) 4, (byte) 5, (byte) 6, (byte) 7, (byte) 8, (byte) 9, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) 10, (byte) 11, (byte) 12, (byte) 13, (byte) 14, (byte) 15, (byte) 16, (byte) 17, (byte) 18, (byte) 19, (byte) 20, (byte) 21, (byte) 22, (byte) 23, (byte) 24, (byte) 25, (byte) 26, (byte) 27, (byte) 28, (byte) 29, (byte) 30, (byte) 31, (byte) 32};
    private static final byte[] HEX_ENCODE_TABLE = new byte[]{(byte) 48, (byte) 49, (byte) 50, (byte) 51, (byte) 52, (byte) 53, (byte) 54, (byte) 55, (byte) 56, (byte) 57, (byte) 65, (byte) 66, (byte) 67, (byte) 68, (byte) 69, (byte) 70, (byte) 71, (byte) 72, (byte) 73, (byte) 74, (byte) 75, (byte) 76, (byte) 77, (byte) 78, (byte) 79, (byte) 80, (byte) 81, (byte) 82, (byte) 83, (byte) 84, (byte) 85, (byte) 86};
    private static final int MASK_5BITS = 31;
    private long bitWorkArea;
    private final int decodeSize;
    private final byte[] decodeTable;
    private final int encodeSize;
    private final byte[] encodeTable;
    private final byte[] lineSeparator;

    public Base32() {
        this(false);
    }

    public Base32(boolean useHex) {
        this(0, null, useHex);
    }

    public Base32(int lineLength) {
        this(lineLength, CHUNK_SEPARATOR);
    }

    public Base32(int lineLength, byte[] lineSeparator) {
        this(lineLength, lineSeparator, false);
    }

    public Base32(int lineLength, byte[] lineSeparator, boolean useHex) {
        super(5, 8, lineLength, lineSeparator == null ? 0 : lineSeparator.length);
        if (useHex) {
            this.encodeTable = HEX_ENCODE_TABLE;
            this.decodeTable = HEX_DECODE_TABLE;
        } else {
            this.encodeTable = ENCODE_TABLE;
            this.decodeTable = DECODE_TABLE;
        }
        if (lineLength <= 0) {
            this.encodeSize = 8;
            this.lineSeparator = null;
        } else if (lineSeparator == null) {
            throw new IllegalArgumentException(new StringBuffer().append("lineLength ").append(lineLength).append(" > 0, but lineSeparator is null").toString());
        } else if (containsAlphabetOrPad(lineSeparator)) {
            throw new IllegalArgumentException(new StringBuffer().append("lineSeparator must not contain Base32 characters: [").append(StringUtils.newStringUtf8(lineSeparator)).append("]").toString());
        } else {
            this.encodeSize = lineSeparator.length + 8;
            this.lineSeparator = new byte[lineSeparator.length];
            System.arraycopy(lineSeparator, 0, this.lineSeparator, 0, lineSeparator.length);
        }
        this.decodeSize = this.encodeSize - 1;
    }

    void decode(byte[] in, int inPos, int inAvail) {
        if (!this.eof) {
            byte[] bArr;
            int i;
            if (inAvail < 0) {
                this.eof = true;
            }
            int i2 = 0;
            int inPos2 = inPos;
            while (i2 < inAvail) {
                inPos = inPos2 + 1;
                byte b = in[inPos2];
                if (b == (byte) 61) {
                    this.eof = true;
                    break;
                }
                ensureBufferSize(this.decodeSize);
                if (b >= (byte) 0 && b < this.decodeTable.length) {
                    int result = this.decodeTable[b];
                    if (result >= 0) {
                        this.modulus = (this.modulus + 1) % 8;
                        this.bitWorkArea = (this.bitWorkArea << 5) + ((long) result);
                        if (this.modulus == 0) {
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) ((int) ((this.bitWorkArea >> 32) & 255));
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) ((int) ((this.bitWorkArea >> 24) & 255));
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) ((int) ((this.bitWorkArea >> 16) & 255));
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) ((int) ((this.bitWorkArea >> 8) & 255));
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) ((int) (this.bitWorkArea & 255));
                        }
                    }
                }
                i2++;
                inPos2 = inPos;
            }
            if (this.eof && this.modulus >= 2) {
                ensureBufferSize(this.decodeSize);
                switch (this.modulus) {
                    case 2:
                        bArr = this.buffer;
                        i = this.pos;
                        this.pos = i + 1;
                        bArr[i] = (byte) ((int) ((this.bitWorkArea >> 2) & 255));
                        return;
                    case 3:
                        bArr = this.buffer;
                        i = this.pos;
                        this.pos = i + 1;
                        bArr[i] = (byte) ((int) ((this.bitWorkArea >> 7) & 255));
                        return;
                    case 4:
                        this.bitWorkArea >>= 4;
                        bArr = this.buffer;
                        i = this.pos;
                        this.pos = i + 1;
                        bArr[i] = (byte) ((int) ((this.bitWorkArea >> 8) & 255));
                        bArr = this.buffer;
                        i = this.pos;
                        this.pos = i + 1;
                        bArr[i] = (byte) ((int) (this.bitWorkArea & 255));
                        return;
                    case 5:
                        this.bitWorkArea >>= 1;
                        bArr = this.buffer;
                        i = this.pos;
                        this.pos = i + 1;
                        bArr[i] = (byte) ((int) ((this.bitWorkArea >> 16) & 255));
                        bArr = this.buffer;
                        i = this.pos;
                        this.pos = i + 1;
                        bArr[i] = (byte) ((int) ((this.bitWorkArea >> 8) & 255));
                        bArr = this.buffer;
                        i = this.pos;
                        this.pos = i + 1;
                        bArr[i] = (byte) ((int) (this.bitWorkArea & 255));
                        return;
                    case 6:
                        this.bitWorkArea >>= 6;
                        bArr = this.buffer;
                        i = this.pos;
                        this.pos = i + 1;
                        bArr[i] = (byte) ((int) ((this.bitWorkArea >> 16) & 255));
                        bArr = this.buffer;
                        i = this.pos;
                        this.pos = i + 1;
                        bArr[i] = (byte) ((int) ((this.bitWorkArea >> 8) & 255));
                        bArr = this.buffer;
                        i = this.pos;
                        this.pos = i + 1;
                        bArr[i] = (byte) ((int) (this.bitWorkArea & 255));
                        return;
                    case 7:
                        this.bitWorkArea >>= 3;
                        bArr = this.buffer;
                        i = this.pos;
                        this.pos = i + 1;
                        bArr[i] = (byte) ((int) ((this.bitWorkArea >> 24) & 255));
                        bArr = this.buffer;
                        i = this.pos;
                        this.pos = i + 1;
                        bArr[i] = (byte) ((int) ((this.bitWorkArea >> 16) & 255));
                        bArr = this.buffer;
                        i = this.pos;
                        this.pos = i + 1;
                        bArr[i] = (byte) ((int) ((this.bitWorkArea >> 8) & 255));
                        bArr = this.buffer;
                        i = this.pos;
                        this.pos = i + 1;
                        bArr[i] = (byte) ((int) (this.bitWorkArea & 255));
                        return;
                    default:
                        return;
                }
            }
        }
    }

    void encode(byte[] in, int inPos, int inAvail) {
        if (!this.eof) {
            byte[] bArr;
            int i;
            if (inAvail < 0) {
                this.eof = true;
                if (this.modulus != 0 || this.lineLength != 0) {
                    ensureBufferSize(this.encodeSize);
                    int savedPos = this.pos;
                    switch (this.modulus) {
                        case 1:
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 3)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea << 2)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) 61;
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) 61;
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) 61;
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) 61;
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) 61;
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) 61;
                            break;
                        case 2:
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 11)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 6)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 1)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea << 4)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) 61;
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) 61;
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) 61;
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) 61;
                            break;
                        case 3:
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 19)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 14)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 9)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 4)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea << 1)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) 61;
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) 61;
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) 61;
                            break;
                        case 4:
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 27)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 22)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 17)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 12)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 7)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 2)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = this.encodeTable[((int) (this.bitWorkArea << 3)) & 31];
                            bArr = this.buffer;
                            i = this.pos;
                            this.pos = i + 1;
                            bArr[i] = (byte) 61;
                            break;
                    }
                    this.currentLinePos += this.pos - savedPos;
                    if (this.lineLength > 0 && this.currentLinePos > 0) {
                        System.arraycopy(this.lineSeparator, 0, this.buffer, this.pos, this.lineSeparator.length);
                        this.pos += this.lineSeparator.length;
                        return;
                    }
                    return;
                }
                return;
            }
            int i2 = 0;
            int inPos2 = inPos;
            while (i2 < inAvail) {
                ensureBufferSize(this.encodeSize);
                this.modulus = (this.modulus + 1) % 5;
                inPos = inPos2 + 1;
                int b = in[inPos2];
                if (b < 0) {
                    b += 256;
                }
                this.bitWorkArea = (this.bitWorkArea << 8) + ((long) b);
                if (this.modulus == 0) {
                    bArr = this.buffer;
                    i = this.pos;
                    this.pos = i + 1;
                    bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 35)) & 31];
                    bArr = this.buffer;
                    i = this.pos;
                    this.pos = i + 1;
                    bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 30)) & 31];
                    bArr = this.buffer;
                    i = this.pos;
                    this.pos = i + 1;
                    bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 25)) & 31];
                    bArr = this.buffer;
                    i = this.pos;
                    this.pos = i + 1;
                    bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 20)) & 31];
                    bArr = this.buffer;
                    i = this.pos;
                    this.pos = i + 1;
                    bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 15)) & 31];
                    bArr = this.buffer;
                    i = this.pos;
                    this.pos = i + 1;
                    bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 10)) & 31];
                    bArr = this.buffer;
                    i = this.pos;
                    this.pos = i + 1;
                    bArr[i] = this.encodeTable[((int) (this.bitWorkArea >> 5)) & 31];
                    bArr = this.buffer;
                    i = this.pos;
                    this.pos = i + 1;
                    bArr[i] = this.encodeTable[((int) this.bitWorkArea) & 31];
                    this.currentLinePos += 8;
                    if (this.lineLength > 0 && this.lineLength <= this.currentLinePos) {
                        System.arraycopy(this.lineSeparator, 0, this.buffer, this.pos, this.lineSeparator.length);
                        this.pos += this.lineSeparator.length;
                        this.currentLinePos = 0;
                    }
                }
                i2++;
                inPos2 = inPos;
            }
            inPos = inPos2;
        }
    }

    public boolean isInAlphabet(byte octet) {
        return octet >= (byte) 0 && octet < this.decodeTable.length && this.decodeTable[octet] != (byte) -1;
    }
}
