import Campaign from 'discourse/plugins/autobot/discourse/models/campaign';
import computed from "ember-addons/ember-computed-decorators";

export default Ember.Controller.extend({
  editing: false,

  @computed('editing.topic_id')
  saveDisabled(topic_id) {
    return Ember.isEmpty(topic_id);
  },

  actions: {
    new() {
      this.set('editing', Campaign.create({}));
    },

    cancel() {
      this.set('editing', false);
    },

    save() {
    }
  }
});
