// Working with prototype
// importance: 5
// Here’s the code that creates a pair of objects, then modifies them.

// Which values are shown in the process?

let animal = {
  jumps: null
};
let rabbit = {
  __proto__: animal,
  jumps: true
};

// alert( rabbit.jumps ); // ? (1)

// delete rabbit.jumps;

// alert( rabbit.jumps ); // ? (2)

// delete animal.jumps;

// alert( rabbit.jumps ); // ? (3)

// There should be 3 answers.

// solution
// true, taken from rabbit.
// null, taken from animal.
// undefined, there’s no such property any more.


// Searching algorithm
// importance: 5
// The task has two parts.

// We have an object:

let head = {
  glasses: 1
};

let table = {
  __proto__: head,
  pen: 3
};

let bed = {
  __proto__: table,
  sheet: 1,
  pillow: 2
};

let pockets = {
  __proto__: bed,
  money: 2000
};

// 1. Use __proto__ to assign prototypes in a way that any property lookup will follow the path: pockets → bed → table → head. For instance, pockets.pen should be 3 (found in table), and bed.glasses should be 1 (found in head).

// 2. Answer the question: is it faster to get glasses as pockets.glasses or head.glasses? Benchmark if needed.

// Where it writes?
// importance: 5
// We have rabbit inheriting from animal.

// If we call rabbit.eat(), which object receives the full property: animal or rabbit?

let animal = {
  eat() {
    this.full = true;
  }
};

let rabbit = {
  __proto__: animal
};

rabbit.eat();

// solution
// The answer: rabbit.

// That’s because this is an object before the dot, so rabbit.eat() modifies rabbit.

// Property lookup and execution are two different things. The method rabbit.eat is first found in the prototype, then executed with this=rabbit

// Why two hamsters are full?
// importance: 5
// We have two hamsters: speedy and lazy inheriting from the general hamster object.

// When we feed one of them, the other one is also full. Why? How to fix it?

 let hamster = {
  stomach: [],

  eat(food) {
    this.stomach.push(food);
  }
};

let speedy = {
  __proto__: hamster
};

let lazy = {
  __proto__: hamster
};

// This one found the food
speedy.eat("apple");
alert( speedy.stomach ); // apple

// This one also has it, why? fix please.
alert( lazy.stomach ); // apple
// solution
// Let’s look carefully at what’s going on in the call speedy.eat("apple").

// The method speedy.eat is found in the prototype (=hamster), then executed with this=speedy (the object before the dot).

// Then this.stomach.push() needs to find stomach property and call push on it. It looks for stomach in this (=speedy), but nothing found.

// Then it follows the prototype chain and finds stomach in hamster.

// Then it calls push on it, adding the food into the stomach of the prototype.

// So all hamsters share a single stomach!

// Every time the stomach is taken from the prototype, then stomach.push modifies it “at place”.

// Please note that such thing doesn’t happen in case of a simple assignment this.stomach=:

 





let hamster = {
  stomach: [],

  eat(food) {
    // assign to this.stomach instead of this.stomach.push
    this.stomach = [food];
  }
};

let speedy = {
   __proto__: hamster
};

let lazy = {
  __proto__: hamster
};

// Speedy one found the food
speedy.eat("apple");
alert( speedy.stomach ); // apple

// Lazy one's stomach is empty
alert( lazy.stomach ); // <nothing>
// Now all works fine, because this.stomach= does not perform a lookup of stomach. The value is written directly into this object.

// Also we can totally evade the problem by making sure that each hamster has his own stomach:



let hamster = {
  stomach: [],

  eat(food) {
    this.stomach.push(food);
  }
};

let speedy = {
  __proto__: hamster,
  stomach: []
};

let lazy = {
  __proto__: hamster,
  stomach: []
};

// Speedy one found the food
speedy.eat("apple");
alert( speedy.stomach ); // apple

// Lazy one's stomach is empty
alert( lazy.stomach ); // <nothing>
// As a common solution, all properties that describe the state of a particular object, like stomach above, are usually written into that object. That prevents such problems.

