export default {
  resource: 'admin.adminPlugins',
  path: '/plugins',
  map() {
    this.route('autobot', function () {
      this.route('campaigns');
    });
  }
};
