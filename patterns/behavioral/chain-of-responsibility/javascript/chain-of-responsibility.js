// Chain of Responsibility: each handler either resolves the request or
// passes it to the next handler in the chain — the caller only ever
// talks to the first handler and doesn't know how many others exist.
class SupportHandler {
  next = null;

  setNext(next) {
    this.next = next;
    return next; // lets callers chain setNext calls while building the chain
  }

  handle(severity) {
    if (this.canHandle(severity)) {
      this.resolve(severity);
    } else if (this.next) {
      this.next.handle(severity);
    } else {
      console.log(`No handler could resolve severity ${severity}`);
    }
  }
}

class Level1Support extends SupportHandler {
  canHandle(severity) {
    return severity <= 1;
  }
  resolve(severity) {
    console.log(`Level1 resolved severity ${severity}`);
  }
}

class Level2Support extends SupportHandler {
  canHandle(severity) {
    return severity <= 2;
  }
  resolve(severity) {
    console.log(`Level2 resolved severity ${severity}`);
  }
}

class Level3Support extends SupportHandler {
  canHandle(severity) {
    return severity <= 3;
  }
  resolve(severity) {
    console.log(`Level3 resolved severity ${severity}`);
  }
}

// --- demo ---
const level1 = new Level1Support();
const level2 = new Level2Support();
const level3 = new Level3Support();
level1.setNext(level2).setNext(level3); // build the chain: 1 -> 2 -> 3

level1.handle(1); // resolved at level 1
level1.handle(2); // escalates to level 2
level1.handle(3); // escalates to level 3
level1.handle(5); // nobody can handle it
