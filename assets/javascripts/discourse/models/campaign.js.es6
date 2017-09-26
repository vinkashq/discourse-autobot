import RestModel from 'discourse/models/rest';
import Category from 'discourse/models/category';
import CampaignProvider from 'discourse/plugins/autobot/discourse/models/campaign_provider';
import computed from "ember-addons/ember-computed-decorators";

export default RestModel.extend({
  provider_id: null,
  source_id: null,
  key: null,
  category_id: null,
  topic_id: null,
  interval: 30,

  @computed('category_id')
  categoryName(categoryId) {
    if (!categoryId) {
      return I18n.t('autobot.choose.all_categories');
    }

    const category = Category.findById(categoryId);
    if (!category) {
      return I18n.t('autobot.choose.deleted_category');
    }

    return category.get('name');
  },

  @computed('provider_id')
  providerName(providerId) {
    CampaignProvider.findById(providerId).name;
  }
});
