import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
 static targets = ["card", "clickCounter", "score"];

  connect() {
    console.log("MemoryGame controller connected!");
    this.flippedCards = [];
    this.lockBoard = false;
    this.clicks = 0;
    this.matches = 0; // To track matched pairs
    this.totalPairs = this.cardTargets.length / 2;

    console.log(`Total pairs: ${this.totalPairs}`);
  }

  flip(event) {
    const card = event.currentTarget;
    console.log("Card clicked:", card);

    // Prevent multiple clicks or locked cards
    if (this.lockBoard || card.classList.contains("flipped")) {
      console.log("Click ignored: board locked or card already flipped");
      return;
    }

    card.classList.add("flipped");
    console.log("Card flipped:", card);

    this.flippedCards.push(card);
    this.incrementClickCounter(); // Increment clicks

    if (this.flippedCards.length === 2) {
      console.log("Two cards flipped, checking for match...");
      this.checkForMatch();
    }
  }


  incrementClickCounter() {
    this.clicks += 1;
    console.log(`Clicks incremented: ${this.clicks}`);
    this.clickCounterTarget.textContent = this.clicks; // Update the UI
  }

  checkForMatch() {
    const [card1, card2] = this.flippedCards;

    // Compare the cards' dataset IDs
    if (card1.dataset.pokemonId === card2.dataset.pokemonId) {
      this.handleMatch(); // Call handleMatch when cards match
    } else {
      this.unflipCards();
    }
  }

  handleMatch() {
    this.matches += 1;
    console.log(`Match found! Total matches: ${this.matches}`);
    this.updateScore();
    this.resetFlippedCards();

    if (this.matches === this.totalPairs) {
      console.log("All pairs matched!");
      this.displayWinMessage();
    }
  }

  unflipCards() {
    this.lockBoard = true;

    setTimeout(() => {
      this.flippedCards.forEach(card => card.classList.remove("flipped"));
      this.resetFlippedCards();
      this.lockBoard = false;
    }, 1000); // 1-second delay before flipping back
  }

  resetFlippedCards() {
    this.flippedCards = [];
  }

  updateScore() {
    const score = Math.max(1000 - this.clicks * 10, 0); // Basic scoring logic
    this.scoreTarget.textContent = score; // Update the UI
  }

 displayWinMessage() {
  console.log(`Game completed in ${this.clicks} clicks.`);
  alert(`🎉 Congratulations! You completed the game in ${this.clicks} clicks! 🎉`);
}

}
