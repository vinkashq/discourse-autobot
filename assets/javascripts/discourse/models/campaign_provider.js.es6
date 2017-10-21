import computed from "ember-addons/ember-computed-decorators";
import { on } from 'ember-addons/ember-computed-decorators';

const values = [
  { id: 1, name: 'YouTube', key: 'youtube' },
  { id: 2, name: 'Website', key: 'website' },
  { id: 3, name: 'Twitter', key: 'twitter' }
]

const CampaignProvider = Discourse.Model.extend({
  name: '',
  key: '',

  @on("init")
  _setup() {
    var data = CampaignProvider.findById(this.get('id'));
    this.name = data.name;
    this.key = data.key;
  }
});

CampaignProvider.reopenClass({

  findById(id) {
    if (!id) { return; }

    return values.findBy('id', parseInt(id));
  },

  list() {
    return values;
  }

});

export default CampaignProvider;
