App.vote_counts = App.cable.subscriptions.create("VoteCountsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
  },

  update: function() {
    return this.perform('update');
  }
});
