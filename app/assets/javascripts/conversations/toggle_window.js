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
          let messages_visible = $('ul', this).has('li').length;

          // load first 10 messages if message list is empty
          if (!messages_visible && $('.load-more-messages', this).length) {
            $('.load-more-messages', this)[0].click();
          }
        });
    });
});
