const app = getApp()
Component({
  data: {
    latitude: 23.098994,
    longitude: 113.322520,
    markers: [{
      id :1,
      latitude: 23.098994,
      longitude: 113.322520,
      title: "腾讯大厦"
    }]
  },
  pageLifetimes: {
    show() {
      if (typeof this.getTabBar === 'function' &&
        this.getTabBar()) {
        this.getTabBar().setData({
          selected: 0
        })
      }
    }
  },
  methods:{
    moveToLocation: function (event) {
      console.log(event);
      let that = this;
      wx.getLocation({
        type: 'wgs84',
        success(res) {
          const latitude = res.latitude
          const longitude = res.longitude
          that.setData ({
            latitude: latitude,
            longitude: longitude,
            markers :[{
              id: 1,
              latitude: latitude,
              longitude: longitude,
              title: '当前位置'
            }]
          })
        }
      })
    },
  
    moveBack: function(event) {
      console.log(event);
      this.setData({
        latitude: 23.098994,
        longitude: 113.322520,
        markers: [{
          id :1,
          latitude: 23.098994,
          longitude: 113.322520,
          title: "腾讯大厦"
        }]
      })
    },

    onShareAppMessage() {
      const promise = new Promise(resolve => {
        setTimeout(() => {
          resolve({
            title:'我的位置'
          })
        }, 2000)
      })
      return {
        title :'我的位置',
        path :'/pages/index/index',
        promise
      }
    }
  }
})