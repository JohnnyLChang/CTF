# cafebabedeadbeef0001020304050607
# https://github.com/ikizhvatov/jlsca-tutorials/blob/master/rhme2-escalate.ipynb

using Jlsca.Sca
using Jlsca.Trs
using Jlsca.Align
using Jlsca.Aes
using PyCall
using PyPlot.plot,PyPlot.figure

@pyimport numpy

trs = InspectorTrace(ARGS[1])

#((data,samples),eof) = readTraces(trs, 1:10);
#plot(samples[1:10,:]',linewidth=.3);



maxShift = 1000
referencestart = 3000
referenceend = 5000
reference = trs[3][2][referencestart:referenceend]
corvalMin = 0.6
alignstate = CorrelationAlignFFT(reference, referencestart, maxShift)
addSamplePass(trs, x -> ((shift,corval) = correlationAlign(x, alignstate); corval > corvalMin ? circshift(x, shift) : Vector{eltype(x)}(0)))

((data,samples),eof) = readTraces(trs, 1:100)
plot(samples[:,:]', linewidth=.3);

params = AesSboxAttack()
params.analysis = IncrementalCPA()
params.analysis.leakages = [HW()]
numberOfTraces = length(trs);

setPostProcessor(trs, IncrementalCorrelation())
key = sca(trs, params, 1, numberOfTraces)

w = KeyExpansion(key, 10, 4)
if (Cipher(trs[1][1][1:16], w) == trs[1][1][17:32])
  println("Success!")
end
