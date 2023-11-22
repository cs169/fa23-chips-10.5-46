// Event handlers for hover, mouseleave & mousemove & on-click
// The page must define a `#actionmap-info-box` div with `.d-none`
exports.handleMapMouseEvents = (jQueryTargets, hoverHtmlProvider, clickCallback) => {
    const infoBox = $('#actionmap-info-box');
    jQueryTargets.hover((e) => {
        infoBox.html(hoverHtmlProvider($(e.currentTarget)));
        infoBox.css('display', 'block');
    });
    jQueryTargets.mouseleave(() => infoBox.css('display', 'none'));
    $(document).mousemove((elem) => {
        infoBox.css('top', elem.pageY - infoBox.height() - 30);
        infoBox.css('left', elem.pageX - infoBox.width() / 2);
    }).mouseover();

    jQueryTargets.click((e) => {
        const target = $(e.currentTarget);
        clickCallback(target);
        const countyName = target.data('county-name');
        fetch(`/representatives/by_county?county=${encodeURIComponent(countyName)}`)
            .then(response => (response.text()))
            .then(html => ({
                $document.querySelector('#representatives-list').html(html);
            })
            .catch(error => (console.error('Error:', error))));
    });
};

exports.zeroPad = (number, numZeros) => {
    let s = String(number);
    while (s.length < (numZeros || 1)) { s = `0${s}`; }
    return s;
};
