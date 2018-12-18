$(document).on('turbolinks:load', function() {

    // when conversation heading is clicked, toggle conversation
    $('body').on('click',
    	         '.conversation-heading, .conversation-heading-full',
    	         function(e) {
        e.preventDefault();
        let panel = $(this).parent();
        let panel_body = panel.find('.panel-body');
        let messages_list = panel.find('.messages-list');

        panel_body.toggle(100, function() {
        });
    });
});
