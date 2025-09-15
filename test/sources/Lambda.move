module 0x42::example {
    public fun fold<Accumulator, Element>(
        v: vector<Element>,
        init: Accumulator,
        f: |Accumulator, Element|Accumulator
    ): Accumulator {
        let accu = init;
        for_each(v, |elem| accu = f(accu, elem));
        accu
    }
}
