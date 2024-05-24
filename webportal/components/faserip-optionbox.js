import Component from '@ember/component';
import EmberObject, { computed } from '@ember/object';
import { inject as service } from '@ember/service';

export default Component.extend({
  editOption: false,
  optionRank: 0,
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
            this.set('optionRank', this.rank);
            this.set('optionNotes', this.notes);
            this.updated();
        },
    
        update() {
            this.set('notes', this.optionNotes);
            this.set('rank', this.optionRank);
            this.set('editOption', false);
            this.updated();
        },

        raise() {
            var ranks = this.optionRanks;
            var index = ranks.indexOf(this.optionRank);
            if (index == -1) {
                this.set('optionRank', ranks[0]);
            } else if (index < ranks.length - 1) {
                this.set('optionRank', ranks[index + 1]);
            }
        },

        lower() {
            var ranks = this.optionRanks;
            var index = ranks.indexOf(this.optionRank);
            if (index > 0) {
                this.set('optionRank', ranks[index - 1]);
            } else {
                this.set('optionRank', 0);
            }
        }
    }
});
