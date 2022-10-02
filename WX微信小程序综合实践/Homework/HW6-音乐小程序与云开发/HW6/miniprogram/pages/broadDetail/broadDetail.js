// pages/broadDetail/broadDetail.js
import broadSongList from "../../datas/broadSongList.js";
var app = getApp();
Page({

    /**
     * 页面的初始数据
     */
    data: {
        name: null,
        thumb: null,
        dataSource: [],
    },

    /**
     * 生命周期函数--监听页面加载
     */
    onLoad: function (options) {
        var player = this.selectComponent('#player2');
        console.log(player);
        app.globalData.musicPlayer = player;
        const{
            name,
            thumb
        } = options;
        console.log(name,thumb);
        this.setData({
            name: name,
            thumb: thumb,
        })

        switch (name) {
            case "个性电台":
                this.setData({
                    dataSource: broadSongList.geXingDianTai
                });
                break;
            case "随心听":
                this.setData({
                    dataSource: broadSongList.suiXinTing
                });
                break;
        }
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