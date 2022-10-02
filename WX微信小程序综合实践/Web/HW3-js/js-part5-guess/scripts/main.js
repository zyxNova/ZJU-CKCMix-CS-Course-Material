let randomNum = Math.floor(Math.random()*100) + 1;
let cnt = 1;
let guessField = document.getElementById("guessField");
let guesses = document.getElementById("guesses");
let lastResult = document.getElementById("lastResult");
let lowOrHigh = document.getElementById("lowOrHigh");

function guess() {
    if (cnt > 10) {
        resetGame();
        alert("你的次数已经用完！\n 请重新开始游戏");
        return 
    }

    let value = guessField.value;
    if (value > randomNum) {
        addLastResult("你猜错了", "red");
        addLowOrHigh("猜高了");
    }
    else if (value < randomNum) {
        addLastResult("你猜错了", "red");
        addLowOrHigh("猜低了");
    }
    else {
        addLastResult("恭喜你猜中了", "green");
        addLowOrHigh("猜对了");
    }
    guessField.value = null;
    addGuesses(value);

    cnt++;
}

function addLastResult(info, color) {
    lastResult.textContent = info;
    lastResult.style.backgroundColor = color;
}

function addLowOrHigh(info) {
    lowOrHigh.textContent = info;
}

function addGuesses(val) {
    if (cnt==1) {
        guesses.textContent = "上次猜的数：";
    }
    guesses.textContent += val + " ";
}


function resetGame() {
    randomNum = Math.floor(Math.random()*100) + 1;
    guessField.value = null;
    cnt = 1;
    guesses.textContent = null;
    lastResult.textContent = null;
    lastResult.style.background = null;
    lowOrHigh.textContent = null;
}