import RestModel from 'discourse/models/rest';
import Category from 'discourse/models/category';
import computed from "ember-addons/ember-computed-decorators";

export default RestModel.extend({
  source_id: null,
  topic_id: null,
  category_id: null,
  key: null,
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
  }
});