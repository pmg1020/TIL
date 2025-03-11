# 실습 1

다트 언어로 구구단 출력하기

```dart
void main() {
  for (int i = 2; i <= 9; i++) {
    for (int j = 1; j <= 9; j++) {
      print("$i x $j = ${i * j}");
    }
    print("");
  }
}
```