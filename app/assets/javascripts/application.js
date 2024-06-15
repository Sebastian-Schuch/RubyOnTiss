document.addEventListener('DOMContentLoaded', function () {
    const highlightButton = document.getElementById('highlight-button');
    const highlightInput = document.getElementById('highlight-input');

    highlightButton.addEventListener('click', function () {
        const regex = new RegExp(highlightInput.value, 'gi');
        document.querySelectorAll('.report-content').forEach(function (element) {
            element.innerHTML = element.innerHTML.replace(regex, function (matched) {
                return `<mark>${matched}</mark>`;
            });
        });
    });
});
