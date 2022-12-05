import { Controller } from "@hotwired/stimulus";
import { createPopup } from "@picmo/popup-picker";
// import { RichText } from "../classes/RichText";

export default class extends Controller {
  reset() {
    this.element.reset();
  }

  static targets = ["bodyText", "pickerContainer"];
  connect() {
    console.log("Connected to emoji-picker");
    let emojiButton = document.getElementById("emoji-picker");
    let picker;
//    let richText = new RichText(picker, emojiButton);
    picker = createPopup(
      { rootElement: this.pickerContainerTarget, },
      { triggerElement: emojiButton,    // The element that triggers the popup
        referenceElement: emojiButton,  // The element to position the picker relative to
        position: "top-start",          // specify how to position the popup
      }
    );

    emojiButton.addEventListener("click", picker.toggle());

    picker.addEventListener("emoji:select", (event) => {
      this.bodyTextTarget.value += event.emoji;
    });

//    richText.setPicker(picker);
  }

  setPicker(picker) {
    this.picker = picker;
  }
}
