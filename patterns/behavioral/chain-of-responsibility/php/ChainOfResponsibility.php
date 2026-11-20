<?php
// Chain of Responsibility: each handler either resolves the request or
// passes it to the next handler in the chain — the caller only ever
// talks to the first handler and doesn't know how many others exist.
abstract class SupportHandler
{
    private ?SupportHandler $next = null;

    public function setNext(SupportHandler $next): SupportHandler
    {
        $this->next = $next;
        return $next; // lets callers chain setNext calls while building the chain
    }

    public function handle(int $severity): void
    {
        if ($this->canHandle($severity)) {
            $this->resolve($severity);
        } elseif ($this->next !== null) {
            $this->next->handle($severity);
        } else {
            echo "No handler could resolve severity {$severity}\n";
        }
    }

    abstract protected function canHandle(int $severity): bool;
    abstract protected function resolve(int $severity): void;
}

class Level1Support extends SupportHandler
{
    protected function canHandle(int $severity): bool { return $severity <= 1; }
    protected function resolve(int $severity): void { echo "Level1 resolved severity {$severity}\n"; }
}

class Level2Support extends SupportHandler
{
    protected function canHandle(int $severity): bool { return $severity <= 2; }
    protected function resolve(int $severity): void { echo "Level2 resolved severity {$severity}\n"; }
}

class Level3Support extends SupportHandler
{
    protected function canHandle(int $severity): bool { return $severity <= 3; }
    protected function resolve(int $severity): void { echo "Level3 resolved severity {$severity}\n"; }
}

// --- demo ---
$level1 = new Level1Support();
$level2 = new Level2Support();
$level3 = new Level3Support();
$level1->setNext($level2)->setNext($level3); // build the chain: 1 -> 2 -> 3

$level1->handle(1); // resolved at level 1
$level1->handle(2); // escalates to level 2
$level1->handle(3); // escalates to level 3
$level1->handle(5); // nobody can handle it
