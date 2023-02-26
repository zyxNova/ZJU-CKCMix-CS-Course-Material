//
import musicList from "../../datas/musicList.js";

Page ({
  data: {
    musics : [],
    // song: {
    //   poster: 'http://cdnmusic.migu.cn/picture/2019/1031/0254/ASd6c2d9697d2a4f5f96508c8a7ec8b1a8.jpg',
    //   name: '七里香',
    //   author: '周杰伦',
    //   src: 'https://mp3.9ku.com/hot/2004/08-03/58714.mp3'
    // }
  },

  onLoad: function(options) {
    this.setData({
      musics: musicList.musics
    });
  }
})