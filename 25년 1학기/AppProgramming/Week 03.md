# 250318

## Dart 문법 2

### 객체 지향 프로그래밍
- 객체(Object): 상태(값, 필드) + 행위(기능, 메서드)

- 클래스(Class): 객체의 설계도

- 인스턴스(Instance): 클래스를 통해 만들어진 객체

#### 주요 문법
- 접근 지정자: 변수명 앞에 _ → private (외부 접근 불가)

- 생성자(Constructor): Person({this.name, this._age}) 형태로 정의 가능

- 게터/세터: 값을 읽거나 설정할 때 사용

- 상속: extends, super.run() 으로 부모 메서드 호출 가능

- 추상 클래스: abstract 키워드 사용, 구현 없이 선언만

- 믹스인(Mixin): with 키워드로 다중 기능 포함

 - 열거형(Enum): 상수 목록 정의

###  컬렉션 (Collection)
- List: 순서 있는 배열 → [1, 2, 3]

- Map: 키-값 쌍 → { '한국': '서울' }

- Set: 중복 없는 집합 → {1, 2, 3}

#### 주요 기능
- 스프레드 연산자 : 배열 병합

 - dynamic 타입: 다양한 타입 허용 (예: [1, 'hello'])

### 함수형 프로그래밍
일급 객체: 함수를 변수에 저장, 인자로 전달, 반환값으로 사용 가능

- forEach(): List 반복 처리

- where(): 조건 필터링

- map(): 값 변환

- toList(), toSet(): 형 변환 및 중복 제거

- any(): 하나라도 조건 충족하는지 확인

- reduce(): 요소 누적 처리

### 유용한 기법
- 계단식 표기법 (..): 연속 호출

- 컬렉션 if / for: 조건문, 반복문을 컬렉션에 사용

- null 처리 관련 문법: ??, ?. 등

##### 실습 1
```dart
class Person {
  String _name = S"";
  int _age = 0;
  String desc = "";
  
  String get name => _name;
  int get age => _age;
  
  Person(this._name, this._age, {this.desc=''});

  void addOneYear() {
    _age++;
  }
}

void main() {
  var p = Person('박민기', 24, desc: '사실은 박만기임');
  
  print(p.age);
  print(p.name);
  
  p.addOneYear();
  print(p.age);
}
```
##### 실습 2
```dart
class Rectangle {
  num left, top, width, height;
  
  Rectangle(this.left, this.top, this.width, this.height);
  
  num get right => left + width;
  set right(num value) => left = value - width;
  num get bottom => top + height;
  set bottom(num value) => top = value - height;
}

void main() {
  var r = Rectangle(5, 10, 15, 20);
  print([r.left, r.top, r.width, r.height]);
  print([r.right, r.bottom]);
  //print('${r.left}, ${r.top}, ${r.width}, ${r.height}');
  
  r.right = 15;
  r.bottom = 20;
  print([r.left, r.top, r.width, r.height]);
}
```
##### 실습 3
```dart
// Rectangle의 필드를 left, top, right, bottom으로 하고
// get, set을 이용해서 width, height를 만들고 사용해보자

class Rectangle {
  num left, top;
  num right, bottom;
  
  Rectangle(this.left, this.top, this.right, this.bottom);
  
  num get width => right - left;
  set width(num value) => right = left + value;
  num get height => bottom - top;
  set height(num value) => bottom = top + value;
}

void main() {
  var r = Rectangle(5, 10, 15, 35);
  print([r.left, r.top, r.right, r.bottom]);
  
  r.width = 10;
  r.height = 20;
  print([r.left, r.top, r.right, r.bottom]);
}
```
#### 실습 4
```dart
class Hero {
  String name = '영웅';
    void run() {
      print('뛴다!');
    }
}

class SuperHero extends Hero {
  @override
  void run() {
    print('나는 슈퍼 히어로!');
    super.run();
    this.fly();
    print('나는 슈퍼 히어로! 끝!');
  }
  
  void fly() {
    print('난다!');
  }
}

void main() {
  Hero normalHero = Hero();
  Hero superHero = SuperHero();
  
  print(normalHero.name);
  print(superHero.name);
  
  print('');
  
  normalHero.run();
  print('');
  superHero.run();
  
  List<Hero> heroes = [normalHero, superHero];
  heroes.forEach((hero) => hero.run());
}
```
#### 실습 5
```dart
// Monster는 attack 할 수 있다.
abstract class Monster {
  void attack();
}

// Goblin은 Monster이며 고블린 어택을 한다.
class Goblin implements Monster {
  @override
  void attack() => print('고블린 어택');
}

abstract class Flyable {
  void fly();
}

// Bat은 Monster이며 할퀴기 attack을 한다.
class Bat implements Monster, Flyable {
  @override
  void attack() => print('할퀴기!');
  
  @override
  void fly() => print('난다!');
}

void main() {
  Goblin m1 = Goblin();
  m1.attack();
  Bat m2 = Bat();
  m2.attack();
  m2.fly();
  
  print('');
  
  List<Monster> monster = [m1, m2];
  monster.forEach((m) {
    m.attack();
    
    if (m is Bat) {
      (m as Bat).fly();
    }
  });
 }
```

##### 실습 6
```dart
enum LoginStatus {login, logout}

void main() {
  LoginStatus status = LoginStatus.logout;
  
  print(status);
  
  switch (status) {
    case LoginStatus.login:
      print('로그인');
      break;
    case LoginStatus.logout:
      print('로그아웃');
      break;
  }
}
```

##### 실습 7
```dart
void main() {
  var lottoNums = [5, 6, 11, 13, 17, 21];
  var countryMap = {'한국' : '서울', '일본': '도쿄', '중국': '북경'};
  var setNums = { 1, 2, 3, 4, 5, 6};
  
  print(lottoNums[0]); //5
  print(countryMap['일본']);  // 도쿄
  print(setNums.contains(5));  //true
  
  lottoNums.add(45);  // 보너스 번호
  print(lottoNums);
  
  countryMap['인도'] = '뉴델리';
  print(countryMap);
  
  setNums.add(6);
  print(setNums);
}
```

#### 실습 8
```dart
void main() {
  var lottoNums = [5, 6, 11, 13, 17, 21];
  
  // lottoNums.forEach((num) => print(num));
  
  lottoNums.forEach((num) {
    print(num);
  });
  
  var f = () => print('되네?');
  f();
}
```

#### 실습 9
```dart
void main() {
  bool promoActive = true;
  
  var result = [1, 2, 3, 4, 5, if (promoActive) 6];
  print(result);
}
```
#### 실습 10
```dart
class Person {
  String? name;
  int? age;
}

void main() {
  var p = Person();
  //p.name = '박민기';
  print(p.name?.length ?? 0);
}
```