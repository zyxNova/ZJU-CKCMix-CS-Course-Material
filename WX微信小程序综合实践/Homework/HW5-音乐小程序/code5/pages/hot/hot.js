//
import musicList from "../../datas/musicList.js";

Page ({
  data: {
    musics : []
  },

  onLoad: function(options) {
    this.setData({
      musics: musicList.musics
    });
  }
})