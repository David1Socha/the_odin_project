function getRandomColorStr() {
    return '#' + (Math.random().toString(16) + '000000').slice(2, 8);
}

function makeGrid(rowLength, gridType) {
    var size = 720;
    $("#grid_area").empty();
    var unitSize = Math.floor(size / rowLength);
    var $panel = $("<div>", {
        class: "panel"
    });
    $panel.width(unitSize);
    $panel.height(unitSize);
    $("#grid_area").height(unitSize * rowLength);
    $("#grid_area").width(unitSize * rowLength);

    switch (gridType) {
    case 1:
        console.log('hi');
        $panel.hover(function () {
            $(this).css('background-color', getRandomColorStr());
        });
        break;
    case 2:
        $panel.hover(function () {
            var opacity = $(this).css("opacity");
            $(this).css('opacity', opacity - 0.0999);
        });
        break;
    default:
        $panel.hover(function () {
            $(this).css('background-color', '#4E4E4F');
        });
        break;
    }

    for (var i = 0; i < rowLength * rowLength; i++) {
        $("#grid_area").append($panel.clone(true));
    }
}

function promptGrid(gridType) {
    var size = prompt('Length of grid in squares per row (1-64)? ');
    if (size >= 1 && size <= 64) {
        makeGrid(size, gridType);
    } else {
        alert('Invalid input');
    }
}

$(document).ready(function () {
    makeGrid(16);

});