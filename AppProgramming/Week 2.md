# Dart 문법

## Dart 언어
Dart 언어
- Google에서 설계하여 JavaScript와 유사하지만 다른 정적 언어

Dart와 유사한 프로그래밍 언어
- JavaScript - 거의 유사
- Java - 클레스 및 메서드 구문 유사
- C# - 비동기 프로그래밍 async, await등이 유사

주석
- // 주석1
- /** hello **/ 주석2
- /// 주석3

문장
- 명령 단위. C계열의 프로그래밍 언어는 세미콜론(;)으로 한 문장 표기

변수
- 데이터(값)을 저장하는 장소
- int : 정수
- double : 실수(소수점)
- String : 문자열
- bool : 참 또는 거짓
- num : 정수와 실수를 같이 쓸 떄
- var : 변수형

상수 final, const
- 값이 한번 설정되면 바꿀 수 없는 것을 상수
  
  ※차이점 : final은 동작중에 값이 고정되나 const는 컴파일 시점에서 값이 고정 됨

연산자
- +,-,*
- / : 나누기(double형으로 반환)
- ~/ : 몫(int형으로 반환)
- % : 나머지(int형으로 반환)

증감연산자
- 후위 연산 : x++, x--
- 전위 연산 : ++x, --x

비교 연산자
- ==
- !=
- >
- <
- >=
- <=

논리 연산자
- && (and)
- || (or)
- ! (not)

타입 검사
- is : 같은 타입이면 true, 아니면 false
- is! : 같은 타입이면 false, true

형변환
- var c = 30.5;   // double
- int d = c as int; // 오류 발생. 이유는 double -> int 안됨

함수
- {} 모듈화

함수와 메서드
- 함수 : 모든 지역에서 접근 가능함
- 메서드 : 클래스 안에서만 접근 가능하거나 인스턴스를 통해서만 접근 가능함

분기와 반복
- if else
- 삼항 연산자
- swich case
- for



### 실습 1

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

### 실습 2

다트 언어로 정사각형의 길이를 입력하고 사각형을 출력하기

※ 곽 찬 사각형, 테두리 사각형, / 표시, \ 표시, X 표시 사각형

```dart
var result = '';

void main() {
  var n = 10;

  result += "1. 테두리 사각형:\n";
  drawPattern(n, pattern1);

  result += "\n2. 꽉 찬 사각형:\n";
  drawPattern(n, pattern2);

  result += "\n3. / 표시 사각형:\n";
  drawPattern(n, pattern3);

  result += "\n4. \\ 표시 사각형:\n";
  drawPattern(n, pattern4);

  result += "\n5. X 표시 사각형:\n";
  drawPattern(n, pattern5);

  print(result); // 모든 패턴 출력
}

// 공통 함수
void drawPattern(int n, bool Function(int, int, int) patternFunc) {
  for (var y = 0; y < n; y++) {
    for (var x = 0; x < n; x++) {
      if (patternFunc(n, x, y)) {
        result += '=';
      } else {
        result += ' ';
      }
    }
    result += '\n';
  }
}

// 1. 테두리 사각형
bool pattern1(int n, int x, int y) {
  return (y == 0 || y == n - 1 || x == 0 || x == n - 1);
}

// 2. 꽉 찬 사각형
bool pattern2(int n, int x, int y) {
  return true;
}

// 3. / 표시 사각형
bool pattern3(int n, int x, int y) {
  return x == (n - y - 1);
}

// 4. \ 표시 사각형
bool pattern4(int n, int x, int y) {
  return x == y;
}

// 5. X 표시 사각형
bool pattern5(int n, int x, int y) {
  return x == y || x == (n - y - 1);
}

```

### 실습 3
다트 언어로 년/월/일을 입력하면 요일을 출력하기

```dart
void main() {
  String input = "2025-03-11"; // 날짜를 수정하여 사용

  DateTime date = DateTime.parse(input); //  날짜 변환
  String weekday = getKoreanWeekday(date.weekday); // 요일 변환
  print("입력: $input");
  print("출력: $weekday");
}

// 요일 변환
String getKoreanWeekday(int weekday) {
  List<String> weekdays = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"];
  return weekdays[weekday - 1];
}
```
