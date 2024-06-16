import Component from '@ember/component';
import EmberObject, { computed } from '@ember/object';
import { inject as service } from '@ember/service';

export default Component.extend({
  editPower: false,
  powerNotes: "",
  flashMessages: service(),

   selectedRank: computed('rank',function() {
      let list = this.get('ranks');
      return list.findBy('value', this.rank);
   }),

    powerDesc: computed('name',function() {
      let list = this.list;
      let item = list.findBy('name', this.name);
      if (item) {
        return item.desc;
      } else {
        return null;
     }
    }),

    rankShort: computed('rank',function() {
      let list = this.get('ranks');
      let item = list.findBy('value', this.rank);
      if (item) {
        return item.short;
      } else {
        return null;
     }
    }),

    powerRanks: computed('name',function() {
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
            this.set('editPower', true);
            this.set('rank', this.rank);
            this.set('powerNotes', this.notes);
            this.updated();
        },

       abilityChanged(val) {
          this.set('rank', val.value);
       },
    
       remove(val) {
          this.set('rank', 0);
       },

       update() {
          this.set('notes', this.powerNotes);
          this.set('rank', this.rank);
          this.set('editPower', false);
          this.updated();
       }
    }
});
