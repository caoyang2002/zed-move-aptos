address{
    module AddressKey {
        use 0x1::Debug;

        public fun main() {
            Debug::print(&"Hello, Move!");
        }
    }
}
