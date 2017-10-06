import Campaign from 'discourse/plugins/autobot/discourse/models/campaign';
import CampaignProvider from 'discourse/plugins/autobot/discourse/models/campaign_provider';
import CampaignSource from 'discourse/plugins/autobot/discourse/models/campaign_source';
import { ajax } from 'discourse/lib/ajax';
import { popupAjaxError } from 'discourse/lib/ajax-error';
import computed from "ember-addons/ember-computed-decorators";

export default Ember.Controller.extend({
  editing: false,

  @computed
  providers() {
    return CampaignProvider.list();
  },

  @computed('editing.provider_id')
  sources(provider_id) {
    if (Ember.isEmpty(provider_id))
      return [];
    return CampaignSource.filterByProvider(parseInt(provider_id));
  },

  @computed('editing.provider_id', 'editing.source_id')
  keyLabel(provider_id, source_id) {
    var provider = CampaignProvider.findById(parseInt(provider_id));
    var source = CampaignSource.findById(parseInt(source_id));
    if (provider && source)
      return 'autobot.campaign.key.' + provider.key + '.' + source.key;
    return null;
  },

  @computed('editing.id')
  commandAction(id) {
    if (id) return 'update';
    return 'create';
  },

  @computed('commandAction')
  commandLabel(action) {
    return 'autobot.campaign.button.' + action;
  },

  @computed('editing.key', 'editing.category_id', 'editing.topic_id')
  saveDisabled(key, category_id, topic_id) {
    return Ember.isEmpty(key) || (Ember.isEmpty(category_id) == Ember.isEmpty(topic_id));
  },

  actions: {
    new() {
      this.set('editing', Campaign.create({}));
    },

    cancel() {
      this.set('editing', false);
    },

    create() {
      const campaign = this.get('editing');

      ajax("/autobot/campaigns.json", {
        method: 'POST',
        data: campaign.getProperties('provider_id', 'source_id', 'key', 'category_id', 'topic_id', 'polling_interval')
      }).then((result) => {
        const model = this.get('model');
        const obj = model.find(x => (x.get('id') === campaign.get('id')));
        model.pushObject(Campaign.create(campaign.getProperties('provider_id', 'source_id', 'key', 'category_id', 'topic_id', 'polling_interval')));
        this.set('editing', false);
      }).catch(popupAjaxError);
    },

    edit(campaign) {
      this.set('editing', campaign);
    },

    delete(campaign) {
      const model = this.get('model');

      ajax("/autobot/campaigns.json", {
        method: 'DELETE',
        data: campaign.getProperties('id')
      }).then(() => {
        const obj = model.find((x) => (x.get('id') === campaign.get('id')));
        model.removeObject(obj);
      }).catch(popupAjaxError);
    },

    update() {
      const campaign = this.get('editing');

      ajax("/autobot/campaigns.json", {
        method: 'PUT',
        data: campaign.getProperties('id', 'provider_id', 'source_id', 'key', 'category_id', 'topic_id', 'polling_interval')
      }).then((result) => {
        const model = this.get('model');
        const obj = model.find(x => (x.get('id') === campaign.get('id')));
        if (obj) {
          obj.setProperties({

          });
        }
        this.set('editing', false);
      }).catch(popupAjaxError);
    }
  }
});
