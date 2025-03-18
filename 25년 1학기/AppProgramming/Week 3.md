### 실습 1

```dart
class Person {
  String _name = "";
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
### 실습 2
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
### 실습 3
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
### 실습 4
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
### 실습 5
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