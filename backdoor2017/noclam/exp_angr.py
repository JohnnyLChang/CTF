import angr
import claripy
import simuvex
import resource
import time

proj = angr.Project('challenge', load_options={'auto_load_libs': False})

fail = 0x004007CC
success = 0x004007B6

start = 0x004007E2
avoid = [fail]
end = [success]

argv = []
for i in xrange(31):
    arg = claripy.BVS("input_string" + str(i), 8)
    argv.append(arg)

state = proj.factory.entry_state(args=argv, remove_options={
                                 simuvex.o.LAZY_SOLVES, })

pg = proj.factory.path_group(state, veritesting=False)

start_time = time.time()
while len(pg.active) > 0:

    print pg

    pg.explore(avoid=avoid, find=end, n=1)

    if len(pg.found) > 0:
        print
        print "Reached the target"
        print pg
        state = pg.found[0].state

        flag = ""
        for a in argv:
            flag += state.se.any_str(a)[0]
        print "FLAG: " + flag
        break

print
print "Memory usage: " + str(resource.getrusage(resource.RUSAGE_SELF).ru_maxrss / 1024) + " MB"
print "Elapsed time: " + str(time.time() - start_time)
