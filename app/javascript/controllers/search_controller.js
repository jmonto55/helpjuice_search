import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["title", "author", "content"]

  connect() {
  }

  async filterArticles(event) {
    const searchTerm = event.target.value.toLowerCase();
  
    clearTimeout(this.queryTimeout);

    this.queryTimeout = setTimeout(() => {
      this.postNewQuery(event.target.value);
    }, 3000);

    this.titleTargets.forEach((title) => {
      const postTitle = title.textContent.toLowerCase();
      const postAuthor = title.nextElementSibling.textContent.toLowerCase();
      const postContent = title.nextElementSibling.nextElementSibling.textContent.toLowerCase();

      if (postContent.includes(searchTerm) || postAuthor.includes(searchTerm) || postTitle.includes(searchTerm)) {
        title.parentElement.style.display = "";
      } else {
        title.parentElement.style.display = "none";
      }
    });
  }

  async postSearch(event) {
    clearTimeout(this.queryTimeout);

    this.queryTimeout = setTimeout(() => {
      this.postNewQuery(event.target.value);
    }, 300);
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
