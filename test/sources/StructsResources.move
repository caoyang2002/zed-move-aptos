module 0x2::m {
    struct Foo { x: u64, y: bool }
    struct Bar {}
    struct Baz { foo: Foo }
    //                   ^ 注意：允许末尾有逗号
}
