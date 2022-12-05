import { Controller } from "@hotwired/stimulus";
import { createPopup } from "@picmo/popup-picker";

export default class extends Controller {
  reset() {
    this.element.reset();
  }

  static targets = ["messageBody", "pickerContainer"];
  connect() {
    console.log("Connected to emoji-picker");
    const emojiButton = document.querySelector("#emoji-picker");

    const picker = createPopup(
      { rootElement: this.pickerContainerTarget, },
      { triggerElement: emojiButton,    // The element that triggers the popup
        referenceElement: emojiButton,  // The element to position the picker relative to
        position: "top-start",          // specify how to position the popup
      }
    );

    const togglePicker = () => { picker.toggle(); }

    emojiButton.addEventListener("click", togglePicker);

    // The picker emits an event when an emoji is selected. Do with it as you will!
    picker.addEventListener("emoji:select", event => {
      this.messageBodyTarget.value += event.emoji;
    });
  }
}
