import Campaign from 'discourse/plugins/autobot/discourse/models/campaign';
import { ajax } from 'discourse/lib/ajax';

export default Discourse.Route.extend({
  model() {
    return ajax("/autobot/campaigns.json").then(result => {
      return result.campaigns.map(v => Campaign.create(v));
    });
  }
});
