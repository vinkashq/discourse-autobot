import computed from "ember-addons/ember-computed-decorators";
import { on } from 'ember-addons/ember-computed-decorators';

const values = [
  { provider_id: 1, id: 1, name: 'Channel', key: 'channel' },
  { provider_id: 2, id: 2, name: 'Feed', key: 'feed' },
  { provider_id: 3, id: 3, name: 'User', key: 'user' },
  { provider_id: 3, id: 4, name: 'Mention', key: 'user' }
]

const CampaignSource = Discourse.Model.extend({
  provider_id: null,
  name: '',
  key: '',

  @on("init")
  _setup() {
    var data = CampaignProvider.findById(this.get('id'));
    this.provider_id = data.provider_id;
    this.name = data.name;
    this.key = data.key;
  }
});

CampaignSource.reopenClass({

  findById(id) {
    if (!id) { return; }

    return values.findBy('id', parseInt(id));
  },

  filterByProvider(id) {
    return values.filter(function (el) {
      return el.provider_id == id;
    });
  },

  list() {
    return values;
  }

});

export default CampaignSource;
