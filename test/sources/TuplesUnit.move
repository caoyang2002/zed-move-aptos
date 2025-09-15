module 0x42::example {
  fun returns_unit() {}
  fun returns_2_values(): (bool, bool) { (true, false) }
  fun returns_4_values(x: &u64): (&u64, u8, u128, vector<u8>) { (x, 0, 1, b"foobar") }

  fun examples(cond: bool) {
    let () = ();
    let (x, y): (u8, u64) = (0, 1);
    let (a, b, c, d) = (@0x0, 0, false, b"");

    () = ();
    (x, y) = if (cond) (1, 2) else (3, 4);
    (a, b, c, d) = (@0x1, 1, true, b"1");
  }

  fun examples_with_function_calls() {
    let () = returns_unit();
    let (x, y): (bool, bool) = returns_2_values();
    let (a, b, c, d) = returns_4_values(&0);

    () = returns_unit();
    (x, y) = returns_2_values();
    (a, b, c, d) = returns_4_values(&1);
  }
}
