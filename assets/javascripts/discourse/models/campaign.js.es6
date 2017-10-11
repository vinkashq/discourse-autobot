import RestModel from 'discourse/models/rest';
import Category from 'discourse/models/category';
import CampaignProvider from 'discourse/plugins/autobot/discourse/models/campaign_provider';
import CampaignSource from 'discourse/plugins/autobot/discourse/models/campaign_source';
import computed from "ember-addons/ember-computed-decorators";

export default RestModel.extend({
  provider_id: null,
  source_id: null,
  key: null,
  category_id: null,
  topic_id: null,
  polling_interval: 30,
  owner_username: null,

  @computed('category_id')
  categoryName(categoryId) {
    if (!categoryId) {
      return;
    }

    const category = Category.findById(categoryId);
    if (!category) {
      return I18n.t('autobot.choose.deleted_category');
    }

    return category.get('name');
  },

  @computed('provider_id')
  providerName(providerId) {
    if (!providerId)
      return;
    return CampaignProvider.findById(providerId).name;
  },

  @computed('source_id')
  sourceName(sourceId) {
    if (!sourceId)
      return;
    return CampaignSource.findById(sourceId).name;
  }
});
