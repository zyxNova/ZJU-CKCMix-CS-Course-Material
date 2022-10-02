// components/itemCard/itemCard.js
Component({
    /**
     * 组件的属性列表
     */
    properties: {
        item: {
            type: Object,
            value: {}
        }
    },

    /**
     * 组件的初始数据
     */
    data: {

    },

    /**
     * 组件的方法列表
     */
    methods: {
        handleHot: function(e) {
            wx.navigateTo({
              url: `../hotDetail/hotDetail?singer=${this.data.item.name}&poster=${this.data.item.src}`,
            })
        }
    }
})
