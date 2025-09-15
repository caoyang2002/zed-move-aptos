module 0x42::example {
    fun safe_sub(x: u64, y: u64): u64 {
        if (y > x) return 0;
        x - y
    }
}
