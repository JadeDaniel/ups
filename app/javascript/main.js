document.addEventListener('click', function(event) {
    if (!event.target.matches('.navigate_back')) return;

    event.preventDefault();

    history.back();
}, false);