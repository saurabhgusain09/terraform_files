const textArray = [
  "Cloud Enthusiast",
  "AWS Learner",
  "DevOps Explorer",
  "Static Web Hosting Fan"
];
let textIndex = 0;
let charIndex = 0;
const typedText = document.querySelector(".typed-text");
const speed = 100;

function type() {
  if (charIndex < textArray[textIndex].length) {
    typedText.textContent += textArray[textIndex].charAt(charIndex);
    charIndex++;
    setTimeout(type, speed);
  } else {
    setTimeout(erase, 2000);
  }
}
function erase() {
  if (charIndex > 0) {
    typedText.textContent = textArray[textIndex].substring(0, charIndex - 1);
    charIndex--;
    setTimeout(erase, speed / 2);
  } else {
    textIndex = (textIndex + 1) % textArray.length;
    setTimeout(type, 500);
  }
}
document.addEventListener("DOMContentLoaded", () => {
  setTimeout(type, 500);
});
