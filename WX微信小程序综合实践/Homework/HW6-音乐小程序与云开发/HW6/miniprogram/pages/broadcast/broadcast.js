import broadcastList from "../../datas/broadcastList.js";

Page ({
  data: {
    broadcasts: []
  },

  onLoad: function(options) {
    this.setData({
      broadcasts: broadcastList.broadcasts
    });
  }
})