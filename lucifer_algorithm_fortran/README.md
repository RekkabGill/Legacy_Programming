LUCIFER - A CRYPTOGRAPHIC ALGORITHM 
====================================

Sorkin, A., "Lucifer, A Cryptographic Algorithm", Cryptologia, 8(1), pp.22.41 (1984).

LLUCIFER was designed by IBM and was an iterative block cipher which used Feistel rounds. This means LUCIFER scrambled a block of data
by performing an encipherment step on the block several times. The step used involved taking the key for that step and half of the block to 
calculate an output which was then applied by exclusive-OR to the other half of the block. The halves of the block were then swapped allowing
both halves of the block to be modified an equal number of times. 
