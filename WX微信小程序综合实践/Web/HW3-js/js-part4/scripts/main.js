const image = document.getElementById("floatImage");

const w_width = window.screen.availWidth;
const w_height = window.screen.availHeight;

let width = 20;
let height = 20;
let vx = 1;
let vy = 1;

function changePos() {
    width = (width+vx) % (w_width-300);
    height = (height+vy) % (w_height-300);

    image.style.left = width + 'px';
    image.style.top = height + 'px';
}


var time1 = setInterval(changePos,20);

function stopMov() {
    clearInterval(time1);
}

function resumeMov() {
    time1 = setInterval(changePos,20);
}