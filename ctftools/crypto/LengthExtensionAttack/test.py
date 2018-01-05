
functions = [lambda b, c, d: (b & c) | (~b & d)] + \
            [lambda b, c, d: (d & b) | (~d & c)] + \
            [lambda b, c, d: b ^ c ^ d] + \
            [lambda b, c, d: c ^ (b | ~d)]
indexs = [lambda i: i] + \
         [lambda i: (5*i + 1)%16] + \
         [lambda i: (3*i + 5)%16] + \
         [lambda i: (7*i)%16]

