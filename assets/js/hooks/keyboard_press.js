export default {
  mounted() {
    this.guess = ""
    this.attempts = 6
    this.current_tile = 1

    this.el.addEventListener('key-press', (event) => {
      if (this.attempts > 0) {
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
    el.classList.remove("block");
    el.classList.add("hidden");

    switch (key) {
      case 'Enter':
        if (this.guess.length != length) {
          el.innerHTML = "Not enough letters";
          el.classList.remove("hidden");
          el.classList.add("block");
        } else {
          this.pushEvent("submit", { guess: this.guess });
        }
        break;

      case 'Backspace':
        this.guess = this.guess.slice(0, -1);
        if (this.current_tile > 1) {
          this.current_tile = this.current_tile - 1;
          let el = document.getElementById("input-1-"+this.current_tile);
          el.classList.remove("border-light_purple");
          el.classList.add("border-slate-300");
          el.innerHTML = " ";

        }
        break;

      default:
        key = key.toUpperCase();
        if ((key >= 'A' && key <= 'Z') && (key.length == 1)) {
          if (this.guess.length < length) {
            this.guess = this.guess + key;

            let el = document.getElementById("input-1-"+this.current_tile);
            el.classList.remove("border-slate-300");
            el.classList.add("border-light_purple");
            el.innerHTML = key;
            
            this.current_tile = this.current_tile + 1;
          }
        }
        break;
    }

    console.log("guess ", this.guess);
  },

};