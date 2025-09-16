address 0x42 {
  module m {
      entry fun foo() {} // 有效！entry 函数不必是公开的
  }

  module n {
      fun calls_m_foo() {
          0x42::m::foo(); // 错误！
          //       ^^^^^ `foo` 是 `0x42::m` 的私有函数
      }
  }

  module other {
      public entry fun calls_m_foo() {
          0x42::m::foo(); // 错误！
          //       ^^^^^ `foo` 是 `0x42::m` 的私有函数
      }
  }

  script {
      fun calls_m_foo() {
          0x42::m::foo(); // 错误！
          //       ^^^^^ `foo` 是 `0x42::m` 的私有函数
      }
  }
}
