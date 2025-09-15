script {
  fun example() {
    let maximum = if (x > y) x else y;
    if (maximum < 10) {
        x = x + 10;
        y = y + 10;
    } else if (x >= 10 && y >= 10) {
        x = x - 10;
        y = y - 10;
    }
  }
}
