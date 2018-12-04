$(document).on('turbolinks:load', function() {
    if ($(".single-post-card").length) {
      // set a solid background color style
      $(".single-post-card").each(function() {
          $(this).addClass("solid-color-mode");
          $(this).css('background-color', randomColor());
      });
    }

    $('#feed').on( 'mouseenter', '.single-post-list', function() {
        $(this).css('border-color', randomColor());
    });

    $('#feed').on( 'mouseleave', '.single-post-list', function() {
        $(this).css('border-color', 'rgba(0, 0 , 0, 0.05)');
    });

});

let colorSet = randomColorSet();

// Randomly returns a color scheme
function randomColorSet() {
    let colorSet1 = ['#40e0d0', '#7fffd4', '#66cdaa', '#20b2aa', '#008080'];
    let colorSet2 = ['#008080', '#29b3b3', '#005757', '#007a74', '#40826d'];
    let colorSet3 = ['#97cecc', '#1aa6b7', '#62c2cc', '#4cd0d0', '#3fe0d0'];
    let colorSet4 = ['#7fbf9d', '#5ac7a8', '#389a7f', '#1b7e7c', '#005452'];
    let randomSet = [colorSet1, colorSet2, colorSet3, colorSet4];
    return randomSet[Math.floor(Math.random() * randomSet.length )];
}

// Randomly returns a color from an array of colors
function randomColor() {
    let color = colorSet[Math.floor(Math.random() * colorSet.length)];
    return color;
}
