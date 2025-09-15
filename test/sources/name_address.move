module example_addr::example {
    struct Example has copy, drop { a: address }

    use std::debug;
    friend example_addr::another_example;

    public fun print() {
        let example = Example { a: @example_addr };
        debug::print(&example)
    }
}
