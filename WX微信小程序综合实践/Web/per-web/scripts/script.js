var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
    showSlides(slideIndex += n);
}

function increSlides() {
    showSlides(++slideIndex);
}

function showSlides(n) {
    var i;
    var slides = document.getElementsByClassName("mySlides");
    if (n > slides.length) slideIndex = 1;
    if (n < 1) slideIndex = slides.length;
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    slides[slideIndex - 1].style.display = "block";
}

var time1 = setInterval(increSlides,5000);

function stopMov() {
    clearInterval(time1);
}

function resumeMov() {
    time1 = setInterval(increSlides,5000);
}