// Iterator: exposes a way to walk through a collection's elements one by
// one (hasNext/next) without exposing whether it's backed by an array,
// a Map, or anything else. JavaScript's own iteration protocol
// (`for...of`, `Symbol.iterator`) already does this — this example
// builds the mechanism by hand to show what's actually happening
// underneath.
class BookCollection {
  #books = [];

  add(title) {
    this.#books.push(title);
  }

  createIterator() {
    return new BookIterator(this.#books);
  }
}

class BookIterator {
  #books;
  #position = 0;

  constructor(books) {
    this.#books = books;
  }

  hasNext() {
    return this.#position < this.#books.length;
  }

  next() {
    return this.#books[this.#position++];
  }
}

// --- demo ---
const collection = new BookCollection();
collection.add("Clean Code");
collection.add("The Pragmatic Programmer");
collection.add("Design Patterns");

const iterator = collection.createIterator();
while (iterator.hasNext()) {
  console.log(iterator.next());
}
