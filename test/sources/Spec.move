module addr::M {
  struct Counter has key {
    value: u8,
  }

  public fun increment(a: address) acquires Counter {
    let r = borrow_global_mut<Counter>(a);
    spec {
      // spec block targeting this code position
      // ...
    };
    r.value = r.value + 1;
  }

  spec increment {
    // spec block targeting function increment
    // ...
  }

  spec Counter {
    // spec block targeting struct Counter
    // ...
  }

  spec schema Schema {
    // spec block declaring a schema
    // ...
  }

  spec fun f(x: num): num {
    // spec block declaring a helper function
    // ...
  }

  spec module {
    // spec block targeting the whole module
    // ...
  }
}
