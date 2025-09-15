script {
  fun sum_intermediate(n: u64): u64 {
    let sum = 0;
    let i = 0;
    loop {
      i = i + 1;
      if (i % 10 == 0) continue;
      if (i > n) break;
      sum = sum + i
    };
    sum
  }
  fun example() {
      (loop { if (i < 10) i = i + 1 else break }: ());
      let () = loop { if (i < 10) i = i + 1 else break };
    }
    fun example(x: u64): u64 {
       'label1: while (x > 10) {
         loop {
           if (x % 2 == 0) {
             x -= 1;
             continue 'label1;
           } else if (x < 10) {
             break 'label1
           } else
             x -= 2
         }
       };
       x
     }
}
