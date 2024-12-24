import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
 static targets = ["card", "clickCounter", "score", "scoreList", "leaderboard"];

  connect() {
    this.scoreList = JSON.parse(localStorage.getItem("leaderboard")) || [];
    this.flippedCards = [];
    this.lockBoard = false;
    this.clicks = 0;
    this.matches = 0; // To track matched pairs
    this.totalPairs = this.cardTargets.length / 2;
    this.updateScore();
    this.updateLeaderboard();
  }

  flip(event) {
    const card = event.currentTarget;

    // Prevent multiple clicks or locked cards
    if (this.lockBoard || card.classList.contains("flipped")) {
      console.log("Click ignored: board locked or card already flipped");
      return;
    }

    card.classList.add("flipped");

    this.flippedCards.push(card);
    this.incrementClickCounter(); // Increment clicks

    if (this.flippedCards.length === 2) {
      this.checkForMatch();
    }
  }


  incrementClickCounter() {
    this.clicks += 1;
    this.clickCounterTarget.textContent = this.clicks; // Update the UI
    this.updateScore();
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
    console.log("Updating score...");
    console.log("Current scoreList:", this.scoreList);
    const score = Math.max(1000 - this.clicks * 10, 0); // Calcola il punteggio
    this.scoreTarget.textContent = score; // Aggiorna il punteggio nella UI
    if (this.matches === this.totalPairs) {
      this.scoreList.push(score);
      console.log("Updated scoreList:", this.scoreList);
      // Add the score to the score list
      localStorage.setItem("leaderboard", JSON.stringify(this.scoreList)); // Save to localStorage
      this.updateLeaderboard(); // Update the leaderboard
    }// Aggiorna la leaderboard
}

updateLeaderboard() {
  // Ordina i punteggi in ordine decrescente
  const sortedScores = [...this.scoreList].sort((a, b) => b - a);

  // Prendi i primi 5 punteggi per la leaderboard
  const topScores = sortedScores.slice(0, 5);

  // Aggiorna l'elemento leaderboard nella UI
  this.leaderboardTarget.innerHTML = topScores
    .map((score, index) => `<li>${index + 1}. ${score}</li>`)
    .join("");
}


 displayWinMessage() {
  console.log(`Game completed in ${this.clicks} clicks.`);
  alert(`🎉 Congratulations! You completed the game in ${this.clicks} clicks! 🎉`);
}

}
