import computed from "ember-addons/ember-computed-decorators";
import { on } from 'ember-addons/ember-computed-decorators';

const CampaignSources = [
  { provider_id: 1, id: 1, name: 'Channel', key: 'channel' }
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

    return CampaignSources.findBy('id', parseInt(id));
  }

});

export default CampaignSource;
