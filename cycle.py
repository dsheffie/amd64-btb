#!/usr/bin/env python3
import random
import sys

if __name__ == "__main__":
    n = 2**int(sys.argv[1])
    v = [x for x in range(0, n)]
    random.shuffle(v)
    arr = []
    for i in range(0,n):
        cc = v[i]
        nn = v[(i+1)%n]
        arr.append((cc,nn))
    arr.sort()
        
    with open('cycle_' + str(n) + '.s', 'w') as out:
        func = 'goto_test' + str(n)
        out.write('.text\n.align 2\n')
        out.write('.globl '+func+'\n')
        out.write('.type '+func+', @function\n')
        out.write(func + ':\n')
        for i in range(0,n):
            x = arr[i]
            label ='.L' + str(x[0])
            nlabel = '.L' + str(x[1])
            out.write('%s:\n' % label)
            if(i != (n-1)):
                out.write('jmp %s\n\n' % nlabel)
            else:
                out.write('decq %rdi\n\n')                
                out.write('jne %s\n' % nlabel)

        out.write('mov $' + str(n)+', %rax\n')
        out.write('.done:\nretq\n')


