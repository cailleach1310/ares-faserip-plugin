import Component from '@ember/component';
import EmberObject, { computed } from '@ember/object';
import { inject as service } from '@ember/service';

export default Component.extend({
  editOption: false,
  optionNotes: "",
  flashMessages: service(),

    optionDesc: computed('name',function() {
      let list = this.list;
      let item = list.findBy('name', this.name);
      if (item) {
        return item.desc;
      } else {
        return null;
     }
    }),

    optionRanks: computed('name',function() {
      let list = this.list;
      let item = list.findBy('name', this.name);
      if (item) {
        return item.ranks;
      } else {
        return null;
     }
    }),

    actions: { 
        edit() {
            this.set('editOption', true);
            this.set('optionNotes', this.notes);
            this.updated();
        },
    
        removeOption() {
            this.set('rank', 0);
            this.updated();
        },

        abilityChanged(val) {
           this.set('rank', val);
           this.updated();
        },

        update() {
           this.set('notes', this.optionNotes);
           this.set('rank', this.rank);
           this.set('editOption', false);
           this.updated();
        }
    }
});
