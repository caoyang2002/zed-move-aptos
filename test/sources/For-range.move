module demo::test {
    fun range_sum(n: u64): u64 {
        let sum = 0;
        for (i in 0..n) {
            sum = sum + i
            };
        sum
    }
}
