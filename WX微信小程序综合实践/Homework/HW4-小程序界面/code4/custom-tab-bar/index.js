Component({
    data: {
      selected: 0,
      color: "#7A7E83",
      selectedColor: "#3cc51f",
      list: [{
        pagePath: "/index/index",
        iconPath: "/image/icon_location.png",
        selectedIconPath: "/image/icon_location_HL.png",
        text: "地图"
      }, {
        pagePath: "/index/index2",
        iconPath: "/image/icon_share.png",
        selectedIconPath: "/image/icon_share_HL.png",
        text: "分享"
      }]
    },
    attached() {
    },
    methods: {
      switchTab(e) {
        const data = e.currentTarget.dataset
        const url = data.path
        wx.switchTab({url})
        this.setData({
          selected: data.index
        })
      }
    }
  })