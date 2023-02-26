import DEFAULT_MUSIC from './config/index';
App({
  getFavorMusics: function() {
    console.log("getFavorMusics")
    const db = wx.cloud.database({
      env: 'cloud1-0gmvawbtf2ca9f59'
    })
    //查询当前用户所有的counters
    db.collection('music_favor').field ({
      sid: true,
      _id: true,
    }).get({
      success: res => {
        let musics = new Array(res.data.length + 1);
        let counterIds = new Array(res.data.length + 1);

        res.data.forEach(function (item,index) {
          musics[item.sid] = true,
          counterIds[item.sid] = item._id
        })
        console.log(musics, counterIds)
        this.globalData.favorMusics = {
          musics: musics,
          counterIds: counterIds,
        },
        console.log(this.globalData.favorMusics)
      },
      fail: err => {
        wx.showToast({
          icon: 'none',
          title: '查询记录失败',
        })
        console.error('[数据库][查询记录]失败: ', err)
      }
    })
  },
  globalData: {
      userInfo: null,
      audio: wx.createInnerAudioContext(),
      playState: DEFAULT_MUSIC.DEFAULT_MUSIC.playState,
      musicPic: DEFAULT_MUSIC.DEFAULT_MUSIC.musicPic,
      musicName: DEFAULT_MUSIC.DEFAULT_MUSIC.musicName,
      musicUrl: DEFAULT_MUSIC.DEFAULT_MUSIC.musicUrl,
      artistName: DEFAULT_MUSIC.DEFAULT_MUSIC.artistName,
      musicPlayer: null,
      favorMusics: {},
  },
  onLaunch() {
    if (!wx.cloud) {
      console.error('请使用2.2.3或以上的基础库以使用云能力')
    } else {
      wx.cloud.init({
        env: 'course-demo',
        traceUser: true,
      })
    }
    this.globalData.audio.src = DEFAULT_MUSIC.DEFAULT_MUSIC.musicUrl
    this.getFavorMusics();
  },
})
