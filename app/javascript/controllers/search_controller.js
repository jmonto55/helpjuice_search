import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["title", "content"]

  connect() {
  }

  async filterArticles(event) {
    const searchTerm = event.target.value.toLowerCase();
  
    // Clear the console.log timeout
    clearTimeout(this.consoleLogTimeout);
  
    // Set a new timeout for console.log after 4 seconds or on pressing Enter
    this.consoleLogTimeout = setTimeout(() => {
      console.log("Search term:", searchTerm);

      // Call the method to post a new query
      this.postNewQuery(searchTerm);
    }, 2500);

    // Filtering process without a delay
    this.titleTargets.forEach((title) => {
      const postContent = title.nextElementSibling.textContent.toLowerCase();
      const postTitle = title.textContent.toLowerCase();
  
      if (postContent.includes(searchTerm) || postTitle.includes(searchTerm)) {
        title.parentElement.style.display = "";
      } else {
        title.parentElement.style.display = "none";
      }
    });
  }   

  async postNewQuery(searchTerm) {
    try {
      const response = await fetch('/queries', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({
          query: {
            search: searchTerm
          }
        })
      });

      if (!response.ok) {
        console.error('Failed to create a new query:', response.statusText);
      }
    } catch (error) {
      console.error('Error posting new query:', error);
    }
  }
}
