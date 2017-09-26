import computed from "ember-addons/ember-computed-decorators";
import { on } from 'ember-addons/ember-computed-decorators';

const CampaignProviders = [
  { id: 1, name: 'YouTube', key: 'youtube' }
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

    return CampaignProviders.findBy('id', parseInt(id));
  }

});

export default CampaignProvider;
