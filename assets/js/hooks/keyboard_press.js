export default {
  mounted() {
    this.guess = ""
    this.attempts = true
    this.current_tile = 1

    this.el.addEventListener('key-press', (event) => {
      if (this.attempts) {
        this.keyAction(event.detail.key, event.detail.length)
      }
    });

    this.handleEvent("new_attempt", data => {
      this.guess = "";
      this.attempts = data.attempts;
      this.current_tile = 1;
    });
  },

  keyAction(key, length) {

    let el = document.getElementById("warningMessage");
    if (el.classList.contains("block")) el.classList.replace("block", "hidden");

    switch (key) {
      case 'Enter':
        if (this.guess.length != length) {
          el.innerHTML = "Not enough letters";
          el.classList.replace("hidden", "block");
        } else {
          this.pushEvent("submit", { guess: this.guess });
        }
        break;

      case 'Backspace':
        this.guess = this.guess.slice(0, -1);
        if (this.current_tile > 1) {
          this.current_tile = this.current_tile - 1;
          let el = document.getElementById("input-1-" + this.current_tile);
          el.classList.replace("border-light_purple", "border-slate-300");
          el.classList.toggle("animate-pop")
          el.innerHTML = " ";

        }
        break;

      default:
        key = key.toUpperCase();
        if ((key >= 'A' && key <= 'Z') && (key.length == 1)) {
          if (this.guess.length < length) {
            this.guess = this.guess + key;

            let el = document.getElementById("input-1-" + this.current_tile);
            el.classList.replace("border-slate-300", "border-light_purple");
            el.classList.toggle("animate-pop")
            el.innerHTML = key;

            this.current_tile = this.current_tile + 1;
          }
        }
        break;
    }

  },

};