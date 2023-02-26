// components/songItem/songItem.js
var app = getApp();
Component({
    /**
     * 组件的属性列表
     */
    properties: {
        item: {
            type: Object,
            value: {}
        },
        singer: {
            type: String,
            value: {}
        }
    },

    /**
     * 组件的初始数据
     */
    data: {
        favor: false,
    },
    pageLifetimes: {
        show: function() {
            let states = app.globalData.favorMusics;
            let index = this.properties.item.id;
            this.setData({
                favor: states.musics[index],
                counterId: states.counterIds[index],
            }) 
        }
    },
    /**
     * 组件的方法列表
     */
    methods: {
        handleClick: function() {
            var musicPlayer = app.globalData.musicPlayer;
            console.log(musicPlayer);

            //更新全局播放器变量的数据
            app.globalData.playState = 1;
            app.globalData.musicPic = this.properties.item.poster;
            app.globalData.musicName = this.properties.item.name;
            app.globalData.musicUrl = this.properties.item.src;
            app.globalData.artistName = this.properties.singer;
            //同步当前页播放器的数据
            musicPlayer.setData ({
                playState: app.globalData.playState,
                musicPic: app.globalData.musicPic,
                musicName: app.globalData.musicName,
                musicUrl: app.globalData.musicUrl,
                artistName: app.globalData.artistName,
            })
            //数据更新完毕，切换歌曲
            musicPlayer.change();
        },
        handleFavor: function() {
            this.setData({
                favor: !this.data.favor
            })
            console.log(this.data.favor)
            if (this.data.favor) {
                this.favorMusic();
            } else {
                this.disfavorMusic();
            }
        },
        //收藏音乐，更新全局变量并添加至云数据库
        favorMusic: function() {
            //添加至云数据库
            const db = wx.cloud.database({
                env: 'cloud1-0gmvawbtf2ca9f59'
            });
            db.collection('music_favor').add({
                data: {
                    sid: this.properties.item.id,
                    singer: this.properties.singer,
                    favor: true
                },
                success: res => {
                    //在返回结果中会包含新创建的记录的_id
                    this.setData ({
                        counterId: res._id,
                        count: 1
                    })
                    wx.showToast({
                      title: '已收藏',
                    })
                    console.log('[数据库][新增记录]成功，记录 _id: ',res._id)
                    //更新全局变量
                    app.globalData.favorMusics.musics[this.properties.item.id] = true
                    app.globalData.favorMusics.counterIds[this.properties.item.id] = this.data.counterId
                },
                fail: err => {
                    wx.showToast({
                      icon: 'none',
                      title: '新增记录失败',
                    })
                    console.log('[数据库][新增记录]失败: ',err)
                },
            })
        },
        //取消收藏音乐，更新全局变量并从云数据库删除
        disfavorMusic: function() {
            //从云数据库删除
            if (this.data.counterId) {
                const db = wx.cloud.database({
                    env: 'cloud1-0gmvawbtf2ca9f59'
                });
                db.collection('music_favor').doc(this.data.counterId).remove({
                    success: res => {
                        this.setData ({
                            counterId: '',
                            count: null,
                        })
                        wx.showToast({
                          title: '已取消收藏',
                        }),
                        //更新全局变量
                        app.globalData.favorMusics.musics[this.properties.item.id] = false
                        app.globalData.favorMusics.counterIds[this.properties.item.id] = null
                    },
                    fail: err => {
                        wx.showToast({
                          icon: 'none',
                          title: '删除失败',
                        })
                        console.log('[数据库][删除记录]失败: ',err)
                    },
                })
            } else {
                wx.showToast({
                  title: '无counterID, 该歌曲还未收藏',
                })
            }
        }
    },
    ready: function() {
        console.log(this.properties.item, this.properties.singer);
    }
})
