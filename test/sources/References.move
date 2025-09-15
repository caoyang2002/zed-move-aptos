script {
  fun example() {
    let s = S { f: 10 };
    let f_ref1: &u64 = &s.f;
    let s_ref: &S = &s;
    let f_ref2: &u64 = &s_ref.f;
    let x = 7;
    let y: &u64 = &mut x;
  }
}
