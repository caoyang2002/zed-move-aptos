script {
  fun sum(n: u64): u64 {
    let sum = 0;
    let i = 1;
    while (i <= n) {
      sum = sum + i;
      i = i + 1
    };

    sum
  }
  fun smallest_factor(n: u64): u64 {
     // 假设输入不为 0 或 1
     let i = 2;
     while (i <= n) {
       if (n % i == 0) break;
       i = i + 1
     };

     i
   }
   fun sum_intermediate(n: u64): u64 {
      let sum = 0;
      let i = 0;
      while (i < n) {
        i = i + 1;
        if (i % 10 == 0) continue;
        sum = sum + i;
      };

      sum
    }
    fun pop_smallest_while_not_equal(
        v1: vector<u64>,
        v2: vector<u64>,
      ): vector<u64> {
        let result = vector::empty();
        while (!vector::is_empty(&v1) && !vector::is_empty(&v2)) {
          let u1 = *vector::borrow(&v1, vector::length(&v1) - 1);
          let u2 = *vector::borrow(&v2, vector::length(&v2) - 1);
          let popped =
            if (u1 < u2) vector::pop_back(&mut v1)
            else if (u2 < u1) vector::pop_back(&mut v2)
            else break; // 这里 `break` 的类型是 `u64`
          vector::push_back(&mut result, popped);
        };

        result
      }
}
