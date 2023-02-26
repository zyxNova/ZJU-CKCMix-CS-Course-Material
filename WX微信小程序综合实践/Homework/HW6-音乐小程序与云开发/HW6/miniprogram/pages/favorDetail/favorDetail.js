import songList from "../../datas/songList.js";
import broadSongList from "../../datas/broadSongList.js";

// pages/favorDetail/favorDetail.js
Page({

    /**
     * 页面的初始数据
     */
    data: {
        dataSource: [],
        singer: null,
        favor: "个人收藏"
    },
    /**
     * 生命周期函数--监听页面加载
     */
    onLoad: function (options) {
        const db = wx.cloud.database({
            env: 'cloud1-0gmvawbtf2ca9f59'
        });
        db.collection('music_favor').field({
                sid: true,
                _id: true,
                singer: true,
                favor: true,
        }).get({
            success: res => {
                var n=res.data.length;
                let song = new Array(n);
                let singer = new Array(n);
                console.log(n);
                for (var i=0;i<n;i++) {
                    singer[i] = res.data[i].singer;
                    switch(res.data[i].singer) {
                        case "李荣浩":
                            song[i]=songList.liRongHao[res.data[i].sid];
                            break;
                        case "许嵩":
                            song[i]=songList.xuSong[res.data[i].sid];
                            break;
                        case"个性电台":
                            song[i]=broadSongList.geXingDianTai[res.data[i].sid];
                            break;
                    }
                }
                this.setData ({
                    dataSource: song
                })
                console.log(this.data.dataSource);
            },
            fail: err => {
                wx.showToast({
                    icon: 'none',
                    title: '查询记录失败',
                })
                console.error('[数据库][查询记录]失败: ', err)
            },
        })
    },

    /**
     * 生命周期函数--监听页面初次渲染完成
     */
    onReady: function () {

    },

    /**
     * 生命周期函数--监听页面显示
     */
    onShow: function () {

    },

    /**
     * 生命周期函数--监听页面隐藏
     */
    onHide: function () {

    },

    /**
     * 生命周期函数--监听页面卸载
     */
    onUnload: function () {

    },

    /**
     * 页面相关事件处理函数--监听用户下拉动作
     */
    onPullDownRefresh: function () {

    },

    /**
     * 页面上拉触底事件的处理函数
     */
    onReachBottom: function () {

    },

    /**
     * 用户点击右上角分享
     */
    onShareAppMessage: function () {

    }
})