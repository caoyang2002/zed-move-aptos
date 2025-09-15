script {
    use std::vector;
    use std::vector;
    fun pop_twice<T>(v: &mut vector<T>): (T, T) {
        assert!(vector::length(v) >= 2, 42); // 现在使用 'assert'

        (vector::pop_back(v), vector::pop_back(v))
    }

    fun check_vec(v: &vector<u64>, bound: u64) {
        let i = 0;
        let n = vector::length(v);
        while (i < n) {
            let cur = *vector::borrow(v, i);
            if (cur > bound) abort 42;
            i = i + 1;
        }
    }
}
