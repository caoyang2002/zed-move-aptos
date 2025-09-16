script {
  fun sum_conditional(n: u64): u64 {
    let sum = 0;
    for (iter in 0..n) {
      if (iter > 10) {
        break; // 当数字大于10时退出循环
      };
      if (iter % 3 == 0) {
        continue; // 当数字能被3整除时跳过当前迭代
      };

      sum = sum + iter;
    };

    sum
  }
}
