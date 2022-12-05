export class RichText {
  constructor(picker, emojiButton) {
    this.picker = picker;
    this.emojiButton = emojiButton;
    this.createEmojiPickerButton();
  }
  createEmojiPickerButton() {
    this.emojiButton.addEventListener("click", this.toggleEmojiPicker.bind(this));
//    document.getElementById("chat-text").prepend(this.emojiButton);
console.log (this.emojiButton);
    document.getElementById('chat-text').insertAdjacentHTML('beforebegin', this.emojiButton);
  }
  toggleEmojiPicker(event) {
    this.picker.toggle();
  }
  setPicker(picker) {
    this.picker = picker;
  }
}
