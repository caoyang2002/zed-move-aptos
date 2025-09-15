module 0x42::example {

    struct Balance has key { value: u64 }

    public fun add_balance(s: &signer, value: u64) {
        move_to(s, Balance { value })
    }

    // public fun extract_balance(addr: address): u64 acquires Balance {
    //     let Balance { value } = move_from<Balance>(addr); // 需要 acquires 声明
    //     value
    // }
}
