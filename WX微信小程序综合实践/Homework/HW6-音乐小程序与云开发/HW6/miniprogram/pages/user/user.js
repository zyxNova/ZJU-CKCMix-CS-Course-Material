import userList from "../../datas/userList.js";

Page ({
  data: {
    users: [],
    broads: [],
  },

onLoad: function(options) {
    this.setData({
      users: userList.users,
      broads: userList.latest
    });
    console.log(userList);
    console.log(userList.latest);
  }
})