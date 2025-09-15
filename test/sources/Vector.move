script {
    use std::vector;
    fun example() {
        let v = vector::empty<u64>();
        vector::push_back(&mut v, 5);
        vector::push_back(&mut v, 6);
        assert!(*vector::borrow(&v, 0) == 5, 42);
        assert!(*vector::borrow(&v, 1) == 6, 42);
        assert!(vector::pop_back(&mut v) == 6, 42);
        assert!(vector::pop_back(&mut v) == 5, 42);
    }

    fun example() {
        (vector[]: vector<bool>);
        (vector[0u8, 1u8, 2u8]: vector<u8>);
        (vector<u128>[]: vector<u128>);
        (vector<address>[@0x42, @0x100]: vector<address>);
    }

    fun byte_and_hex_strings() {
        assert!(b"" == x"", 0);
        assert!(b"Hello!\n" == x"48656C6C6F210A", 1);
        assert!(b"\x48\x65\x6C\x6C\x6F\x21\x0A" == x"48656C6C6F210A", 2);
        assert!(
            b"\"Hello\tworld!\"\n \r \\Null=\0" ==
                x"2248656C6C6F09776F726C6421220A200D205C4E756C6C3D00",
            3
        );
    }
}
