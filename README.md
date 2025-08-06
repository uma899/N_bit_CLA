# N_bit_CLA

## Under Development

This is intended to work perfectly as a pipelined carry lookahead adder (CLA) where switching of inputs can be as fast as propagationj delay of gates (it is assumed propagation delay of any operation is fixed)

Currently, this works only if input change is more than 4 clock cycles. At 5th clockcycle, after application of input, correct output can be obtained. No use of pipeline!
